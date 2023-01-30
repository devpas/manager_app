import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../models/models.dart';

part 'edit_category_state.freezed.dart';

@freezed
class EditCategoryState with _$EditCategoryState {
  const factory EditCategoryState({
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
    String? imageUrl,
    XFile? image,
  }) = _EditCategoryState;

  const EditCategoryState._();
}
