import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../models/models.dart';

part 'order_status_state.freezed.dart';

@freezed
class OrderStatusState with _$OrderStatusState {
  const factory OrderStatusState({
    @Default(false) bool isLoading,
    @Default(OrderStatus.newOrder) OrderStatus activeOrderStatus,
    @Default(OrderStatus.newOrder) OrderStatus initialOrderStatus,
    ShopOrderDetails? shopOrderDetails,
  }) = _OrderStatusState;

  const OrderStatusState._();
}
