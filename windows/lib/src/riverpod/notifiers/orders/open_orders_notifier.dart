import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/models.dart';
import '../../../repository/repository.dart';
import '../../states/states.dart';

class OpenOrdersNotifier extends StateNotifier<OpenOrdersState> {
  final OrdersRepository _ordersRepository;
  int page = 0;
  bool hasMore = true;

  OpenOrdersNotifier(this._ordersRepository) : super(const OpenOrdersState());

  Future<void> fetchOrders({int? userId}) async {
    if (!hasMore || state.isMoreLoading) {
      return;
    }
    if (page == 0) {
      state = state.copyWith(isLoading: true);
      final response =
          await _ordersRepository.getOpenOrders(page: ++page, userId: userId);
      response.when(
        success: (data) async {
          state = state.copyWith(
            isLoading: false,
            orders: data.data ?? [],
          );
        },
        failure: (failure) {
          state = state.copyWith(isLoading: false);
          debugPrint('==> get open orders failure: $failure');
        },
      );
    } else {
      state = state.copyWith(isMoreLoading: true);
      final response =
          await _ordersRepository.getOpenOrders(page: ++page, userId: userId);
      response.when(
        success: (data) async {
          final List<OrderData> newList = List.from(state.orders);
          newList.addAll(data.data ?? []);
          state = state.copyWith(isMoreLoading: false, orders: newList);
          if ((data.data?.length ?? 0) < 10) {
            hasMore = false;
          }
        },
        failure: (activeFailure) {
          state = state.copyWith(isMoreLoading: false);
          debugPrint('==> get open orders failure: $activeFailure');
        },
      );
    }
  }

  Future<void> updateOrders({int? userId}) async {
    page = 0;
    hasMore = true;
    await fetchOrders(userId: userId);
  }
}
