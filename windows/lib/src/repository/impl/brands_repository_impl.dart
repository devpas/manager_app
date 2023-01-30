import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../core/di/injection.dart';
import '../../core/handlers/handlers.dart';
import '../../core/utils/utils.dart';
import '../brands_repository.dart';
import '../../models/models.dart';

class BrandsRepositoryImpl extends BrandsRepository {
  @override
  Future<ApiResult<BrandsResponse>> getBrandsPaginate(int page) async {
    final data = {'page': page};
    try {
      final client = inject<HttpService>().client(requireAuth: false);
      final response = await client.get(
        '/api/v1/rest/brands/paginate?perPage=10',
        queryParameters: data,
      );
      return ApiResult.success(
        data: BrandsResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get brands paginate failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<SingleBrandResponse>> createBrand(
    String title,
    int? status,
    String? image,
  ) async {
    final data = image == null
        ? {
            'title': title,
            'active': status ?? 0,
          }
        : {
            'title': title,
            'active': status ?? 0,
            'images[0]': image,
          };
    try {
      final client = inject<HttpService>().client(requireAuth: false);
      final response = await client.post(
        '/api/v1/dashboard/admin/brands',
        queryParameters: data,
      );
      debugPrint('==> create brand: ${response.data}');
      return ApiResult.success(
        data: SingleBrandResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> create brand failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<SingleBrandResponse>> deleteBrand(int brandId) async {
    try {
      final client = inject<HttpService>().client(requireAuth: false);
      final response =
          await client.delete('/api/v1/dashboard/admin/brands/$brandId');
      return ApiResult.success(
        data: SingleBrandResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> delete brand failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<SingleBrandResponse>> getBrand(int? brandId) async {
    try {
      final client = inject<HttpService>().client(requireAuth: false);
      final response =
          await client.get('/api/v1/dashboard/admin/brands/$brandId');
      return ApiResult.success(
        data: SingleBrandResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> get brand failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<SingleBrandResponse>> updateBrand({
    required int brandId,
    required String title,
    bool? status,
    String? image,
  }) async {
    FormData data = FormData.fromMap({});
    if (image == null) {
      if (status == null) {
        data = FormData.fromMap({'title': title, '_method': 'PUT'});
      } else {
        data = FormData.fromMap(
          {'title': title, 'active': status ? 1 : 0, '_method': 'PUT'},
        );
      }
    } else {
      if (status == null) {
        data = FormData.fromMap(
          {'title': title, 'images[0]': image, '_method': 'PUT'},
        );
      } else {
        data = FormData.fromMap(
          {
            'title': title,
            'images[0]': image,
            'active': status ? 1 : 0,
            '_method': 'PUT'
          },
        );
      }
    }
    debugPrint('==> update data: $image');
    debugPrint('==> update data: $title');
    debugPrint('==> update data: $status');
    try {
      final client = inject<HttpService>().client(requireAuth: false);
      final response = await client.post(
        '/api/v1/dashboard/admin/brands/$brandId',
        data: data,
      );
      return ApiResult.success(
        data: SingleBrandResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> update brand failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<BrandSearchResponse>> searchBrands(String? query) async {
    final data = {
      if (query != null) 'search': query,
      'lang': LocalStorage.instance.getLanguage()?.locale,
    };
    try {
      final client = inject<HttpService>().client(requireAuth: true);
      final response = await client.get(
        '/api/v1/rest/brands/paginate',
        queryParameters: data,
      );
      return ApiResult.success(
        data: BrandSearchResponse.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> search brands failure: $e');
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
