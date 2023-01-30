import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'edit_brand_state.freezed.dart';

@freezed
class EditBrandState with _$EditBrandState {
  const factory EditBrandState({
    @Default(false) bool isLoading,
    @Default(false) bool isSaving,
    @Default(false) bool brandStatus,
    @Default('') String brandName,
    XFile? brandFile,
    String? imageUrl,
  }) = _EditBrandState;

  const EditBrandState._();
}
