import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../models/models.dart';

part 'add_category_state.freezed.dart';

@freezed
class AddCategoryState with _$AddCategoryState {
  const factory AddCategoryState({
    @Default(false) bool isLoading,
    @Default(false) bool isSaving,
    @Default(false) bool status,
    @Default(false) bool isSearching,
    @Default('') String name,
    @Default('') String description,
    @Default('') String query,
    @Default([]) List<String> keywords,
    @Default([]) List<CategoryData> searchedCategories,
    @Default(0) int selectedParentId,
    String? parentCategory,
    XFile? image,
  }) = _AddCategoryState;

  const AddCategoryState._();
}
