import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/constants/constants.dart';
import '../../../core/utils/utils.dart';
import '../../../presentation/theme/theme.dart';
import '../../../repository/repository.dart';
import '../../states/states.dart';

class ShopEditNotifier extends StateNotifier<ShopEditState> {
  final ShopsRepository _shopsRepository;
  final GalleryRepository _galleryRepository;

  ShopEditNotifier(this._shopsRepository, this._galleryRepository)
      : super(const ShopEditState());

  Future<void> fetchShopDetails(String? uuid) async {
    state = state.copyWith(
      isLoading: true,
      backFile: null,
      backUrl: null,
      closeController: TextEditingController(),
      openController: TextEditingController(),
      logoUrl: null,
      logoFile: null,
    );
    final response = await _shopsRepository.getSingleShop(uuid);
    response.when(
      success: (data) async {
        debugPrint('==> get shop data: ${data.data?.openTime}');
        var shopStatus = ShopStatus.newShop;
        var statusText = '';
        Color statusColor = AppColors.greenMain;
        switch (data.data?.status) {
          case 'new':
            shopStatus = ShopStatus.newShop;
            statusText = 'New';
            statusColor = AppColors.greenMain;
            break;
          case 'edited':
            shopStatus = ShopStatus.edited;
            statusText = 'Edited';
            statusColor = AppColors.totalPanelGradient1;
            break;
          case 'approved':
            shopStatus = ShopStatus.approved;
            statusText = 'Approved';
            statusColor = AppColors.darkBlue;
            break;
          case 'rejected':
            shopStatus = ShopStatus.rejected;
            statusText = 'Rejected';
            statusColor = AppColors.red;
            break;
          default:
            shopStatus = ShopStatus.newShop;
            statusText = 'New';
            statusColor = AppColors.greenMain;
            break;
        }
        state = state.copyWith(
          isLoading: false,
          shopStatus: shopStatus,
          statusText: statusText,
          singleShopResponse: data,
          statusColor: statusColor,
          logoUrl: data.data?.logoImg,
          backUrl: data.data?.backgroundImg,
          title: data.data?.translation?.title ?? '',
          visibility: data.data?.visibility ?? false,
          shopUserId: data.data?.userId != null ? '${data.data?.userId}' : '',
          phone: data.data?.phone ?? '',
          description: data.data?.translation?.description ?? '',
          minAmount:
              data.data?.minAmount != null ? '${data.data?.minAmount}' : '',
          tax: data.data?.tax != null ? '${data.data?.tax}' : '',
          percentage:
              data.data?.percentage != null ? '${data.data?.percentage}' : '',
          address: data.data?.translation?.address ?? '',
          latitude: data.data?.location?.latitude ?? '',
          longitude: data.data?.location?.longitude ?? '',
          deliveryRange: data.data?.deliveryRange != null
              ? '${data.data?.deliveryRange}'
              : '',
        );
        state.closeController?.text = '${data.data?.closeTime}';
        state.openController?.text = '${data.data?.openTime}';
      },
      failure: (activeFailure) {
        state = state.copyWith(isLoading: false);
        debugPrint('==> get single shop failure: $activeFailure');
      },
    );
  }

  void setLogoFile(XFile? logoFile) {
    state = state.copyWith(logoFile: logoFile);
  }

  void setLogoUrl(String? logoUrl) {
    state = state.copyWith(logoUrl: logoUrl);
  }

  void setBackFile(XFile? file) {
    state = state.copyWith(backFile: file);
  }

  void setBackUrl(String? url) {
    state = state.copyWith(backUrl: url);
  }

  void setShopName(String name) {
    state = state.copyWith(title: name);
  }

  void setVisibility(bool visibility) {
    state = state.copyWith(visibility: visibility);
  }

  void setUserId(String userId) {
    state = state.copyWith(shopUserId: userId);
  }

  void setPhone(String phone) {
    state = state.copyWith(phone: phone);
  }

  void setDescription(String description) {
    state = state.copyWith(description: description);
  }

  void setCloseTime(TimeOfDay? time) {
    final formatted = AppHelpers.getHour(time);
    state.closeController?.text = formatted;
  }

  void setOpenTime(TimeOfDay? time) {
    final formatted = AppHelpers.getHour(time);
    state.openController?.text = formatted;
  }

  void setMinAmount(String minAmount) {
    state = state.copyWith(minAmount: minAmount);
  }

  void setTax(String tax) {
    state = state.copyWith(tax: tax);
  }

  void setPercentage(String percentage) {
    state = state.copyWith(percentage: percentage);
  }

  void setAddress(String address) {
    state = state.copyWith(address: address);
  }

  void setDeliveryRange(String deliveryRange) {
    state = state.copyWith(deliveryRange: deliveryRange);
  }

  void setShopStatus(ShopStatus status) {
    var statusText = '';
    Color statusColor = AppColors.greenMain;
    switch (status) {
      case ShopStatus.newShop:
        statusText = 'New';
        statusColor = AppColors.greenMain;
        break;
      case ShopStatus.edited:
        statusText = 'Edited';
        statusColor = AppColors.totalPanelGradient1;
        break;
      case ShopStatus.approved:
        statusText = 'Approved';
        statusColor = AppColors.darkBlue;
        break;
      case ShopStatus.rejected:
        statusText = 'Rejected';
        statusColor = AppColors.red;
        break;
      default:
        statusText = 'New';
        statusColor = AppColors.greenMain;
        break;
    }
    state = state.copyWith(
      shopStatus: status,
      statusText: statusText,
      statusColor: statusColor,
    );
  }

  Future<void> updateShop(BuildContext context, String? uuid) async {
    state = state.copyWith(isSaving: true);
    String? logoUrl = state.logoUrl;
    String? backUrl = state.backUrl;
    final changeStatusResponse = await _shopsRepository.changeStatus(
      uuid,
      state.shopStatus,
    );
    changeStatusResponse.when(
      success: (data) {
        debugPrint('==> change shop status success: $data');
      },
      failure: (failure) {
        debugPrint('==> upload back error: $failure');
      },
    );
    if (state.logoFile != null) {
      final logoResponse = await _galleryRepository.uploadImage(
          state.logoFile!, UploadType.shopsLogo);
      logoResponse.when(
        success: (data) {
          logoUrl = data.imageData?.title;
        },
        failure: (failure) {
          debugPrint('==> upload logo error: $failure');
        },
      );
    }
    if (state.backFile != null) {
      final backResponse = await _galleryRepository.uploadImage(
          state.backFile!, UploadType.shopsBack);
      backResponse.when(
        success: (data) {
          backUrl = data.imageData?.title;
        },
        failure: (failure) {
          debugPrint('==> upload back error: $failure');
        },
      );
    }

    final updateResponse = await _shopsRepository.updateShop(
      title: state.title,
      uuid: uuid,
      status: state.shopStatus,
      logoImg: logoUrl,
      backImg: backUrl,
      visibility: state.visibility,
      openTime: state.openController?.text ?? '',
      closeTime: state.closeController?.text ?? '',
      description: state.description,
      minAmount: state.minAmount,
      deliveryRange: state.deliveryRange,
      address: state.address,
      phone: state.phone,
      location: '${state.longitude}, ${state.latitude}',
      percentage: state.percentage,
      userId: state.shopUserId,
      tax: state.tax,
    );
    updateResponse.when(
      success: (data) {
        state = state.copyWith(isSaving: false);
        context.popRoute(true);
      },
      failure: (failure) {
        state = state.copyWith(isSaving: false);
        debugPrint('==> update shop error: $failure');
      },
    );
  }
}
