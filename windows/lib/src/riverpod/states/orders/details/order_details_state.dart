import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../models/models.dart';

part 'order_details_state.freezed.dart';

@freezed
class OrderDetailsState with _$OrderDetailsState {
  const factory OrderDetailsState({
    @Default(false) bool isLoading,
    @Default(false) bool isUpdatingStatus,
    @Default([]) List<ShopOrderDetails> shopOrderDetails,
    OrderDetailsResponse? orderDetails,
  }) = _OrderDetailsState;

  const OrderDetailsState._();
}
