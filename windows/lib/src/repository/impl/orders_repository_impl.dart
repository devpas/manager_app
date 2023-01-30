import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';
import '../../core/di/injection.dart';
import '../../core/handlers/handlers.dart';
import '../../core/utils/utils.dart';
import '../orders_repository.dart';
import '../../models/models.dart';

class OrdersRepositoryImpl extends OrdersRepository {
  @override
  Future<ApiResult<OrderPaginateResponse>> getCanceledOrders({
    int? page,
    int? userId,
  }) async {
    final data = {
      if (page != null) 'page': page,
      if (userId != null) 'user_id': userId,
      'status': 'canceled',
      'lang': LocalStorage.instance.getLanguage()?.locale,
    };
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/${LocalStorage.instance.getLoginData()?.user?.role}/orders/paginate',
        queryParameters: data,
      );
      return ApiResult.success(
        data: OrderPaginateResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get canceled orders paginate failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<OrderPaginateResponse>> getCompletedOrders({
    int? page,
    int? userId,
  }) async {
    final data = {
      if (page != null) 'page': page,
      if (userId != null) 'user_id': userId,
      'status': 'completed',
      'lang': LocalStorage.instance.getLanguage()?.locale,
    };
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/${LocalStorage.instance.getLoginData()?.user?.role}/orders/paginate',
        queryParameters: data,
      );
      return ApiResult.success(
        data: OrderPaginateResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get completed orders paginate failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<OrderPaginateResponse>> getOpenOrders({
    int? page,
    int? userId,
  }) async {
    final data = {
      if (page != null) 'page': page,
      if (userId != null) 'user_id': userId,
      'status': 'open',
      'lang': LocalStorage.instance.getLanguage()?.locale,
    };
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/${LocalStorage.instance.getLoginData()?.user?.role}/orders/paginate',
        queryParameters: data,
      );
      return ApiResult.success(
        data: OrderPaginateResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get open orders paginate failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<CreateOrderResponse>> createOrder(
      OrderBodyData orderBody) async {
    Map<String, dynamic> orderBodyMap = {
      'user_id': orderBody.userId,
      'total': orderBody.total,
      'currency_id': orderBody.currencyId,
      'rate': orderBody.currencyRate,
    };
    List<Map<String, dynamic>> shops = [];
    for (final shop in orderBody.shops) {
      List<Map<String, dynamic>> products = [];
      for (final product in shop.products) {
        products.add(
          {
            'id': product.stockId,
            'price': product.price,
            'qty': product.quantity,
            'tax': product.tax,
            'discount': product.discount,
            'total_price': product.totalPrice,
          },
        );
      }
      shops.add(
        {
          'shop_id': shop.shopId,
          'delivery_fee': shop.deliveryFee,
          'delivery_type_id': shop.deliveryTypeId,
          if (shop.deliveryAddressId != null)
            'delivery_address_id': shop.deliveryAddressId,
          if (shop.deliveryDate != null) 'delivery_date': shop.deliveryDate,
          if (shop.deliveryTime != null) 'delivery_time': shop.deliveryTime,
          'tax': shop.tax,
          'products': products,
        },
      );
    }
    orderBodyMap.putIfAbsent('shops', () => shops);
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.post(
        '/api/v1/dashboard/${LocalStorage.instance.getLoginData()?.user?.role}/orders',
        data: orderBodyMap,
      );
      return ApiResult.success(
        data: CreateOrderResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> order create failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<OrderDetailsResponse>> getOrderDetails(int? orderId) async {
    final data = {'lang': LocalStorage.instance.getLanguage()?.locale};
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/${LocalStorage.instance.getLoginData()?.user?.role}/orders/$orderId',
        queryParameters: data,
      );
      return ApiResult.success(
        data: OrderDetailsResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get order details failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<OrderStatusResponse>> updateOrderStatus(
    int? orderDetailsId,
    OrderStatus status,
  ) async {
    String? statusText;
    switch (status) {
      case OrderStatus.newOrder:
        statusText = 'new';
        break;
      case OrderStatus.accepted:
        statusText = 'accepted';
        break;
      case OrderStatus.ready:
        statusText = 'ready';
        break;
      case OrderStatus.onAWay:
        statusText = 'on_a_way';
        break;
      case OrderStatus.delivered:
        statusText = 'delivered';
        break;
      case OrderStatus.canceled:
        statusText = 'canceled';
        break;
    }
    final data = {'status': statusText};
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.post(
        '/api/v1/dashboard/${LocalStorage.instance.getLoginData()?.user?.role}/order/details/$orderDetailsId/status',
        data: data,
      );
      return ApiResult.success(
        data: OrderStatusResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> update order details status failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<OrderReviewsResponse>> getOrderReviews({int? page}) async {
    final data = {
      'lang': LocalStorage.instance.getLanguage()?.locale,
      'page': page,
      'type': 'order',
      'perPage': 14,
    };
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/admin/reviews/paginate',
        queryParameters: data,
      );
      return ApiResult.success(
        data: OrderReviewsResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get order reviews failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<void>> deleteOrderReview(int? id) async {
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      await client.delete('/api/v1/dashboard/admin/reviews/$id');
      return const ApiResult.success(data: null);
    } catch (e) {
      debugPrint('==> delete order review failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<OrderPaginateResponse>> getUserOrders({
    int? page,
    int? userId,
  }) async {
    final data = {
      if (page != null) 'page': page,
      if (userId != null) 'user_id': userId,
      'lang': LocalStorage.instance.getLanguage()?.locale,
      'perPage': 10,
    };
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/${LocalStorage.instance.getLoginData()?.user?.role}/orders/paginate',
        queryParameters: data,
      );
      return ApiResult.success(
        data: OrderPaginateResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get user orders paginate failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
