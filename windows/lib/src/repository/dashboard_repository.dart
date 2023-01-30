import '../core/handlers/handlers.dart';
import '../models/models.dart';

abstract class DashboardRepository {
  Future<ApiResult<DashboardCountsResponse>> getDashboardCounts();

  Future<ApiResult<TotalEarningResponse>> getTotalEarnings();

  Future<ApiResult<TopCustomersResponse>> getTopCustomers({int? page});

  Future<ApiResult<ProductsResponse>> getTopSoldProducts({int? page});

  Future<ApiResult<OrdersCountResponse>> getOrdersCount();
}
