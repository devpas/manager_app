import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../modify/repository/categories_repository.dart';
import '../../../../src/core/handlers/handlers.dart';
import '../../states/states.dart';

class CategoriesNotifier extends StateNotifier<CategoriesState> {
  CategoriesNotifier(this._categoriesPASRepository)
      : super(
          const CategoriesState(),
        );

  final CategoriesPASRepository _categoriesPASRepository;

  Future<void> fetchCategoriesAppscript() async {
    final response = await _categoriesPASRepository.getCategory("");
    response.when(
      success: (data) async {
        state = state.copyWith(categories: data.categories);
      },
      failure: (failure) {
        if (failure == const NetworkExceptions.unauthorisedRequest()) {
          debugPrint('==> get brands failure: $failure');
        }
      },
    );
  }
}
