import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../models/models.dart';

part 'product_reviews_state.freezed.dart';

@freezed
class ProductReviewsState with _$ProductReviewsState {
  const factory ProductReviewsState({
    @Default(false) bool isLoading,
    @Default(false) bool isMoreLoading,
    @Default(false) bool isDeleting,
    @Default([]) List<ProductReviewData> reviews,
  }) = _ProductReviewsState;

  const ProductReviewsState._();
}
