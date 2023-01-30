import 'dart:async';
import 'package:collection/collection.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/constants/constants.dart';
import '../../../repository/repository.dart';
import '../../states/states.dart';

class EditCategoryNotifier extends StateNotifier<EditCategoryState> {
  final CategoriesRepository _categoriesRepository;
  final GalleryRepository _galleryRepository;
  Timer? _timer;

  EditCategoryNotifier(this._categoriesRepository, this._galleryRepository)
      : super(const EditCategoryState());

  Future<void> updateCategory(BuildContext context, String alias) async {
    state = state.copyWith(isSaving: true);
    String? imageUrl = state.imageUrl;
    if (state.image != null) {
      final uploadImageResponse = await _galleryRepository.uploadImage(
        state.image!,
        UploadType.brands,
      );
      uploadImageResponse.when(
        success: (uploadData) {
          imageUrl = uploadData.imageData?.title;
        },
        failure: (uploadFailure) {
          debugPrint('==> upload image failure: $uploadFailure');
        },
      );
    }
    final updateResponse = await _categoriesRepository.updateCategory(
      alias: alias,
      title: state.name,
      status: state.status ? 1 : 0,
      image: imageUrl,
      description: state.description,
      parentId: state.selectedParentId,
      keywords: state.keywords,
    );
    updateResponse.when(
      success: (data) async {
        state = state.copyWith(isSaving: false);
        context.popRoute(true);
      },
      failure: (activeFailure) {
        state = state.copyWith(isSaving: false);
        debugPrint('==> update category failure: $activeFailure');
      },
    );
  }

  Future<void> fetchCategoryDetails(String alias) async {
    state = state.copyWith(isLoading: true, image: null, imageUrl: null);
    final response = await _categoriesRepository.getCategory(alias);
    response.when(
      success: (data) async {
        state = state.copyWith(
          name: data.data?.translation?.title ?? '',
          description: data.data?.translation?.description ?? '',
          imageUrl: data.data?.img,
          status: data.data?.active ?? false,
          selectedParentId: data.data?.parentId ?? 0,
          keywords: (data.data?.keywords ?? '').split(', '),
        );
      },
      failure: (failure) {
        state = state.copyWith(isLoading: false);
        debugPrint('==> get single category failure: $failure');
      },
    );
    final categoriesResponse = await _categoriesRepository.searchCategory('');
    categoriesResponse.when(
      success: (data) {
        final parentName = data.data
            ?.firstWhereOrNull(
                (element) => element.id == state.selectedParentId)
            ?.translation
            ?.title;
        state = state.copyWith(isLoading: false, parentCategory: parentName);
      },
      failure: (failure) {
        state = state.copyWith(isLoading: false);
        debugPrint('==> search categories failure: $failure');
      },
    );
  }

  void setCategoryFile(XFile? brandFile) {
    state = state.copyWith(image: brandFile);
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

  void setSelectedParentId(int parentId) {
    state = state.copyWith(selectedParentId: parentId);
  }

  void setParentCategoryName(String? name) {
    state = state.copyWith(parentCategory: name);
  }
}
