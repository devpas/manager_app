import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/utils.dart';
import '../../../../repository/repository.dart';
import '../../../states/states.dart';

class OrderDetailsNotifier extends StateNotifier<OrderDetailsState> {
  final OrdersRepository _ordersRepository;

  OrderDetailsNotifier(this._ordersRepository)
      : super(const OrderDetailsState());

  Future<void> fetchOrderDetails({
    int? orderId,
    VoidCallback? checkYourNetwork,
  }) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isLoading: true);
      final response = await _ordersRepository.getOrderDetails(orderId);
      response.when(
        success: (data) async {
          state = state.copyWith(
            orderDetails: data,
            shopOrderDetails: data.data?.details ?? [],
            isLoading: false,
          );
        },
        failure: (failure) {
          state = state.copyWith(isLoading: false);
          debugPrint('==> get order details failure: $failure');
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }

  Future<void> updateOrderDetails({
    VoidCallback? checkYourNetwork,
  }) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isLoading: true);
      final response =
          await _ordersRepository.getOrderDetails(state.orderDetails?.data?.id);
      response.when(
        success: (data) async {
          state = state.copyWith(
            orderDetails: data,
            shopOrderDetails: data.data?.details ?? [],
            isLoading: false,
          );
        },
        failure: (failure) {
          state = state.copyWith(isLoading: false);
          debugPrint('==> get order details failure: $failure');
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }
}
