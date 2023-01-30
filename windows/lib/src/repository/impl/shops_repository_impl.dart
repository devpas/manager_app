import 'dart:convert';

import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';
import '../../core/di/injection.dart';
import '../../core/handlers/handlers.dart';
import '../../core/utils/utils.dart';
import '../shops_repository.dart';
import '../../models/models.dart';

class ShopsRepositoryImpl extends ShopsRepository {
  @override
  Future<ApiResult<ShopsPaginateResponse>> getShopsPaginate(int page) async {
    final data = {'page': page};
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/admin/shops/paginate?perPage=10',
        queryParameters: data,
      );
      return ApiResult.success(
        data: ShopsPaginateResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get shops paginate failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<SingleShopResponse>> getSingleShop(String? uuid) async {
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get('/api/v1/dashboard/admin/shops/$uuid');
      return ApiResult.success(
        data: SingleShopResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get shop failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<DemoResponse>> changeStatus(
    String? uuid,
    ShopStatus status,
  ) async {
    var statusText = '';
    switch (status) {
      case ShopStatus.newShop:
        statusText = 'new';
        break;
      case ShopStatus.edited:
        statusText = 'edited';
        break;
      case ShopStatus.approved:
        statusText = 'approved';
        break;
      case ShopStatus.rejected:
        statusText = 'rejected';
        break;
      default:
        statusText = 'new';
        break;
    }
    final query = {'status': statusText};
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.post(
        '/api/v1/dashboard/admin/shops/$uuid/status/change',
        queryParameters: query,
      );
      return ApiResult.success(
        data: DemoResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> status change failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<SingleShopResponse>> deleteShop(String uuid) async {
    try {
      final client = inject<HttpService>().client(requireAuth: false);
      final response =
          await client.delete('/api/v1/dashboard/admin/shops/$uuid');
      return ApiResult.success(
        data: SingleShopResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> delete shop failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<DemoResponse>> updateShop({
    required String? uuid,
    required String title,
    required ShopStatus status,
    required bool visibility,
    required String openTime,
    required String closeTime,
    required String userId,
    required String phone,
    required String description,
    required String minAmount,
    required String tax,
    required String percentage,
    required String address,
    required String deliveryRange,
    required String location,
    String? logoImg,
    String? backImg,
  }) async {
    var statusText = '';
    switch (status) {
      case ShopStatus.newShop:
        statusText = 'new';
        break;
      case ShopStatus.edited:
        statusText = 'edited';
        break;
      case ShopStatus.approved:
        statusText = 'approved';
        break;
      case ShopStatus.rejected:
        statusText = 'rejected';
        break;
      default:
        statusText = 'new';
        break;
    }
    final data = {
      'tax': tax,
      'delivery_range': deliveryRange,
      'percentage': percentage,
      'location': location,
      'phone': phone,
      'min_amount': minAmount,
      'status': statusText,
      'open_time': openTime,
      'close_time': closeTime,
      'visibility': visibility ? 1 : 0,
      'title[en]': title,
      'description[en]': description,
      'address[en]': address,
      'images[0]': logoImg,
      'images[1]': backImg,
    };
    debugPrint('====> update shop ${jsonEncode(data)}');
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.put(
        '/api/v1/dashboard/admin/shops/$uuid',
        queryParameters: data,
      );
      debugPrint('==> update shop success: $response');
      return ApiResult.success(
        data: DemoResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> update shop failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<ShopsPaginateResponse>> searchShops(String? query) async {
    final data = {
      if (query != null) 'search': query,
      'lang': LocalStorage.instance.getLanguage()?.locale,
    };
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get(
        '/api/v1/rest/shops/search',
        queryParameters: data,
      );
      return ApiResult.success(
        data: ShopsPaginateResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> search shops failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<ShopsPaginateResponse>> getShopsByIds(
    List<int> shopIds,
  ) async {
    final data = <String, dynamic>{
      'lang': LocalStorage.instance.getLanguage()?.locale,
    };
    for (int i = 0; i < shopIds.length; i++) {
      data['shops[$i]'] = shopIds[i];
    }
    debugPrint('===> get shops by ids $data');
    try {
      final client = inject<HttpService>().client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/shops',
        queryParameters: data,
      );
      return ApiResult.success(
        data: ShopsPaginateResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get shops by ids failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<ShopDeliveriesResponse>> getOnlyDeliveries() async {
    final data = {
      'currency_id': LocalStorage.instance.getSelectedCurrency()?.id,
    };
    try {
      final client = inject<HttpService>().client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/shops/deliveries',
        queryParameters: data,
      );
      return ApiResult.success(
        data: ShopDeliveriesResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get shops deliveries failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
