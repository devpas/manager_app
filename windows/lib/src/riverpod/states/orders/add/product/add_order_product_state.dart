import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../models/models.dart';

part 'add_order_product_state.freezed.dart';

@freezed
class AddOrderProductState with _$AddOrderProductState {
  const factory AddOrderProductState({
    @Default(false) bool isLoading,
    @Default([]) List<TypedExtra> typedExtras,
    @Default([]) List<Stocks> initialStocks,
    @Default([]) List<int> selectedIndexes,
    @Default(0) int stockCount,
    ProductData? product,
    Stocks? selectedStock,
  }) = _AddOrderProductState;

  const AddOrderProductState._();
}