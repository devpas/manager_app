import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/constants.dart';
import '../../../core/handlers/handlers.dart';
import '../../../core/utils/utils.dart';
import '../../../models/models.dart';
import '../../../repository/repository.dart';
import '../../states/states.dart';

class PosSystemNotifier extends StateNotifier<PosSystemState> {
  final ProductsRepository _productsRepository;
  final CategoriesRepository _categoriesRepository;
  final BrandsRepository _brandsRepository;
  final ShopsRepository _shopsRepository;
  int page = 0;
  bool hasMore = true;
  Timer? _categoryTimer;
  Timer? _brandTimer;
  Timer? _shopTimer;
  Timer? _productTimer;

  PosSystemNotifier(
    this._productsRepository,
    this._categoriesRepository,
    this._brandsRepository,
    this._shopsRepository,
  ) : super(
          PosSystemState(bags: [PosSystemBagData(index: 0, bagProducts: [])]),
        );

  Future<void> fetchProducts({
    VoidCallback? checkYourNetwork,
  }) async {
    if (!hasMore) {
      return;
    }
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      if (page == 0) {
        state = state.copyWith(isLoading: true);
        final response = await _productsRepository.getProductsPaginate(
          page: ++page,
          brandId: state.selectedBrand != null ? state.selectedBrand!.id : null,
          categoryId: state.selectedCategory != null
              ? state.selectedCategory!.id
              : null,
          shopId: state.selectedShop != null ? state.selectedShop!.id : null,
          query: state.productsQuery.isNotEmpty ? state.productsQuery : null,
        );
        response.when(
          success: (data) async {
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
        final response = await _productsRepository.getProductsPaginate(
          page: ++page,
          brandId: state.selectedBrand != null ? state.selectedBrand!.id : null,
          categoryId: state.selectedCategory != null
              ? state.selectedCategory!.id
              : null,
          shopId: state.selectedShop != null ? state.selectedShop!.id : null,
          query: state.productsQuery.isNotEmpty ? state.productsQuery : null,
        );
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
    } else {
      checkYourNetwork?.call();
    }
  }

  Future<void> fetchCategories({
    VoidCallback? checkYourNetwork,
    String? query,
  }) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(
        isCategoriesLoading: true,
        categories: [],
        categoryQuery: query ?? state.categoryQuery,
      );
      final response = await _categoriesRepository.searchCategory(
          state.categoryQuery.isEmpty ? null : state.categoryQuery);
      response.when(
        success: (data) async {
          state = state.copyWith(
            isCategoriesLoading: false,
            categories: data.data ?? [],
          );
        },
        failure: (failure) {
          state = state.copyWith(isCategoriesLoading: false);
          debugPrint('==> get shops failure: $failure');
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }

  void setCategoryQuery(BuildContext context, String query) {
    if (state.categoryQuery == query) {
      return;
    }
    state = state.copyWith(categoryQuery: query.trim());
    if (_categoryTimer?.isActive ?? false) {
      _categoryTimer?.cancel();
    }
    _categoryTimer = Timer(
      const Duration(milliseconds: 500),
      () {
        fetchCategories(
          checkYourNetwork: () {
            AppHelpers.showCheckFlash(
              context,
              AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
            );
          },
        );
      },
    );
  }

  void setSelectedCategory(CategoryData? category) {
    state = state.copyWith(selectedCategory: category);
  }

  Future<void> fetchBrands({
    VoidCallback? checkYourNetwork,
    String? query,
  }) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(
        isBrandsLoading: true,
        brands: [],
        brandQuery: query ?? state.brandQuery,
      );
      final response = await _brandsRepository
          .searchBrands(state.brandQuery.isEmpty ? null : state.brandQuery);
      response.when(
        success: (data) async {
          state = state.copyWith(
            isBrandsLoading: false,
            brands: data.data ?? [],
          );
        },
        failure: (failure) {
          state = state.copyWith(isBrandsLoading: false);
          debugPrint('==> get brands failure: $failure');
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }

  void setBrandQuery(BuildContext context, String query) {
    if (state.brandQuery == query) {
      return;
    }
    state = state.copyWith(brandQuery: query.trim());
    if (_brandTimer?.isActive ?? false) {
      _brandTimer?.cancel();
    }
    _brandTimer = Timer(
      const Duration(milliseconds: 500),
      () {
        fetchBrands(
          checkYourNetwork: () {
            AppHelpers.showCheckFlash(
              context,
              AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
            );
          },
        );
      },
    );
  }

  void setSelectedBrand(BrandData? brand) {
    state = state.copyWith(selectedBrand: brand);
  }

  Future<void> fetchShops({
    VoidCallback? checkYourNetwork,
    String? query,
  }) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(
        isShopsLoading: true,
        shops: [],
        shopQuery: query ?? state.brandQuery,
      );
      final response = await _shopsRepository
          .searchShops(state.brandQuery.isEmpty ? null : state.brandQuery);
      response.when(
        success: (data) async {
          state = state.copyWith(
            isShopsLoading: false,
            shops: data.shops ?? [],
          );
        },
        failure: (failure) {
          state = state.copyWith(isShopsLoading: false);
          debugPrint('==> get shops failure: $failure');
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }

  void setShopQuery(BuildContext context, String query) {
    if (state.shopQuery == query) {
      return;
    }
    state = state.copyWith(shopQuery: query.trim());
    if (_shopTimer?.isActive ?? false) {
      _shopTimer?.cancel();
    }
    _shopTimer = Timer(
      const Duration(milliseconds: 500),
      () {
        fetchShops(
          checkYourNetwork: () {
            AppHelpers.showCheckFlash(
              context,
              AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
            );
          },
        );
      },
    );
  }

  void setSelectedShop(ShopData? shop) {
    state = state.copyWith(selectedShop: shop);
  }

  void updateProducts(BuildContext context) {
    page = 0;
    hasMore = true;
    fetchProducts(
      checkYourNetwork: () {
        AppHelpers.showCheckFlash(
          context,
          AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
        );
      },
    );
  }

  void setProductQuery(BuildContext context, String query) {
    if (state.productsQuery == query) {
      return;
    }
    state = state.copyWith(productsQuery: query.trim());
    if (_productTimer?.isActive ?? false) {
      _productTimer?.cancel();
    }
    _productTimer = Timer(
      const Duration(milliseconds: 500),
      () {
        updateProducts(context);
      },
    );
  }

  void addNewBag() {
    List<PosSystemBagData> bags = List.from(state.bags);
    bags.add(PosSystemBagData(index: bags.length, bagProducts: []));
    state = state.copyWith(bags: bags);
  }

  void makeSelectedBag(int? bagIndex) {
    state = state.copyWith(activeBagIndex: bagIndex ?? 0);
  }

  void updatePosBag(PosSystemBagData? bag) {
    List<PosSystemBagData> bags = List.from(state.bags);
    int? index;
    for (int i = 0; i < bags.length; i++) {
      if (bag?.index == bags[i].index) {
        index = i;
        break;
      }
    }
    if (index != null) {
      if (bag != null) {
        bags[index] = bag;
      }
      state = state.copyWith(bags: bags);
    }
  }

  void addPosProduct(
    BuildContext context,
    Stocks stock,
    int quantity,
    ProductData product,
  ) {
    List<PosSystemBagData> bags = List.from(state.bags);
    List<PosSystemBagProductData> products =
        List.from(bags[state.activeBagIndex].bagProducts ?? []);
    int? addedIndex;
    for (int i = 0; i < products.length; i++) {
      if (products[i].stock?.id == stock.id &&
          products[i].product?.id == product.id) {
        addedIndex = i;
        break;
      }
    }
    if (addedIndex != null) {
      products.removeAt(addedIndex);
    }
    products.insert(
      0,
      PosSystemBagProductData(
        quantity: quantity,
        stock: stock,
        product: product,
      ),
    );
    bags[state.activeBagIndex] =
        bags[state.activeBagIndex].copyWith(bagProducts: products);
    state = state.copyWith(bags: bags);
  }

  void removeBag(PosSystemBagData? bag) {
    List<PosSystemBagData> bags = List.from(state.bags);
    if (bag != null && bag.index != null) {
      bags.removeAt(bag.index!);
    }
    if (bags.isEmpty) {
      bags.add(PosSystemBagData(index: 0, bagProducts: [], posShops: []));
    }
    state = state.copyWith(bags: bags, activeBagIndex: 0);
  }
}
