import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../models/models.dart';

part 'products_state.freezed.dart';

@freezed
class ProductsState with _$ProductsState {
  const factory ProductsState({
    @Default([]) List<ProductData> products,
    @Default(false) bool isLoading,
    @Default(false) bool isSaving,
    @Default(false) bool isMoreLoading,
    @Default(false) bool isShopSearching,
    @Default(false) bool isBrandSearching,
    @Default(false) bool isCategorySearching,
    @Default('') String shopQuery,
    @Default('') String brandQuery,
    @Default('') String categoryQuery,
    int? shopId,
    int? categoryId,
    int? brandId,
    @Default([]) List<ShopData> searchedShops,
    @Default([]) List<BrandData> searchedBrands,
    @Default([]) List<CategoryData> searchedCategories,
    String? shopName,
    String? brandName,
    String? categoryName,
    TextEditingController? searchController,
  }) = _ProductsState;

  const ProductsState._();
}
