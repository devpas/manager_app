import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/handlers/handlers.dart';
import '../../../models/models.dart';
import '../../../repository/repository.dart';
import '../../states/states.dart';

class CategoriesNotifier extends StateNotifier<CategoriesState> {
  final CategoriesRepository _categoriesRepository;
  int page = 0;
  bool hasMore = true;

  CategoriesNotifier(this._categoriesRepository)
      : super(const CategoriesState());

  Future<void> fetchCategories() async {
    if (!hasMore || state.isMoreLoading) {
      return;
    }
    if (page == 0) {
      state = state.copyWith(isLoading: true);
      final response =
          await _categoriesRepository.getCategoriesPaginate(++page);
      response.when(
        success: (data) async {
          state = state.copyWith(
              isLoading: false, categories: data.categories ?? []);
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
      final response =
          await _categoriesRepository.getCategoriesPaginate(++page);
      response.when(
        success: (data) async {
          final List<CategoryData> newList = List.from(state.categories);
          newList.addAll(data.categories ?? []);
          state = state.copyWith(isMoreLoading: false, categories: newList);
          if ((data.categories?.length ?? 0) < 10) {
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

  Future<void> updateCategories() async {
    page = 0;
    hasMore = true;
    await fetchCategories();
  }

  Future<void> deleteCategory(BuildContext context, String alias) async {
    state = state.copyWith(isSaving: true);
    final response = await _categoriesRepository.deleteCategory(alias);
    response.when(
      success: (deleteData) async {
        state = state.copyWith(isSaving: false);
        updateCategories();
        Navigator.pop(context);
      },
      failure: (activeFailure) {
        state = state.copyWith(isSaving: false);
        debugPrint('==> delete category failure: $activeFailure');
      },
    );
  }
}
