import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../modify/repository/categories_repository.dart';
import '../../../../src/core/handlers/handlers.dart';
import '../../../models/data/category_data.dart';
import '../../states/states.dart';

class CategoriesNotifier extends StateNotifier<CategoriesState> {
  CategoriesNotifier(this._categoriesPASRepository)
      : super(
          const CategoriesState(),
        );

  final CategoriesPASRepository _categoriesPASRepository;

  String keySearch = "";

  CategoryPasData noCategory = CategoryPasData(
      index: -1,
      id: -1,
      name: "Chọn danh mục",
      parentId: -1,
      img: "",
      active: 1);

  void resetSearchKey() {
    state = state.copyWith(categoriesAfterFilter: []);
  }

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

  void filterCategory(String categoryName, List<CategoryPasData> data) {
    print(categoryName);
    if (categoryName.isNotEmpty) {
      data = data
          .where((category) => category.name!.contains(categoryName))
          .toList();
    }
    state = state.copyWith(categoriesAfterFilter: data);
    keySearch = categoryName;
  }

  void setCategorySelected(CategoryPasData category) {
    state = state.copyWith(categorySelected: category);
  }
}
