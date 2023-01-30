import 'dart:convert';

import 'package:flutter/material.dart';

import '../../core/di/injection.dart';
import '../../core/handlers/handlers.dart';
import '../../core/utils/utils.dart';
import '../products_repository.dart';
import '../../models/models.dart';

class ProductsRepositoryImpl extends ProductsRepository {
  @override
  Future<ApiResult<ProductsResponse>> getProductsPaginate({
    String? query,
    int? shopId,
    int? categoryId,
    int? brandId,
    int? page,
  }) async {
    final data = {
      if (page != null) 'page': page,
      if (shopId != null) 'shop_id': shopId,
      if (brandId != null) 'brand_id': brandId,
      if (categoryId != null) 'category_id': categoryId,
      if (query != null) 'search': query,
      'lang': LocalStorage.instance.getLanguage()?.locale,
      'perPage': 14,
    };
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/${LocalStorage.instance.getLoginData()?.user?.role}/products/paginate',
        queryParameters: data,
      );
      return ApiResult.success(
        data: ProductsResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get products paginate failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<DemoResponse>> createProduct({
    required String tax,
    required String minQuantity,
    required String maxQuantity,
    required int active,
    int? shopId,
    int? categoryId,
    int? brandId,
    required String title,
    required String description,
    String? image,
  }) async {
    final data = {
      'tax': tax,
      'min_qty': minQuantity,
      'max_qty': maxQuantity,
      'active': active,
      'title': {'en': title},
      'description': {'en': description},
      'images': [image],
      'shop_id': shopId,
      'category_id': categoryId,
      'brand_id': brandId,
    };
    debugPrint('===> create product data: ${jsonEncode(data)}');
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.post(
        '/api/v1/dashboard/${LocalStorage.instance.getLoginData()?.user?.role}/products',
        data: data,
      );
      return ApiResult.success(data: DemoResponse.fromJson(response.data));
    } catch (e) {
      debugPrint('==> create products failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<DemoResponse>> deleteProduct(String uuid) async {
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.delete(
        '/api/v1/dashboard/${LocalStorage.instance.getLoginData()?.user?.role}/products/$uuid',
      );
      return ApiResult.success(
        data: DemoResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> delete product failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<SingleProductResponse>> getProduct(String? uuid) async {
    final data = {'lang': LocalStorage.instance.getLanguage()?.locale};
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/${LocalStorage.instance.getLoginData()?.user?.role}/products/$uuid',
        queryParameters: data,
      );
      return ApiResult.success(
        data: SingleProductResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get product failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<DemoResponse>> updateProduct({
    String? uuid,
    required String tax,
    required String minQuantity,
    required String maxQuantity,
    required int active,
    int? shopId,
    int? categoryId,
    int? brandId,
    required String title,
    required String description,
    String? image,
  }) async {
    final data = {
      'tax': tax,
      'min_qty': minQuantity,
      'max_qty': maxQuantity,
      'active': active,
      'title': {'en': title},
      'description': {'en': description},
      'images': [image],
      if (shopId != null) 'shop_id': shopId,
      'category_id': categoryId,
      if (brandId != null) 'brand_id': brandId,
    };
    debugPrint('===> update product data: ${jsonEncode(data)}');
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.put(
        '/api/v1/dashboard/${LocalStorage.instance.getLoginData()?.user?.role}/products/$uuid',
        data: data,
      );
      return ApiResult.success(
        data: DemoResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> update products failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<ProductsResponse>> searchProducts({
    String? query,
    int? shopId,
    int? categoryId,
    int? brandId,
  }) async {
    final data = {
      if (query != null) 'search': query,
      if (shopId != null) 'shop_id': shopId,
      if (categoryId != null) 'category_id': categoryId,
      if (brandId != null) 'brand_id': brandId,
    };
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/${LocalStorage.instance.getLoginData()?.user?.role}/products/search',
        queryParameters: data,
      );
      return ApiResult.success(
        data: ProductsResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> search products failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<ProductCalculateResponse>> getAllCalculations(
    List<OrderCartProductData> orderProducts,
  ) async {
    final data = {
      'currency_id': LocalStorage.instance.getSelectedCurrency()?.id,
    };
    for (int i = 0; i < orderProducts.length; i++) {
      data['products[$i][id]'] = orderProducts[i].stock?.id;
      data['products[$i][quantity]'] = orderProducts[i].quantity;
    }
    try {
      final client = inject<HttpService>().client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/products/calculate',
        queryParameters: data,
      );
      return ApiResult.success(
        data: ProductCalculateResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get all calculations failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<ProductCalculateResponse>> getAllCalculationsInPos(
    List<PosSystemBagProductData> posProducts,
  ) async {
    final data = {
      'currency_id': LocalStorage.instance.getSelectedCurrency()?.id,
    };
    for (int i = 0; i < posProducts.length; i++) {
      data['products[$i][id]'] = posProducts[i].stock?.id;
      data['products[$i][quantity]'] = posProducts[i].quantity;
    }
    try {
      final client = inject<HttpService>().client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/products/calculate',
        queryParameters: data,
      );
      return ApiResult.success(
        data: ProductCalculateResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get all calculations failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<ProductReviewsResponse>> getProductReviews({
    int? page,
  }) async {
    final data = {
      'lang': LocalStorage.instance.getLanguage()?.locale,
      'page': page,
      'type': 'product',
      'perPage': 14,
    };
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get(
        '/api/v1/dashboard/admin/reviews/paginate',
        queryParameters: data,
      );
      return ApiResult.success(
        data: ProductReviewsResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get product reviews failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<void>> deleteProductReview(int? id) async {
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      await client.delete('/api/v1/dashboard/admin/reviews/$id');
      return const ApiResult.success(data: null);
    } catch (e) {
      debugPrint('==> delete product review failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
