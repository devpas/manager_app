import '../../src/core/handlers/handlers.dart';
import '../../modify/models/models.dart';

abstract class CategoriesPASRepository {
  Future<ApiResult<CategoriesPasResponse>> getCategory(String alias);
}
