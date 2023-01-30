import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../models/models.dart';

part 'completed_orders_state.freezed.dart';

@freezed
class CompletedOrdersState with _$CompletedOrdersState {
  const factory CompletedOrdersState({
    @Default([]) List<OrderData> orders,
    @Default(false) bool isLoading,
    @Default(false) bool isMoreLoading,
  }) = _CompletedOrdersState;

  const CompletedOrdersState._();
}
