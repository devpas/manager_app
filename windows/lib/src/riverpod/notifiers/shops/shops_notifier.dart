import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/handlers/handlers.dart';
import '../../../models/models.dart';
import '../../../repository/repository.dart';
import '../../states/states.dart';

class ShopsNotifier extends StateNotifier<ShopsState> {
  final ShopsRepository _shopsRepository;
  int page = 0;
  bool hasMore = true;

  ShopsNotifier(this._shopsRepository) : super(const ShopsState());

  Future<void> fetchShops() async {
    if (!hasMore || state.isMoreLoading) {
      return;
    }
    if (page == 0) {
      state = state.copyWith(isLoading: true);
      final response = await _shopsRepository.getShopsPaginate(++page);
      response.when(
        success: (data) async {
          state = state.copyWith(isLoading: false, shops: data.shops ?? []);
        },
        failure: (activeFailure) {
          state = state.copyWith(isLoading: false);
          debugPrint('==> get shops failure: $activeFailure');
          if (activeFailure == const NetworkExceptions.unauthorisedRequest()) {
            debugPrint('==> get shops failure: $activeFailure');
          }
        },
      );
    } else {
      state = state.copyWith(isMoreLoading: true);
      final response = await _shopsRepository.getShopsPaginate(++page);
      response.when(
        success: (data) async {
          final List<ShopData> newList = List.from(state.shops);
          newList.addAll(data.shops ?? []);
          state = state.copyWith(isMoreLoading: false, shops: newList);
          if ((data.shops?.length ?? 0) < 10) {
            hasMore = false;
          }
        },
        failure: (activeFailure) {
          state = state.copyWith(isMoreLoading: false);
          debugPrint('==> get new orders failure: $activeFailure');
        },
      );
    }
  }

  Future<void> updateShops() async {
    page = 0;
    hasMore = true;
    await fetchShops();
  }

  Future<void> deleteShop(BuildContext context, String uuid) async {
    state = state.copyWith(isSaving: true);
    final response = await _shopsRepository.deleteShop(uuid);
    response.when(
      success: (deleteData) async {
        state = state.copyWith(isSaving: false);
        updateShops();
        Navigator.pop(context);
      },
      failure: (activeFailure) {
        state = state.copyWith(isSaving: false);
        debugPrint('==> delete shop failure: $activeFailure');
      },
    );
  }

}
