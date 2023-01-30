import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/constants/constants.dart';
import '../../../../models/models.dart';

part 'edit_user_state.freezed.dart';

@freezed
class EditUserState with _$EditUserState {
  const factory EditUserState({
    @Default(false) bool isLoading,
    @Default(false) bool isSaving,
    @Default(false) bool isUpdatingRole,
    @Default(false) bool isUploadingImage,
    @Default(false) bool isLoadingWallet,
    @Default(false) bool isLoadingOrders,
    @Default(false) bool isMoreLoadingOrders,
    @Default(UserRole.deliveryman) UserRole activeRole,
    @Default('') String firstname,
    @Default('') String lastname,
    @Default('') String dob,
    @Default('') String gender,
    @Default('') String email,
    @Default('') String phone,
    @Default('') String password,
    @Default('') String confirmPassword,
    @Default([]) List<WalletData> walletHistories,
    @Default([]) List<OrderData> orders,
    UserData? userData,
    String? imageUrl,
    XFile? image,
  }) = _EditUserState;

  const EditUserState._();
}
