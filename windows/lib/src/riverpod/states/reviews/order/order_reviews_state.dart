import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../models/models.dart';

part 'order_reviews_state.freezed.dart';

@freezed
class OrderReviewsState with _$OrderReviewsState {
  const factory OrderReviewsState({
    @Default(false) bool isLoading,
    @Default(false) bool isMoreLoading,
    @Default(false) bool isDeleting,
    @Default([]) List<OrderReviewData> reviews,
  }) = _OrderReviewsState;

  const OrderReviewsState._();
}
