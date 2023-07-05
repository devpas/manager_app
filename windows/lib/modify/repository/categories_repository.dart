import '../../src/core/handlers/handlers.dart';
import '../../modify/models/models.dart';

abstract class CategoriesPASRepository {
  Future<ApiResult<CategoriesPasResponse>> getCategory(String alias);
  Future<dynamic> addCategory(dynamic dataCategory);
  Future<dynamic> updateCategory(dynamic dataCategory);
  Future<dynamic> deleteCategory(int categoryId);
}
