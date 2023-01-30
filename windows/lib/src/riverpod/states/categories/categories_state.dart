import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../models/models.dart';

part 'categories_state.freezed.dart';

@freezed
class CategoriesState with _$CategoriesState {
  const factory CategoriesState({
    @Default([]) List<CategoryData> categories,
    @Default(false) bool isLoading,
    @Default(false) bool isSaving,
    @Default(false) bool isMoreLoading,
  }) = _CategoriesState;

  const CategoriesState._();
}
