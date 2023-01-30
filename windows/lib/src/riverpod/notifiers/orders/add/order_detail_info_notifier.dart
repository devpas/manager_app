import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/models.dart';
import '../../../../repository/repository.dart';
import '../../../states/states.dart';

class OrderDetailInfoNotifier extends StateNotifier<OrderDetailInfoState> {
  final ProductsRepository _productsRepository;
  Timer? _timer;

  OrderDetailInfoNotifier(this._productsRepository)
      : super(const OrderDetailInfoState());

  void setQuery(String query) {
    state = state.copyWith(query: query.trim());
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }
    _timer = Timer(
      const Duration(milliseconds: 500),
      () {
        searchProducts();
      },
    );
  }

  Future<void> searchProducts() async {
    state = state.copyWith(isSearching: true);
    final response =
        await _productsRepository.searchProducts(query: state.query);
    response.when(
      success: (data) async {
        state = state.copyWith(
          isSearching: false,
          searchedProducts: data.data ?? [],
        );
      },
      failure: (failure) {
        state = state.copyWith(isSearching: false);
        debugPrint('==> search products failure: $failure');
      },
    );
  }

  List<ProductData> getShopProducts(int shopId) {
    List<ProductData> shopProducts = [];
    for (final product in state.products) {
      if (product.shopId == shopId) {
        shopProducts.add(product);
      }
    }
    return shopProducts;
  }

  double getShopTotal(int shopId) {
    for (final data in state.shopTotals) {
      if (data.id == shopId) {
        return data.total;
      }
    }
    return 0.00;
  }

  num getProductTotal(int id) {
    for (final product
        in state.calculateResponse?.data?.products ?? <CalculatedProduct>[]) {
      if (product.id == id) {
        return product.totalPrice ?? 0.0;
      }
    }
    return 0.00;
  }
}
