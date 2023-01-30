import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../models/models.dart';

part 'pos_system_state.freezed.dart';

@freezed
class PosSystemState with _$PosSystemState {
  const factory PosSystemState({
    @Default(false) bool isLoading,
    @Default(false) bool isMoreLoading,
    @Default(false) bool isCategoriesLoading,
    @Default(false) bool isBrandsLoading,
    @Default(false) bool isShopsLoading,
    @Default([]) List<ProductData> products,
    @Default([]) List<CategoryData> categories,
    @Default([]) List<BrandData> brands,
    @Default([]) List<ShopData> shops,
    @Default([]) List<PosSystemBagData> bags,
    @Default('') String categoryQuery,
    @Default('') String brandQuery,
    @Default('') String shopQuery,
    @Default('') String productsQuery,
    @Default(0) int activeBagIndex,
    CategoryData? selectedCategory,
    BrandData? selectedBrand,
    ShopData? selectedShop,
  }) = _PosSystemState;

  const PosSystemState._();
}
