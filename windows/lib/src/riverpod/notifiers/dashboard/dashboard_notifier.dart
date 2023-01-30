import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/constants.dart';
import '../../../core/handlers/handlers.dart';
import '../../../core/utils/utils.dart';
import '../../../models/models.dart';
import '../../../repository/repository.dart';
import '../../states/states.dart';

class DashboardNotifier extends StateNotifier<DashboardState> {
  final DashboardRepository _dashboardRepository;
  int _customersPage = 0;
  int _productsPage = 0;

  DashboardNotifier(this._dashboardRepository) : super(const DashboardState());

  Future<void> fetchDashboardCounts({VoidCallback? checkYourNetwork}) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isCountsLoading: true);
      final response = await _dashboardRepository.getDashboardCounts();
      response.when(
        success: (data) {
          state = state.copyWith(isCountsLoading: false, countData: data.data);
        },
        failure: (failure) {
          state = state.copyWith(isCountsLoading: false);
          debugPrint('==> get dashboard counts failure: $failure');
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }

  Future<void> fetchTotalEarnings({VoidCallback? checkYourNetwork}) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isTotalEarningsLoading: true);
      final response = await _dashboardRepository.getTotalEarnings();
      response.when(
        success: (data) {
          state = state.copyWith(
            isTotalEarningsLoading: false,
            totalEarningResponse: data,
          );
        },
        failure: (failure) {
          state = state.copyWith(isTotalEarningsLoading: false);
          debugPrint('==> get total earnings failure: $failure');
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }

  Future<void> fetchTopCustomers({
    VoidCallback? checkYourNetwork,
  }) async {
    if (!state.hasMoreCustomers) {
      return;
    }
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      if (_customersPage == 0) {
        state = state.copyWith(isTopCustomersLoading: true);
        final response =
            await _dashboardRepository.getTopCustomers(page: ++_customersPage);
        response.when(
          success: (data) {
            state = state.copyWith(
              isTopCustomersLoading: false,
              topCustomers: data.data ?? [],
              hasMoreCustomers: (data.data ?? []).length >= 5,
            );
          },
          failure: (failure) {
            state = state.copyWith(isTopCustomersLoading: false);
            debugPrint('==> get top customers failure: $failure');
            if (failure == const NetworkExceptions.unauthorisedRequest()) {
              debugPrint('==> get top customers failure: $failure');
            }
          },
        );
      } else {
        state = state.copyWith(isMoreTopCustomersLoading: true);
        final response =
            await _dashboardRepository.getTopCustomers(page: ++_customersPage);
        response.when(
          success: (data) async {
            final List<TopCustomerData> newList = List.from(state.topCustomers);
            newList.addAll(data.data ?? []);
            state = state.copyWith(
              isMoreTopCustomersLoading: false,
              topCustomers: newList,
              hasMoreCustomers: (data.data ?? []).length >= 5,
            );
          },
          failure: (failure) {
            state = state.copyWith(isMoreTopCustomersLoading: false);
            debugPrint('==> get top customers failure: $failure');
          },
        );
      }
    } else {
      checkYourNetwork?.call();
    }
  }

  Future<void> fetchTopProducts({
    VoidCallback? checkYourNetwork,
  }) async {
    if (!state.hasMoreProducts) {
      return;
    }
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      if (_productsPage == 0) {
        state = state.copyWith(isTopProductsLoading: true);
        final response = await _dashboardRepository.getTopSoldProducts(
          page: ++_productsPage,
        );
        response.when(
          success: (data) {
            state = state.copyWith(
              isTopProductsLoading: false,
              topProducts: data.data ?? [],
              hasMoreProducts: (data.data ?? []).length >= 5,
            );
          },
          failure: (failure) {
            state = state.copyWith(isTopProductsLoading: false);
            debugPrint('==> get top products failure: $failure');
            if (failure == const NetworkExceptions.unauthorisedRequest()) {
              debugPrint('==> get top products failure: $failure');
            }
          },
        );
      } else {
        state = state.copyWith(isMoreTopProductsLoading: true);
        final response = await _dashboardRepository.getTopSoldProducts(
          page: ++_productsPage,
        );
        response.when(
          success: (data) async {
            final List<ProductData> newList = List.from(state.topProducts);
            newList.addAll(data.data ?? []);
            state = state.copyWith(
              isMoreTopProductsLoading: false,
              topProducts: newList,
              hasMoreProducts: (data.data ?? []).length >= 5,
            );
          },
          failure: (failure) {
            state = state.copyWith(isMoreTopProductsLoading: false);
            debugPrint('==> get top customers failure: $failure');
          },
        );
      }
    } else {
      checkYourNetwork?.call();
    }
  }

  Future<void> fetchOrderCounts({VoidCallback? checkYourNetwork}) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isOrdersCountLoading: true);
      final response = await _dashboardRepository.getOrdersCount();
      response.when(
        success: (data) {
          state = state.copyWith(
            isOrdersCountLoading: false,
            orderCounts: data.data ?? [],
          );
        },
        failure: (failure) {
          state = state.copyWith(isOrdersCountLoading: false);
          debugPrint('==> get order counts failure: $failure');
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }

  void updateCustomers(BuildContext context) {
    _customersPage = 0;
    state = state.copyWith(hasMoreCustomers: true);
    fetchTopCustomers(
      checkYourNetwork: () {
        AppHelpers.showCheckFlash(
          context,
          AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
        );
      },
    );
  }

  void updateProducts(BuildContext context) {
    debugPrint('===> update products ');
    _productsPage = 0;
    state = state.copyWith(hasMoreProducts: true);
    fetchTopProducts(
      checkYourNetwork: () {
        AppHelpers.showCheckFlash(
          context,
          AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
        );
      },
    );
  }
}
