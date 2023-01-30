import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/constants/constants.dart';
import '../../../repository/repository.dart';
import '../../states/states.dart';
import '../notifiers.dart';

class AddCategoryNotifier extends StateNotifier<AddCategoryState> {
  final CategoriesRepository _categoriesRepository;
  final GalleryRepository _galleryRepository;
  Timer? _timer;

  AddCategoryNotifier(this._categoriesRepository, this._galleryRepository)
      : super(const AddCategoryState());

  Future<void> createNewCategory(
    BuildContext context,
    CategoriesNotifier notifier,
  ) async {
    state = state.copyWith(isSaving: true);
    String? imageUrl;
    if (state.image != null) {
      final uploadImageResponse = await _galleryRepository.uploadImage(
        state.image!,
        UploadType.categories,
      );
      uploadImageResponse.when(
        success: (uploadData) {
          imageUrl = uploadData.imageData?.title;
        },
        failure: (uploadFailure) {
          debugPrint('===> upload category image failure: $uploadFailure');
        },
      );
    }
    final createResponse = await _categoriesRepository.createCategory(
      title: state.name,
      description: state.description,
      status: state.status ? 1 : 0,
      parentId: state.selectedParentId,
      image: imageUrl,
      keywords: state.keywords,
    );
    createResponse.when(
      success: (data) async {
        state = state.copyWith(isSaving: false);
        notifier.updateCategories();
        context.popRoute();
      },
      failure: (activeFailure) {
        state = state.copyWith(isSaving: false);
        debugPrint('==> create category failure: $activeFailure');
      },
    );
  }

  Future<void> searchCategory() async {
    state = state.copyWith(isSearching: true);
    final response = await _categoriesRepository.searchCategory(state.query);
    response.when(
      success: (data) {
        state = state.copyWith(
          searchedCategories: data.data ?? [],
          isSearching: false,
        );
      },
      failure: (failure) {
        debugPrint('==> search category failure: $failure');
        state = state.copyWith(isSearching: false);
      },
    );
  }

  void setCategoryFile(XFile? file) {
    state = state.copyWith(image: file);
  }

  void setCategoryName(String name) {
    state = state.copyWith(name: name);
  }

  void setDescription(String description) {
    state = state.copyWith(description: description);
  }

  void setCategoryStatus(bool status) {
    state = state.copyWith(status: status);
  }

  void setKeywords(List<String> keywords) {
    state = state.copyWith(keywords: keywords);
  }

  void setSelectedParentId(int parentId) {
    state = state.copyWith(selectedParentId: parentId);
  }

  void setParentCategoryName(String? name) {
    state = state.copyWith(parentCategory: name);
  }

  void setQuery(String query) {
    state = state.copyWith(query: query.trim());
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }
    _timer = Timer(
      const Duration(milliseconds: 500),
      () {
        searchCategory();
      },
    );
  }
}
