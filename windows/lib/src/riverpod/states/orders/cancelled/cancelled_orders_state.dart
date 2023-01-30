import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../models/models.dart';

part 'cancelled_orders_state.freezed.dart';

@freezed
class CancelledOrdersState with _$CancelledOrdersState {
  const factory CancelledOrdersState({
    @Default([]) List<OrderData> orders,
    @Default(false) bool isLoading,
    @Default(false) bool isMoreLoading,
  }) = _CancelledOrdersState;

  const CancelledOrdersState._();
}
