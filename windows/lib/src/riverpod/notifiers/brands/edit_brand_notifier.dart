import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/constants/constants.dart';
import '../../../repository/repository.dart';
import '../../states/states.dart';

class EditBrandNotifier extends StateNotifier<EditBrandState> {
  final BrandsRepository _brandsRepository;
  final GalleryRepository _galleryRepository;

  EditBrandNotifier(this._brandsRepository, this._galleryRepository)
      : super(const EditBrandState());

  Future<void> updateBrand(BuildContext context, int id) async {
    state = state.copyWith(isSaving: true);
    String? imageUrl;
    if (state.brandFile != null) {
      final uploadImageResponse = await _galleryRepository.uploadImage(
        state.brandFile!,
        UploadType.brands,
      );
      uploadImageResponse.when(
        success: (uploadData) {
          imageUrl = uploadData.imageData?.title;
        },
        failure: (uploadFailure) {},
      );
    }
    final updateBrandResponse = await _brandsRepository.updateBrand(
      brandId: id,
      title: state.brandName,
      status: state.brandStatus,
      image: imageUrl,
    );
    updateBrandResponse.when(
      success: (data) async {
        state = state.copyWith(isSaving: false);
        context.popRoute(true);
      },
      failure: (activeFailure) {
        state = state.copyWith(isSaving: false);
        debugPrint('==> update brand failure: $activeFailure');
      },
    );
  }

  Future<void> fetchBrandDetails(int? id) async {
    state = state.copyWith(isLoading: true, brandFile: null);
    final response = await _brandsRepository.getBrand(id);
    response.when(
      success: (data) async {
        state = state.copyWith(
          isLoading: false,
          brandName: data.brandData?.title ?? '',
          imageUrl: data.brandData?.img,
          brandStatus: data.brandData?.active ?? false,
        );
      },
      failure: (failure) {
        state = state.copyWith(isLoading: false);
        debugPrint('==> get single brand failure: $failure');
      },
    );
  }

  void setBrandFile(XFile? brandFile) {
    state = state.copyWith(brandFile: brandFile);
  }

  void setBrandName(String name) {
    state = state.copyWith(brandName: name);
  }

  void setBrandStatus(bool status) {
    state = state.copyWith(brandStatus: status);
  }
}
