import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../models/models.dart';

part 'open_orders_state.freezed.dart';

@freezed
class OpenOrdersState with _$OpenOrdersState {
  const factory OpenOrdersState({
    @Default([]) List<OrderData> orders,
    @Default(false) bool isLoading,
    @Default(false) bool isMoreLoading,
  }) = _OpenOrdersState;

  const OpenOrdersState._();
}
