import '../../src/core/handlers/handlers.dart';
import '../../src/models/models.dart';

abstract class CategoriesPASRepository {
  Future<ApiResult<SingleCategoryResponse>> getCategory(String alias);
}
