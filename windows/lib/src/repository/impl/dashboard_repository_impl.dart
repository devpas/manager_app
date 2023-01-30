import 'package:flutter/material.dart';

import '../../core/di/injection.dart';
import '../../core/handlers/handlers.dart';
import '../../core/utils/utils.dart';
import '../../models/models.dart';
import '../dashboard_repository.dart';

class DashboardRepositoryImpl extends DashboardRepository {
  @override
  Future<ApiResult<DashboardCountsResponse>> getDashboardCounts() async {
    final data = {'lang': LocalStorage.instance.getLanguage()?.locale};
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/${LocalStorage.instance.getLoginData()?.user?.role}/statistics/count',
        queryParameters: data,
      );
      return ApiResult.success(
        data: DashboardCountsResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get dashboard count failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<TotalEarningResponse>> getTotalEarnings() async {
    final data = {'lang': LocalStorage.instance.getLanguage()?.locale};
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/${LocalStorage.instance.getLoginData()?.user?.role}/statistics/sum',
        queryParameters: data,
      );
      return ApiResult.success(
        data: TotalEarningResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get total earnings failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<TopCustomersResponse>> getTopCustomers({int? page}) async {
    final data = {
      'lang': LocalStorage.instance.getLanguage()?.locale,
      'time': 'subMonth',
      'perPage': 5,
      if (page != null) 'page': page,
    };
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/${LocalStorage.instance.getLoginData()?.user?.role}/statistics/customer/top',
        queryParameters: data,
      );
      return ApiResult.success(
        data: TopCustomersResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get top customers failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<ProductsResponse>> getTopSoldProducts({int? page}) async {
    final data = {
      'lang': LocalStorage.instance.getLanguage()?.locale,
      'time': 'subMonth',
      'perPage': 5,
      if (page != null) 'page': page,
    };
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/${LocalStorage.instance.getLoginData()?.user?.role}/statistics/products/top',
        queryParameters: data,
      );
      return ApiResult.success(
        data: ProductsResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get top products failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<OrdersCountResponse>> getOrdersCount() async {
    final data = {
      'lang': LocalStorage.instance.getLanguage()?.locale,
      'time': 'subMonth',
    };
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/${LocalStorage.instance.getLoginData()?.user?.role}/statistics/orders/count',
        queryParameters: data,
      );
      return ApiResult.success(
        data: OrdersCountResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get orders count failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
