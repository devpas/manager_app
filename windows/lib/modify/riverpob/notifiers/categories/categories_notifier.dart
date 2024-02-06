import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:g_manager_app/modify/models/models.dart';

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

  CategoryPasData noCategory = CategoryPasData(index: -1, id: -1, name: "no category", parentId: -1, img: "", active: 1);

  void resetSearchKey() {
    state = state.copyWith(categoriesAfterFilter: []);
  }

  Future<void> fetchCategories() async {
    state = state.copyWith(categoryLoading: true);
    final response = await _categoriesPASRepository.getCategory("");
    response.when(
      success: (data) async {
        CategoryPasData allCategories = CategoryPasData().copyWith(index: -1, id: -1, name: "no category", parentId: 0, img: "", active: 1);
        data.categories!.insert(0, allCategories);
        state = state.copyWith(categories: data.categories, categoryLoading: false);
        if (data.categories!.isNotEmpty) {
          state = state.copyWith(categorySelected: data.categories![0]);
        }
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
      data = data.where((category) => category.name!.contains(categoryName)).toList();
    }
    state = state.copyWith(categoriesAfterFilter: data);
    keySearch = categoryName;
  }

  void setCategorySelected(CategoryPasData category) {
    state = state.copyWith(categorySelected: category);
  }

  Future<void> addCategory(dynamic dataCategory) async {
    final response = await _categoriesPASRepository.addCategory(dataCategory);
    if (response["msg"] == "create category successful") {
      fetchCategories();
    }
  }

  Future<void> updateCategory(dynamic dataCategory) async {
    final response = await _categoriesPASRepository.updateCategory(dataCategory);
    if (response["msg"] == "update category successful") {
      fetchCategories();
    }
  }

  Future<void> deleteCategory(int categoryId) async {
    final response = await _categoriesPASRepository.deleteCategory(categoryId);
    if (response["msg"] == "delete category successful") {
      fetchCategories();
    }
  }

  void getDataFromAppData(dynamic appData) {
    var categoryData = ApiResult.success(data: CategoriesPasResponse.fromJson(appData["category_data"]));
    categoryData.when(success: (data) async {
      CategoryPasData allCategories = CategoryPasData().copyWith(index: -1, id: -1, name: "no category", parentId: 0, img: "", active: 1);
      data.categories!.insert(0, allCategories);
      state = state.copyWith(categories: data.categories, categorySelected: data.categories![0]);
    }, failure: (e) {
      print(e);
    });
  }
}
