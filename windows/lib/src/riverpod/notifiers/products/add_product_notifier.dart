import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/constants/constants.dart';
import '../../../core/utils/utils.dart';
import '../../../models/models.dart';
import '../../../repository/repository.dart';
import '../../states/states.dart';

class AddProductNotifier extends StateNotifier<AddProductState> {
  final ProductsRepository _productsRepository;
  final ShopsRepository _shopsRepository;
  final BrandsRepository _brandsRepository;
  final CategoriesRepository _categoriesRepository;
  final GalleryRepository _galleryRepository;
  Timer? _shopTimer;
  Timer? _brandTimer;
  Timer? _categoryTimer;

  AddProductNotifier(
    this._productsRepository,
    this._galleryRepository,
    this._shopsRepository,
    this._brandsRepository,
    this._categoriesRepository,
  ) : super(const AddProductState());

  Future<void> createNewProduct({
    VoidCallback? checkYourNetwork,
    VoidCallback? afterCreating,
  }) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isSaving: true);
      String? imageUrl;
      if (state.image != null) {
        final uploadImageResponse = await _galleryRepository.uploadImage(
          state.image!,
          UploadType.products,
        );
        uploadImageResponse.when(
          success: (uploadData) {
            imageUrl = uploadData.imageData?.title;
          },
          failure: (uploadFailure) {
            debugPrint('===> upload product image failure: $uploadFailure');
          },
        );
      }
      final createResponse = await _productsRepository.createProduct(
        tax: state.tax,
        minQuantity: state.minQuantity,
        description: state.description,
        brandId: state.selectedBrand?.id,
        maxQuantity: state.maxQuantity,
        active: state.active ? 1 : 0,
        shopId: state.selectedShop?.id,
        categoryId: state.selectedCategory?.id,
        title: state.name,
        image: imageUrl,
      );
      createResponse.when(
        success: (data) async {
          state = state.copyWith(isSaving: false);
          afterCreating?.call();
        },
        failure: (activeFailure) {
          state = state.copyWith(isSaving: false);
          debugPrint('==> create product failure: $activeFailure');
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }

  void setImage(XFile? file) {
    state = state.copyWith(image: file);
  }

  void setName(String name) {
    state = state.copyWith(name: name);
  }

  void setDescription(String description) {
    state = state.copyWith(description: description);
  }

  void setTax(String tax) {
    state = state.copyWith(tax: tax);
  }

  void setMinQuantity(String minQuantity) {
    state = state.copyWith(minQuantity: minQuantity);
  }

  void setMaxQuantity(String maxQuantity) {
    state = state.copyWith(maxQuantity: maxQuantity);
  }

  void setActive(bool active) {
    state = state.copyWith(active: active);
  }

  void setSelectedShop(ShopData? shop) {
    state = state.copyWith(selectedShop: shop);
  }

  void setShopQuery(String query) {
    state = state.copyWith(shopQuery: query.trim());
    if (_shopTimer?.isActive ?? false) {
      _shopTimer?.cancel();
    }
    _shopTimer = Timer(
      const Duration(milliseconds: 500),
      () {
        searchShops();
      },
    );
  }

  Future<void> searchShops() async {
    state = state.copyWith(isShopSearching: true);
    final response = await _shopsRepository.searchShops(state.shopQuery);
    response.when(
      success: (data) {
        state = state.copyWith(
          searchedShops: data.shops ?? [],
          isShopSearching: false,
        );
      },
      failure: (failure) {
        debugPrint('==> search shops failure: $failure');
        state = state.copyWith(isShopSearching: false);
      },
    );
  }

  void setSelectBrand(BrandData? brand) {
    state = state.copyWith(selectedBrand: brand);
  }

  void setBrandQuery(String query) {
    state = state.copyWith(brandQuery: query.trim());
    if (_brandTimer?.isActive ?? false) {
      _brandTimer?.cancel();
    }
    _brandTimer = Timer(
      const Duration(milliseconds: 500),
      () {
        searchBrands();
      },
    );
  }

  Future<void> searchBrands() async {
    state = state.copyWith(isBrandSearching: true);
    final response = await _brandsRepository.searchBrands(state.brandQuery);
    response.when(
      success: (data) {
        state = state.copyWith(
          searchedBrands: data.data ?? [],
          isBrandSearching: false,
        );
      },
      failure: (failure) {
        debugPrint('==> search brands failure: $failure');
        state = state.copyWith(isBrandSearching: false);
      },
    );
  }

  void setSelectedCategory(CategoryData? category) {
    state = state.copyWith(selectedCategory: category);
  }

  void setCategoryQuery(String query) {
    state = state.copyWith(categoryQuery: query.trim());
    if (_categoryTimer?.isActive ?? false) {
      _categoryTimer?.cancel();
    }
    _categoryTimer = Timer(
      const Duration(milliseconds: 500),
      () {
        searchCategories();
      },
    );
  }

  Future<void> searchCategories() async {
    state = state.copyWith(isCategorySearching: true);
    final response =
        await _categoriesRepository.searchCategory(state.categoryQuery);
    response.when(
      success: (data) {
        state = state.copyWith(
          searchedCategories: data.data ?? [],
          isCategorySearching: false,
        );
      },
      failure: (failure) {
        debugPrint('==> search categories failure: $failure');
        state = state.copyWith(isCategorySearching: false);
      },
    );
  }
}
