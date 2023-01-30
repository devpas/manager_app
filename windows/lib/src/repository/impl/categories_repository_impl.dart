import 'package:flutter/material.dart';

import '../../core/di/injection.dart';
import '../../core/handlers/handlers.dart';
import '../../core/utils/utils.dart';
import '../categories_repository.dart';
import '../../models/models.dart';

class CategoriesRepositoryImpl extends CategoriesRepository {
  @override
  Future<ApiResult<DemoResponse>> createCategory({
    required String title,
    String? description,
    int? status,
    int? parentId,
    String? image,
    List<String>? keywords,
  }) async {
    final words = keywords?.join(', ');
    final data = {
      'type': 1,
      'keywords': words,
      'active': status,
      'title[en]': title,
      'description[en]': description,
      'images[0]': image,
      'parent_id': parentId,
    };
    debugPrint('==> create category parent: $parentId');
    debugPrint('==> create category data: $data');
    try {
      final client = inject<HttpService>().client(requireAuth: false);
      final response = await client.post(
        '/api/v1/dashboard/admin/categories',
        queryParameters: data,
      );
      return ApiResult.success(
        data: DemoResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> create category failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<DemoResponse>> deleteCategory(String alias) async {
    try {
      final client = inject<HttpService>().client(requireAuth: false);
      final response =
          await client.delete('/api/v1/dashboard/admin/categories/$alias');
      return ApiResult.success(
        data: DemoResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> delete category failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<CategoriesResponse>> getCategoriesPaginate(int page) async {
    final data = {'page': page};
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get(
        '/api/v1/rest/categories/paginate?perPage=10',
        queryParameters: data,
      );
      return ApiResult.success(
        data: CategoriesResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get categories paginate failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<SingleCategoryResponse>> getCategory(String alias) async {
    try {
      final client = inject<HttpService>().client(requireAuth: false);
      final response =
          await client.get('/api/v1/dashboard/admin/categories/$alias');
      return ApiResult.success(
        data: SingleCategoryResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get category failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<DemoResponse>> updateCategory({
    required String alias,
    required String title,
    int? status,
    String? image,
    String? description,
    int? parentId,
    List<String>? keywords,
  }) async {
    final words = keywords?.join(', ');
    final data = {
      'type': 1,
      'keywords': words,
      'active': status,
      'title[en]': title,
      'description[en]': description,
      'images[0]': image,
      'parent_id': parentId,
    };
    debugPrint('==> update category data: $data');
    try {
      final client = inject<HttpService>().client(requireAuth: false);
      final response = await client.put(
        '/api/v1/dashboard/admin/categories/$alias',
        queryParameters: data,
      );
      return ApiResult.success(
        data: DemoResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> update category failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<CategorySearchResponse>> searchCategory(
      String? query) async {
    final data = {
      if (query != null) 'search': query,
      'lang': LocalStorage.instance.getLanguage()?.locale,
    };
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get(
        '/api/v1/rest/categories/search',
        queryParameters: data,
      );
      return ApiResult.success(
        data: CategorySearchResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> search categories failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
