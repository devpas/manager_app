import '../../src/core/handlers/handlers.dart';
import '../../modify/models/models.dart';

abstract class CustomersRepository {
  Future<ApiResult<CustomerResponse>> getListCustomers(String alias);
  Future<ApiResult<ShopResponse>> getListShops(String alias);
  Future<dynamic> addCustomer(dynamic customerData);
  Future<dynamic> updateCustomer(dynamic customerData);
  Future<dynamic> deleteCustomer(dynamic customerId);
}
