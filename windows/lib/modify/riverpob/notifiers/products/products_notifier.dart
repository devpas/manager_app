import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../modify/repository/products_repository.dart';
import '../../../../src/core/handlers/handlers.dart';
import '../../states/states.dart';

class ProductsNotifier extends StateNotifier<ProductsState> {
  ProductsNotifier(this._productsPASRepository)
      : super(
          const ProductsState(),
        );

  final ProductsPASRepository _productsPASRepository;

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
}
