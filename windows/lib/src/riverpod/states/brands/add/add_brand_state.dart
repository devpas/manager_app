import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'add_brand_state.freezed.dart';

@freezed
class AddBrandState with _$AddBrandState {
  const factory AddBrandState({
    @Default(false) bool isLoading,
    @Default(false) bool isSaving,
    @Default(false) bool brandStatus,
    @Default('') String brandName,
    XFile? brandFile,
  }) = _AddBrandState;

  const AddBrandState._();
}
