import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/constants.dart';
import '../../../core/utils/utils.dart';
import '../../../models/models.dart';
import '../../../repository/repository.dart';
import '../../states/states.dart';

class UsersNotifier extends StateNotifier<UsersState> {
  final UsersRepository _usersRepository;
  int _page = 0;
  bool _hasMore = true;

  UsersNotifier(this._usersRepository) : super(const UsersState());

  Future<void> fetchUsers({VoidCallback? checkYourNetwork}) async {
    if (!_hasMore || state.isMoreLoading) {
      return;
    }
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      if (_page == 0) {
        state = state.copyWith(isLoading: true);
        final response = await _usersRepository.getClients(page: ++_page);
        response.when(
          success: (data) {
            state = state.copyWith(isLoading: false, users: data.data ?? []);
            debugPrint('====> fetch users ${data.data?.length}');
            if ((data.data?.length ?? 0) < 14) {
              _hasMore = false;
            }
          },
          failure: (failure) {
            state = state.copyWith(isLoading: false);
            debugPrint('==> get users failure: $failure');
          },
        );
      } else {
        state = state.copyWith(isMoreLoading: true);
        final response = await _usersRepository.getClients(page: ++_page);
        response.when(
          success: (data) async {
            final List<UserData> newList = List.from(state.users);
            newList.addAll(data.data ?? []);
            state = state.copyWith(isMoreLoading: false, users: newList);
            if ((data.data?.length ?? 0) < 14) {
              _hasMore = false;
            }
          },
          failure: (failure) {
            state = state.copyWith(isMoreLoading: false);
            debugPrint('==> get users failure: $failure');
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
    VoidCallback? updateUsers,
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
          updateUsers?.call();
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

  void updateUsers(BuildContext context) {
    _page = 0;
    _hasMore = true;
    fetchUsers(
      checkYourNetwork: () {
        AppHelpers.showCheckFlash(
          context,
          AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
        );
      },
    );
  }
}
