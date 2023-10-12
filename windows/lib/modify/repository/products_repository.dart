import '../../src/core/handlers/handlers.dart';
import '../../modify/models/models.dart';

abstract class ProductsPASRepository {
  Future<ApiResult<ProductsPasResponse>> getProduct(String alias);
  Future<ApiResult<ProductsPasResponse>> getStockCurrent(String alias);
  Future<dynamic> getListWarehouses();
  Future<dynamic> addWarehouse(dynamic dataWarehouse);
  Future<dynamic> updateWarehouse(dynamic dataWarehouse);
  Future<dynamic> deleteWarehouse(int warehouseId);
  Future<dynamic> updateStockLimit(dynamic stockData);
  Future<dynamic> addStockDiary(dynamic diaryData);
  Future<dynamic> getListTaxCustomer();
  Future<dynamic> addTaxCusCategory(dynamic dataTaxCusCategory);
  Future<dynamic> updateTaxCusCategory(dynamic dataTaxCusCategory);
  Future<dynamic> deleteTaxCusCategory(dynamic taxCusCategoryId);
  Future<dynamic> getListTaxCategories();
  Future<dynamic> addTaxCategory(dynamic dataTaxCategory);
  Future<dynamic> updateTaxCategory(dynamic dataTaxCategory);
  Future<dynamic> deleteTaxCategory(dynamic taxCategoryId);
  Future<dynamic> getListTaxes();
  Future<dynamic> addTax(dynamic dataTax);
  Future<dynamic> updateTax(dynamic dataTax);
  Future<dynamic> deleteTax(dynamic taxId);
  Future<ApiResult<ProductsPasResponse>> addProduct(ProductPasData product);
  Future<ApiResult<ProductsPasResponse>> updateProduct(ProductPasData product);
  Future<ApiResult<ProductsPasResponse>> deleteProduct(int productId);
}
