import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../models/models.dart';

part 'edit_product_state.freezed.dart';

@freezed
class EditProductState with _$EditProductState {
  const factory EditProductState({
    @Default(false) bool isLoading,
    @Default(false) bool isSaving,
    @Default(false) bool active,
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
    ShopData? productShop,
    BrandData? productBrand,
    CategoryData? productCategory,
    String? imageUrl,
    XFile? image,
  }) = _EditProductState;

  const EditProductState._();
}
