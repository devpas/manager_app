import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/constants/constants.dart';
import '../../../models/models.dart';

part 'delivery_boys_state.freezed.dart';

@freezed
class DeliveryBoysState with _$DeliveryBoysState {
  const factory DeliveryBoysState({
    @Default(false) bool isLoading,
    @Default(false) bool isMoreLoading,
    @Default(false) bool isUpdatingRole,
    @Default([]) List<UserData> deliverymen,
    @Default(UserRole.deliveryman) UserRole initialRole,
    @Default(UserRole.deliveryman) UserRole activeRole,
    UserData? updatingUser,
  }) = _DeliveryBoysState;

  const DeliveryBoysState._();
}
