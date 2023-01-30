import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/constants/constants.dart';
import '../../../../models/models.dart';

part 'shop_edit_state.freezed.dart';

@freezed
class ShopEditState with _$ShopEditState {
  const factory ShopEditState({
    @Default(false) bool isLoading,
    @Default(false) bool isSaving,
    @Default(false) bool visibility,
    @Default(ShopStatus.newShop) ShopStatus shopStatus,
    @Default(Color(0xFF16AA16)) Color statusColor,
    @Default('') String statusText,
    @Default('') String title,
    @Default('') String shopUserId,
    @Default('') String phone,
    @Default('') String description,
    @Default('') String minAmount,
    @Default('') String tax,
    @Default('') String percentage,
    @Default('') String address,
    @Default('') String deliveryRange,
    @Default('') String latitude,
    @Default('') String longitude,
    SingleShopResponse? singleShopResponse,
    XFile? logoFile,
    XFile? backFile,
    String? logoUrl,
    String? backUrl,
    TextEditingController? openController,
    TextEditingController? closeController,
  }) = _ShopEditState;

  const ShopEditState._();
}
