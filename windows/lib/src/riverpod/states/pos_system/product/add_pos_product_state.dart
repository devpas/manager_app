import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../models/models.dart';

part 'add_pos_product_state.freezed.dart';

@freezed
class AddPosProductState with _$AddPosProductState {
  const factory AddPosProductState({
    @Default(false) bool isLoading,
    @Default([]) List<TypedExtra> typedExtras,
    @Default([]) List<Stocks> initialStocks,
    @Default([]) List<int> selectedIndexes,
    @Default(0) int stockCount,
    ProductData? product,
    Stocks? selectedStock,
  }) = _AddPosProductState;

  const AddPosProductState._();
}