import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/constants/constants.dart';
import '../../../core/utils/utils.dart';
import '../../../models/models.dart';
import '../../../repository/repository.dart';
import '../../states/states.dart';

class EditProductNotifier extends StateNotifier<EditProductState> {
  final ProductsRepository _productsRepository;
  final ShopsRepository _shopsRepository;
  final BrandsRepository _brandsRepository;
  final CategoriesRepository _categoriesRepository;
  final GalleryRepository _galleryRepository;
  Timer? _shopTimer;
  Timer? _brandTimer;
  Timer? _categoryTimer;

  EditProductNotifier(
    this._productsRepository,
    this._shopsRepository,
    this._brandsRepository,
    this._categoriesRepository,
    this._galleryRepository,
  ) : super(const EditProductState());

  Future<void> updateProduct(
    BuildContext context,
    String? uuid, {
    VoidCallback? afterUpdating,
  }) async {
    state = state.copyWith(isSaving: true);
    String? imageUrl = state.imageUrl;
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
          debugPrint('==> upload image failure: $uploadFailure');
        },
      );
    }
    debugPrint('====> product shop id: ${state.productShop?.id}');
    final updateResponse = await _productsRepository.updateProduct(
      uuid: uuid,
      tax: state.tax,
      minQuantity: state.minQuantity,
      maxQuantity: state.maxQuantity,
      active: state.active ? 1 : 0,
      shopId: state.productShop?.id,
      categoryId: state.productCategory?.id,
      brandId: state.productBrand?.id,
      title: state.name,
      description: state.description,
      image: imageUrl,
    );
    updateResponse.when(
      success: (data) async {
        state = state.copyWith(isSaving: false);
        context.popRoute(true);
        afterUpdating?.call();
      },
      failure: (activeFailure) {
        state = state.copyWith(isSaving: false);
        debugPrint('==> update product failure: $activeFailure');
      },
    );
  }

  Future<void> fetchProductDetails({
    String? uuid,
    VoidCallback? checkYourNetwork,
  }) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isLoading: true, image: null, imageUrl: null);
      final response = await _productsRepository.getProduct(uuid);
      response.when(
        success: (data) {
          debugPrint('====> product shop id: ${data.data?.shop?.id}');
          state = state.copyWith(
            name: data.data?.translation?.title ?? '',
            description: data.data?.translation?.description ?? '',
            imageUrl: data.data?.img,
            minQuantity: '${data.data?.minQty ?? ''}',
            maxQuantity: '${data.data?.maxQty ?? ''}',
            active: data.data?.active ?? false,
            productShop: data.data?.shop,
            productBrand: data.data?.brand,
            productCategory: data.data?.category,
            tax: '${data.data?.tax ?? ''}',
            isLoading: false,
          );
        },
        failure: (failure) {
          state = state.copyWith(isLoading: false);
          debugPrint('==> get single category failure: $failure');
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
    state = state.copyWith(tax: tax.trim());
  }

  void setMinQuantity(String minQuantity) {
    state = state.copyWith(minQuantity: minQuantity.trim());
  }

  void setMaxQuantity(String maxQuantity) {
    state = state.copyWith(maxQuantity: maxQuantity.trim());
  }

  void setActive(bool active) {
    state = state.copyWith(active: active);
  }

  void setProductShop(ShopData? shop) {
    state = state.copyWith(productShop: shop);
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

  void setProductBrand(BrandData? brand) {
    state = state.copyWith(productBrand: brand);
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

  void setProductCategory(CategoryData? category) {
    state = state.copyWith(productCategory: category);
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
