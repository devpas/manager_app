import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../models/models.dart';
import '../../../../../repository/repository.dart';
import '../../../../states/states.dart';

class OrderStatusNotifier extends StateNotifier<OrderStatusState> {
  final OrdersRepository _ordersRepository;

  OrderStatusNotifier(this._ordersRepository) : super(const OrderStatusState());

  void setOrderShopDetails({ShopOrderDetails? orderDetails}) {
    final OrderStatus activeStatus =
        AppHelpers.getOrderStatusEnum(orderDetails?.status);
    state = state.copyWith(
      shopOrderDetails: orderDetails,
      activeOrderStatus: activeStatus,
      initialOrderStatus: activeStatus,
    );
  }

  void changeStatus(OrderStatus status) {
    state = state.copyWith(activeOrderStatus: status);
  }

  Future<void> saveOrderStatus({
    VoidCallback? updateOrderDetails,
    VoidCallback? checkYourNetwork,
  }) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isLoading: true);
      final response = await _ordersRepository.updateOrderStatus(
        state.shopOrderDetails?.id,
        state.activeOrderStatus,
      );
      response.when(
        success: (data) {
          state = state.copyWith(isLoading: false);
          updateOrderDetails?.call();
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
