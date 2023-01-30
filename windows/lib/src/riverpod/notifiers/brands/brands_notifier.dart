import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/handlers/handlers.dart';
import '../../../models/models.dart';
import '../../../repository/repository.dart';
import '../../states/states.dart';

class BrandsNotifier extends StateNotifier<BrandsState> {
  final BrandsRepository _brandsRepository;
  int page = 0;
  bool hasMore = true;

  BrandsNotifier(this._brandsRepository) : super(const BrandsState());

  Future<void> fetchBrands() async {
    if (!hasMore || state.isMoreLoading) {
      return;
    }
    if (page == 0) {
      state = state.copyWith(isLoading: true);
      final response = await _brandsRepository.getBrandsPaginate(++page);
      response.when(
        success: (data) async {
          state = state.copyWith(isLoading: false, brands: data.data ?? []);
        },
        failure: (failure) {
          state = state.copyWith(isLoading: false);
          if (failure == const NetworkExceptions.unauthorisedRequest()) {
            debugPrint('==> get brands failure: $failure');
          }
        },
      );
    } else {
      state = state.copyWith(isMoreLoading: true);
      final response = await _brandsRepository.getBrandsPaginate(++page);
      response.when(
        success: (data) async {
          final List<BrandData> newList = List.from(state.brands);
          newList.addAll(data.data ?? []);
          state = state.copyWith(isMoreLoading: false, brands: newList);
          if ((data.data?.length ?? 0) < 10) {
            hasMore = false;
          }
        },
        failure: (activeFailure) {
          state = state.copyWith(isMoreLoading: false);
          debugPrint('==> get brands failure: $activeFailure');
        },
      );
    }
  }

  Future<void> updateBrands() async {
    page = 0;
    hasMore = true;
    await fetchBrands();
  }

  Future<void> deleteBrand(BuildContext context, int brandId) async {
    state = state.copyWith(isSaving: true);
    final deleteResponse = await _brandsRepository.deleteBrand(brandId);
    deleteResponse.when(
      success: (data) async {
        state = state.copyWith(isSaving: false);
        updateBrands();
        Navigator.pop(context);
      },
      failure: (failure) {
        state = state.copyWith(isSaving: false);
        debugPrint('==> delete brand failure: $failure');
      },
    );
  }
}
