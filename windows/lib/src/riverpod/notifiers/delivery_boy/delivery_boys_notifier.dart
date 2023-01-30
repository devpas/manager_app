import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/constants.dart';
import '../../../core/utils/utils.dart';
import '../../../models/models.dart';
import '../../../repository/repository.dart';
import '../../states/states.dart';

class DeliveryBoysNotifier extends StateNotifier<DeliveryBoysState> {
  final UsersRepository _usersRepository;
  int page = 0;
  bool hasMore = true;

  DeliveryBoysNotifier(this._usersRepository)
      : super(const DeliveryBoysState());

  Future<void> fetchDeliveryMen({VoidCallback? checkYourNetwork}) async {
    if (!hasMore || state.isMoreLoading) {
      return;
    }
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      if (page == 0) {
        state = state.copyWith(isLoading: true);
        final response = await _usersRepository.getDeliveryMen(page: ++page);
        response.when(
          success: (data) async {
            state =
                state.copyWith(isLoading: false, deliverymen: data.data ?? []);
            if ((data.data?.length ?? 0) < 14) {
              hasMore = false;
            }
          },
          failure: (failure) {
            state = state.copyWith(isLoading: false);
            debugPrint('==> get delivery men failure: $failure');
          },
        );
      } else {
        state = state.copyWith(isMoreLoading: true);
        final response = await _usersRepository.getDeliveryMen(page: ++page);
        response.when(
          success: (data) async {
            final List<UserData> newList = List.from(state.deliverymen);
            newList.addAll(data.data ?? []);
            state = state.copyWith(isMoreLoading: false, deliverymen: newList);
            if ((data.data?.length ?? 0) < 14) {
              hasMore = false;
            }
          },
          failure: (failure) {
            state = state.copyWith(isMoreLoading: false);
            debugPrint('==> get delivery men failure: $failure');
          },
        );
      }
    } else {
      checkYourNetwork?.call();
    }
  }

  void setUserRole({UserData? userData}) {
    final UserRole activeRole = AppHelpers.getUserRoleEnum(userData?.role);
    state = state.copyWith(
      initialRole: activeRole,
      activeRole: activeRole,
      updatingUser: userData,
    );
  }

  void changeRole(UserRole role) {
    state = state.copyWith(activeRole: role);
  }

  Future<void> saveUserRole({
    VoidCallback? updateDeliveryMen,
    VoidCallback? checkYourNetwork,
  }) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isUpdatingRole: true);
      final response = await _usersRepository.updateUserRole(
        uuid: state.updatingUser?.uuid,
        role: state.activeRole,
      );
      response.when(
        success: (data) {
          state = state.copyWith(isUpdatingRole: false);
          updateDeliveryMen?.call();
        },
        failure: (failure) {
          state = state.copyWith(isUpdatingRole: false);
          debugPrint('==> get order details failure: $failure');
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }

  void updateDeliveryMen(BuildContext context) {
    page = 0;
    hasMore = true;
    fetchDeliveryMen(
      checkYourNetwork: () {
        AppHelpers.showCheckFlash(
          context,
          AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
        );
      },
    );
  }
}
