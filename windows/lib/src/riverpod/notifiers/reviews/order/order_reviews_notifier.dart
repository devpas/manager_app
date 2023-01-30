import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils/utils.dart';
import '../../../../models/models.dart';
import '../../../../repository/repository.dart';
import '../../../states/states.dart';

class OrderReviewsNotifier extends StateNotifier<OrderReviewsState> {
  final OrdersRepository _ordersRepository;
  int _page = 0;
  bool _hasMore = true;

  OrderReviewsNotifier(this._ordersRepository)
      : super(const OrderReviewsState());

  Future<void> fetchOrderReviews({VoidCallback? checkYourNetwork}) async {
    if (!_hasMore || state.isMoreLoading) {
      return;
    }
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      if (_page == 0) {
        state = state.copyWith(isLoading: true);
        final response = await _ordersRepository.getOrderReviews(page: ++_page);
        response.when(
          success: (data) {
            state = state.copyWith(isLoading: false, reviews: data.data ?? []);
            if ((data.data?.length ?? 0) < 14) {
              _hasMore = false;
            }
          },
          failure: (failure) {
            state = state.copyWith(isLoading: false);
            debugPrint('==> get order reviews failure: $failure');
          },
        );
      } else {
        state = state.copyWith(isMoreLoading: true);
        final response = await _ordersRepository.getOrderReviews(page: ++_page);
        response.when(
          success: (data) async {
            final List<OrderReviewData> newList = List.from(state.reviews);
            newList.addAll(data.data ?? []);
            state = state.copyWith(isMoreLoading: false, reviews: newList);
            if ((data.data?.length ?? 0) < 14) {
              _hasMore = false;
            }
          },
          failure: (failure) {
            state = state.copyWith(isMoreLoading: false);
            debugPrint('==> get order reviews failure: $failure');
          },
        );
      }
    } else {
      checkYourNetwork?.call();
    }
  }

  Future<void> deleteReview({
    VoidCallback? updateReviews,
    VoidCallback? checkYourNetwork,
    int? reviewId,
  }) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isDeleting: true);
      final response = await _ordersRepository.deleteOrderReview(reviewId);
      response.when(
        success: (data) {
          state = state.copyWith(isDeleting: false);
          updateReviews?.call();
        },
        failure: (failure) {
          state = state.copyWith(isDeleting: false);
          debugPrint('==> delete review failure: $failure');
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }

  void updateReviews(BuildContext context) {
    _page = 0;
    _hasMore = true;
    fetchOrderReviews(
      checkYourNetwork: () {
        AppHelpers.showCheckFlash(
          context,
          AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
        );
      },
    );
  }
}
