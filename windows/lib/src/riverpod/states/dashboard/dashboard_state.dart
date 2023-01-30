import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../models/models.dart';

part 'dashboard_state.freezed.dart';

@freezed
class DashboardState with _$DashboardState {
  const factory DashboardState({
    @Default(false) bool isCountsLoading,
    @Default(false) bool isTotalEarningsLoading,
    @Default(false) bool isTopCustomersLoading,
    @Default(false) bool isTopProductsLoading,
    @Default(false) bool isOrdersCountLoading,
    @Default(false) bool isMoreTopCustomersLoading,
    @Default(false) bool isMoreTopProductsLoading,
    @Default(true) bool hasMoreCustomers,
    @Default(true) bool hasMoreProducts,
    @Default([]) List<TopCustomerData> topCustomers,
    @Default([]) List<ProductData> topProducts,
    @Default([]) List<OrderCountData> orderCounts,
    DashboardCountData? countData,
    TotalEarningResponse? totalEarningResponse,
  }) = _DashboardState;

  const DashboardState._();
}
