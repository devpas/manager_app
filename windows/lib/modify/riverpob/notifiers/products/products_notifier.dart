import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../modify/repository/products_repository.dart';
import '../../../../src/core/handlers/handlers.dart';
import '../../../models/data/category_data.dart';
import '../../../models/data/product_data.dart';
import '../../states/states.dart';

class ProductsNotifier extends StateNotifier<ProductsState> {
  ProductsNotifier(this._productsPASRepository)
      : super(
          const ProductsState(),
        );

  final ProductsPASRepository _productsPASRepository;

  String keySearch = "";

  Future<void> fetchProducts() async {
    final response = await _productsPASRepository.getProduct("");
    response.when(
      success: (data) async {
        state = state.copyWith(products: data.products);
      },
      failure: (failure) {
        if (failure == const NetworkExceptions.unauthorisedRequest()) {
          debugPrint('==> get brands failure: $failure');
        }
      },
    );
  }

  Future<void> fetchProductsByCategory(int? categoryId) async {
    String alias = "categoryId=$categoryId&";
    final response = await _productsPASRepository.getProduct(alias);
    response.when(
      success: (data) async {
        state = state.copyWith(products: data.products);
      },
      failure: (failure) {
        if (failure == const NetworkExceptions.unauthorisedRequest()) {
          debugPrint('==> get brands failure: $failure');
        }
      },
    );
  }

  void filterProduct(CategoryPasData categorySelected, String productName,
      List<ProductPasData> data) {
    if (categorySelected.id != -1) {
      data = data
          .where((product) => product.categoryId == categorySelected.id)
          .toList();
    }

    if (productName.isNotEmpty) {
      data = data
          .where((product) =>
              product.name!.toLowerCase().contains(productName.toLowerCase()))
          .toList();
    }

    Future.delayed(const Duration(milliseconds: 100), () {
      state = state.copyWith(productsAfterFilter: data);
      keySearch = productName;
    });
  }

  void setProductSelected(ProductPasData product) {
    state = state.copyWith(productsSelected: product);
  }

  Future<void> searchProducts(String codeRef, String? name, String? priceBuy,
      String? priceSell, int? categoryId) async {
    print("${codeRef}-${name}-${priceBuy}-${priceSell}-${categoryId}");

    String alias = "categoryId=$categoryId&";

    print(alias);

    // final response = await _productsPASRepository.getProduct(alias);
    // response.when(
    //   success: (data) async {
    //     state = state.copyWith(products: data.products);
    //   },
    //   failure: (failure) {
    //     if (failure == const NetworkExceptions.unauthorisedRequest()) {
    //       debugPrint('==> get brands failure: $failure');
    //     }
    //   },
    // );
  }
}
