import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/constants.dart';
import '../../../core/utils/utils.dart';
import '../../../models/models.dart';
import '../../../repository/repository.dart';
import '../../states/states.dart';
import '../notifiers.dart';

class OrdersNotifier extends StateNotifier<OrdersState> {
  final UsersRepository _usersRepository;
  Timer? _timer;

  OrdersNotifier(this._usersRepository) : super(const OrdersState());

  Future<void> fetchUsers({
    VoidCallback? checkYourNetwork,
    String? query,
  }) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isUsersLoading: true, query: query ?? state.query);
      final response = await _usersRepository.searchUsers(
        query: state.query.isEmpty ? null : state.query,
      );
      response.when(
        success: (data) async {
          state = state.copyWith(isUsersLoading: false, users: data.data ?? []);
        },
        failure: (failure) {
          state = state.copyWith(isUsersLoading: false);
          debugPrint('==> get users failure: $failure');
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }

  void setQuery(BuildContext context, String query) {
    if (state.query == query) {
      return;
    }
    state = state.copyWith(query: query.trim());
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }
    _timer = Timer(
      const Duration(milliseconds: 500),
      () {
        fetchUsers(
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

  void setSelectedUser(UserData? user) {
    state = state.copyWith(selectedUser: user);
  }

  void clearAll() {
    state = state.copyWith(selectedUser: null);
  }

  void setTabController(TabController controller) {
    state = state.copyWith(tabController: controller);
  }

  void updateOpenOrders({OpenOrdersNotifier? openOrdersNotifier}) {
    if (state.tabController?.index == 0) {
      openOrdersNotifier?.updateOrders();
      return;
    }
    state.tabController?.animateTo(0);
    openOrdersNotifier?.updateOrders();
  }

  void updateCanceledOrders({
    CancelledOrdersNotifier? cancelledOrdersNotifier,
  }) {
    if (state.tabController?.index == 2) {
      cancelledOrdersNotifier?.updateOrders();
      return;
    }
    state.tabController?.animateTo(2);
    cancelledOrdersNotifier?.updateOrders();
  }

  void updateCompletedOrders({
    CompletedOrdersNotifier? completedOrdersNotifier,
  }) {
    if (state.tabController?.index == 1) {
      completedOrdersNotifier?.updateOrders();
      return;
    }
    state.tabController?.animateTo(1);
    completedOrdersNotifier?.updateOrders();
  }
}
