import '../../src/core/handlers/handlers.dart';
import '../../modify/models/models.dart';

abstract class ProductsPASRepository {
  Future<ApiResult<ProductsPasResponse>> getProduct(String alias);
  Future<ApiResult<ProductsPasResponse>> getStockCurrent(String alias);
  Future<ApiResult<ProductsPasResponse>> addProduct(ProductPasData product);
  Future<ApiResult<ProductsPasResponse>> updateProduct(ProductPasData product);
  Future<ApiResult<ProductsPasResponse>> deleteProduct(int productId);
}
