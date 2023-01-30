import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/handlers/handlers.dart';
import '../../../models/models.dart';
import '../../../repository/repository.dart';
import '../../states/states.dart';

class ProductsNotifier extends StateNotifier<ProductsState> {
  final ProductsRepository _productsRepository;
  final ShopsRepository _shopsRepository;
  final BrandsRepository _brandsRepository;
  final CategoriesRepository _categoriesRepository;
  Timer? _timer;
  Timer? _shopTimer;
  Timer? _brandTimer;
  Timer? _categoryTimer;
  int page = 0;
  bool hasMore = true;

  ProductsNotifier(
    this._productsRepository,
    this._shopsRepository,
    this._brandsRepository,
    this._categoriesRepository,
  ) : super(ProductsState(searchController: TextEditingController()));

  Future<void> fetchProducts() async {
    if (!hasMore ||
        state.isMoreLoading ||
        state.searchController!.text.isNotEmpty) {
      return;
    }
    if (page == 0) {
      state = state.copyWith(isLoading: true);
      final response = await _productsRepository.getProductsPaginate(
        page: ++page,
        shopId: state.shopId,
        brandId: state.brandId,
        categoryId: state.categoryId,
      );
      response.when(
        success: (data) {
          state = state.copyWith(isLoading: false, products: data.data ?? []);
        },
        failure: (failure) {
          state = state.copyWith(isLoading: false);
          debugPrint('==> get products failure: $failure');
          if (failure == const NetworkExceptions.unauthorisedRequest()) {
            debugPrint('==> get products failure: $failure');
          }
        },
      );
    } else {
      state = state.copyWith(isMoreLoading: true);
      final response =
          await _productsRepository.getProductsPaginate(page: ++page);
      response.when(
        success: (data) async {
          final List<ProductData> newList = List.from(state.products);
          newList.addAll(data.data ?? []);
          state = state.copyWith(isMoreLoading: false, products: newList);
          if ((data.data?.length ?? 0) < 10) {
            hasMore = false;
          }
        },
        failure: (failure) {
          state = state.copyWith(isMoreLoading: false);
          debugPrint('==> get products failure: $failure');
        },
      );
    }
  }

  Future<void> searchProducts() async {
    state = state.copyWith(isLoading: true);
    final response = await _productsRepository.searchProducts(
        query: state.searchController!.text.trim());
    response.when(
      success: (data) async {
        state = state.copyWith(isLoading: false, products: data.data ?? []);
      },
      failure: (activeFailure) {
        state = state.copyWith(isLoading: false);
        debugPrint('==> search products failure: $activeFailure');
        if (activeFailure == const NetworkExceptions.unauthorisedRequest()) {
          debugPrint('==> get products failure: $activeFailure');
        }
      },
    );
  }

  Future<void> updateProducts() async {
    page = 0;
    hasMore = true;
    state.searchController?.text = '';
    await fetchProducts();
  }

  Future<void> deleteProduct(BuildContext context, String uuid) async {
    state = state.copyWith(isSaving: true);
    final response = await _productsRepository.deleteProduct(uuid);
    response.when(
      success: (data) async {
        state = state.copyWith(isSaving: false);
        Navigator.pop(context);
        updateProducts();
      },
      failure: (activeFailure) {
        state = state.copyWith(isSaving: false);
        debugPrint('==> delete brand failure: $activeFailure');
      },
    );
  }

  void setQuery(String query) {
    state = state.copyWith(
      shopId: null,
      brandId: null,
      categoryId: null,
      brandName: null,
      shopName: null,
      categoryName: null,
    );
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }
    _timer = Timer(
      const Duration(milliseconds: 500),
      () {
        if (query.trim().isEmpty) {
          updateProducts();
        } else {
          searchProducts();
        }
      },
    );
  }

  void setShopName(String? name) {
    state = state.copyWith(shopName: name);
  }

  void setShopId(int? id) {
    state = state.copyWith(shopId: id);
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

  void setBrandName(String? name) {
    state = state.copyWith(brandName: name);
  }

  void setBrandId(int? id) {
    state = state.copyWith(brandId: id);
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

  void setCategoryName(String? name) {
    state = state.copyWith(categoryName: name);
  }

  void setCategoryId(int? id) {
    state = state.copyWith(categoryId: id);
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
