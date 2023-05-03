import 'package:flutter/material.dart';

import '../../../src/core/di/injection.dart';
import '../../../src/core/handlers/handlers.dart';
import '../../../src/core/utils/utils.dart';
import '../../../src/models/models.dart';
import '../categories_repository.dart';
import '../../models/models.dart';

class CategoriesRepositoryPASImpl extends CategoriesPASRepository {
  @override
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
}
