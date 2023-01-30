import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../models/models.dart';

part 'add_product_state.freezed.dart';

@freezed
class AddProductState with _$AddProductState {
  const factory AddProductState({
    @Default(false) bool isSaving,
    @Default(true) bool active,
    @Default(false) bool isShopSearching,
    @Default(false) bool isBrandSearching,
    @Default(false) bool isCategorySearching,
    @Default('') String name,
    @Default('') String description,
    @Default('') String shopQuery,
    @Default('') String brandQuery,
    @Default('') String categoryQuery,
    @Default('') String tax,
    @Default('') String minQuantity,
    @Default('') String maxQuantity,
    @Default([]) List<ShopData> searchedShops,
    @Default([]) List<BrandData> searchedBrands,
    @Default([]) List<CategoryData> searchedCategories,
    ShopData? selectedShop,
    BrandData? selectedBrand,
    CategoryData? selectedCategory,
    XFile? image,
  }) = _AddProductState;

  const AddProductState._();
}
