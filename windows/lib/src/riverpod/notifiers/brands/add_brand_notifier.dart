import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/constants/constants.dart';
import '../../../repository/repository.dart';
import '../../states/states.dart';
import '../notifiers.dart';

class AddBrandNotifier extends StateNotifier<AddBrandState> {
  final BrandsRepository _brandsRepository;
  final GalleryRepository _galleryRepository;

  AddBrandNotifier(this._brandsRepository, this._galleryRepository)
      : super(const AddBrandState());

  Future<void> createNewBrand(BuildContext context,BrandsNotifier notifier) async {
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
    final createBrandResponse = await _brandsRepository.createBrand(
      state.brandName,
      state.brandStatus ? 1 : 0,
      imageUrl,
    );
    createBrandResponse.when(
      success: (data) async {
        state = state.copyWith(isSaving: false);
        notifier.updateBrands();
        context.popRoute();
      },
      failure: (activeFailure) {
        state = state.copyWith(isSaving: false);
        debugPrint('==> create brand failure: $activeFailure');
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
