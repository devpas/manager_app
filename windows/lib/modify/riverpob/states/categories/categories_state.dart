import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:g_manager_app/modify/models/models.dart';

part 'categories_state.freezed.dart';

@freezed
class CategoriesState with _$CategoriesState {
  const factory CategoriesState(
      {@Default([]) List<CategoryPasData>? categories,
      @Default([]) List<CategoryPasData>? categoriesAfterFilter,
      CategoryPasData? categorySelected}) = _CategoriesState;

  const CategoriesState._();
}
