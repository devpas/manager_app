import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../models/models.dart';

part 'shops_state.freezed.dart';

@freezed
class ShopsState with _$ShopsState {
  const factory ShopsState({
    @Default([]) List<ShopData> shops,
    @Default(false) bool isLoading,
    @Default(false) bool isSaving,
    @Default(false) bool isMoreLoading,
  }) = _ShopsState;

  const ShopsState._();
}
