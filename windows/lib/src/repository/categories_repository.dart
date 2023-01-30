import '../core/handlers/handlers.dart';
import '../models/models.dart';

abstract class CategoriesRepository {
  Future<ApiResult<CategoriesResponse>> getCategoriesPaginate(int page);

  Future<ApiResult<DemoResponse>> createCategory({
    required String title,
    String? description,
    int? status,
    int? parentId,
    String? image,
    List<String>? keywords,
  });

  Future<ApiResult<DemoResponse>> deleteCategory(String alias);

  Future<ApiResult<SingleCategoryResponse>> getCategory(String alias);

  Future<ApiResult<CategorySearchResponse>> searchCategory(String? query);

  Future<ApiResult<DemoResponse>> updateCategory({
    required String alias,
    required String title,
    int? status,
    String? description,
    String? image,
    int? parentId,
    List<String>? keywords,
  });
}
