import 'dart:convert';

import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';
import '../../core/di/injection.dart';
import '../../core/handlers/handlers.dart';
import '../../core/utils/utils.dart';
import '../../models/models.dart';
import '../users_repository.dart';

class UsersRepositoryImpl extends UsersRepository {
  @override
  Future<ApiResult<UsersPaginateResponse>> searchUsers({String? query}) async {
    final data = {if (query != null) 'search': query, 'perPage': 14};
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/${LocalStorage.instance.getLoginData()?.user?.role}/users/paginate',
        queryParameters: data,
      );
      return ApiResult.success(
        data: UsersPaginateResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> search users failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<SingleUserResponse>> getUserDetails(String? uuid) async {
    final data = {'lang': LocalStorage.instance.getLanguage()?.locale};
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/${LocalStorage.instance.getLoginData()?.user?.role}/users/$uuid',
        queryParameters: data,
      );
      return ApiResult.success(
        data: SingleUserResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get user details failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<UsersPaginateResponse>> getDeliveryMen({int? page}) async {
    final data = {
      if (page != null) 'page': page,
      'lang': LocalStorage.instance.getLanguage()?.locale,
      'currency_id': LocalStorage.instance.getSelectedCurrency()?.id,
      'role': 'deliveryman',
      'perPage': 14,
    };
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/${LocalStorage.instance.getLoginData()?.user?.role}/users/paginate',
        queryParameters: data,
      );
      return ApiResult.success(
        data: UsersPaginateResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get delivery men failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<SingleUserResponse>> updateUserRole({
    String? uuid,
    UserRole? role,
  }) async {
    String? roleText;
    switch (role) {
      case UserRole.admin:
        roleText = 'admin';
        break;
      case UserRole.seller:
        roleText = 'seller';
        break;
      case UserRole.deliveryman:
        roleText = 'deliveryman';
        break;
      case UserRole.manager:
        roleText = 'manager';
        break;
      case UserRole.user:
        roleText = 'user';
        break;
      default:
        roleText = 'user';
        break;
    }
    final data = {'role': roleText};
    debugPrint('====> update user role ${jsonEncode(data)}');
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.post(
        '/api/v1/dashboard/admin/users/$uuid/role/update',
        data: data,
      );
      return ApiResult.success(
        data: SingleUserResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> update user role failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<SingleUserResponse>> updateUserDetails({
    String? uuid,
    String? firstname,
    String? lastname,
    String? email,
    String? phone,
    String? password,
    String? confirmPassword,
    String? image,
    String? dob,
    String? gender,
  }) async {
    final data = {
      'firstname': firstname,
      'lastname': lastname,
      if (gender != null) 'gender': gender,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (dob != null) 'birthday': dob,
      if (gender != null) 'gender': gender,
      if (password != null) 'password': password,
      if (confirmPassword != null) 'password_confirmation': confirmPassword,
      if (image != null) 'images': [image],
    };
    debugPrint('===> update user details data ${jsonEncode(data)}');
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.put(
        '/api/v1/dashboard/admin/users/$uuid',
        data: data,
      );
      return ApiResult.success(
        data: SingleUserResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> update profile details failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<UsersPaginateResponse>> getClients({int? page}) async {
    final data = {
      if (page != null) 'page': page,
      'lang': LocalStorage.instance.getLanguage()?.locale,
      'role': 'user',
      'perPage': 14,
    };
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/admin/users/paginate',
        queryParameters: data,
      );
      return ApiResult.success(
        data: UsersPaginateResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get clients failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<WalletHistoryResponse>> getWalletHistory({
    String? uuid,
  }) async {
    final data = {'lang': LocalStorage.instance.getLanguage()?.locale};
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/admin/users/$uuid/wallets/history',
        queryParameters: data,
      );
      return ApiResult.success(
        data: WalletHistoryResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get wallet history failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
