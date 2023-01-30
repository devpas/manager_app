import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils/utils.dart';
import '../../../../models/models.dart';
import '../../../../repository/repository.dart';
import '../../../states/states.dart';

class EditUserNotifier extends StateNotifier<EditUserState> {
  final UsersRepository _usersRepository;
  final GalleryRepository _galleryRepository;
  final OrdersRepository _ordersRepository;
  int page = 0;
  bool hasMore = true;

  EditUserNotifier(
    this._usersRepository,
    this._galleryRepository,
    this._ordersRepository,
  ) : super(const EditUserState());

  Future<void> updateUser({
    VoidCallback? checkYourNetwork,
    VoidCallback? afterUpdating,
  }) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(
        isSaving: true,
        isUploadingImage: true,
        isUpdatingRole: true,
      );
      String? imageUrl = state.imageUrl;
      if (state.image != null) {
        final uploadImageResponse = await _galleryRepository.uploadImage(
          state.image!,
          UploadType.users,
        );
        uploadImageResponse.when(
          success: (uploadData) {
            imageUrl = uploadData.imageData?.title;
            state = state.copyWith(isUploadingImage: false);
          },
          failure: (uploadFailure) {
            debugPrint('==> upload image failure: $uploadFailure');
            state = state.copyWith(isUploadingImage: false);
          },
        );
      }
      final updateRoleResponse = await _usersRepository.updateUserRole(
        uuid: state.userData?.uuid,
        role: state.activeRole,
      );
      updateRoleResponse.when(
        success: (roleData) {
          state = state.copyWith(isUpdatingRole: false);
        },
        failure: (roleFailure) {
          state = state.copyWith(isUpdatingRole: false);
          debugPrint('==> update product failure: $roleFailure');
        },
      );
      final updateUserResponse = await _usersRepository.updateUserDetails(
        uuid: state.userData?.uuid,
        firstname: state.firstname,
        lastname: state.lastname,
        email: state.email,
        phone: state.phone,
        password: state.password,
        confirmPassword: state.confirmPassword,
        image: imageUrl,
        dob: state.dob,
        gender: state.gender,
      );
      updateUserResponse.when(
        success: (userData) {
          state = state.copyWith(isSaving: false);
          afterUpdating?.call();
        },
        failure: (userFailure) {
          state = state.copyWith(isSaving: false);
          debugPrint('==> update user failure: $userFailure');
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }

  Future<void> fetchUserDetails({
    String? uuid,
    VoidCallback? checkYourNetwork,
  }) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isLoading: true, image: null, imageUrl: null);
      final response = await _usersRepository.getUserDetails(uuid);
      response.when(
        success: (data) {
          state = state.copyWith(
            firstname: data.data?.firstname ?? '',
            lastname: data.data?.lastname ?? '',
            email: data.data?.email ?? '',
            phone: data.data?.phone ?? '',
            imageUrl: data.data?.img,
            dob: data.data?.birthday?.substring(0, 10) ?? '',
            userData: data.data,
            gender: data.data?.gender ?? '',
            activeRole: AppHelpers.getUserRoleEnum(data.data?.role),
            isLoading: false,
          );
        },
        failure: (failure) {
          state = state.copyWith(isLoading: false);
          debugPrint('==> get user details failure: $failure');
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }

  void setImage(XFile? file) {
    state = state.copyWith(image: file);
  }

  void setFirstname(String name) {
    state = state.copyWith(firstname: name.trim());
  }

  void setLastname(String name) {
    state = state.copyWith(lastname: name.trim());
  }

  void setEmail(String value) {
    state = state.copyWith(email: value.trim());
  }

  void setPhone(String value) {
    state = state.copyWith(phone: value.trim());
  }

  void setUserRole(UserRole role) {
    state = state.copyWith(activeRole: role);
  }

  void setPassword(String value) {
    state = state.copyWith(password: value.trim());
  }

  void setConfirmPassword(String value) {
    state = state.copyWith(confirmPassword: value.trim());
  }

  void setGender(String value) {
    state = state.copyWith(gender: value);
  }

  void setDob(DateTime? date) {
    final String formattedDate =
        DateFormat('yyyy-MM-dd').format(date ?? DateTime.now());
    state = state.copyWith(dob: formattedDate);
  }

  Future<void> fetchWalletHistories({
    VoidCallback? checkYourNetwork,
  }) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isLoadingWallet: true);
      final response =
          await _usersRepository.getWalletHistory(uuid: state.userData?.uuid);
      response.when(
        success: (data) {
          state = state.copyWith(
            walletHistories: data.data ?? [],
            isLoadingWallet: false,
          );
        },
        failure: (failure) {
          state = state.copyWith(isLoadingWallet: false);
          debugPrint('==> get user wallet histories failure: $failure');
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }

  Future<void> fetchUserOrders({VoidCallback? checkYourNetwork}) async {
    if (!hasMore || state.isMoreLoadingOrders) {
      return;
    }
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      if (page == 0) {
        state = state.copyWith(isLoadingOrders: true);
        final response = await _ordersRepository.getUserOrders(
          page: ++page,
          userId: state.userData?.id,
        );
        response.when(
          success: (data) {
            state =
                state.copyWith(isLoadingOrders: false, orders: data.data ?? []);
            if ((data.data?.length ?? 0) < 10) {
              hasMore = false;
            }
          },
          failure: (failure) {
            state = state.copyWith(isLoadingOrders: false);
            debugPrint('==> get user orders failure: $failure');
          },
        );
      } else {
        state = state.copyWith(isMoreLoadingOrders: true);
        final response = await _ordersRepository.getUserOrders(
          page: ++page,
          userId: state.userData?.id,
        );
        response.when(
          success: (data) async {
            final List<OrderData> newList = List.from(state.orders);
            newList.addAll(data.data ?? []);
            state = state.copyWith(isMoreLoadingOrders: false, orders: newList);
            if ((data.data?.length ?? 0) < 10) {
              hasMore = false;
            }
          },
          failure: (failure) {
            state = state.copyWith(isMoreLoadingOrders: false);
            debugPrint('==> get user orders failure: $failure');
          },
        );
      }
    } else {
      checkYourNetwork?.call();
    }
  }

  void updateOrders(BuildContext context) {
    page = 0;
    hasMore = true;
    fetchUserOrders(
      checkYourNetwork: () {
        AppHelpers.showCheckFlash(
          context,
          AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
        );
      },
    );
  }
}
