import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/constants/constants.dart';
import '../../../models/models.dart';

part 'users_state.freezed.dart';

@freezed
class UsersState with _$UsersState {
  const factory UsersState({
    @Default(false) bool isLoading,
    @Default(false) bool isMoreLoading,
    @Default(false) bool isUpdatingRole,
    @Default([]) List<UserData> users,
    @Default(UserRole.deliveryman) UserRole initialRole,
    @Default(UserRole.deliveryman) UserRole activeRole,
    UserData? updatingUser,
  }) = _UsersState;

  const UsersState._();
}
