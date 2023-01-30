import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../models/models.dart';

part 'brands_state.freezed.dart';

@freezed
class BrandsState with _$BrandsState {
  const factory BrandsState({
    @Default([]) List<BrandData> brands,
    @Default(false) bool isLoading,
    @Default(false) bool isSaving,
    @Default(false) bool isMoreLoading,
  }) = _BrandsState;

  const BrandsState._();
}
