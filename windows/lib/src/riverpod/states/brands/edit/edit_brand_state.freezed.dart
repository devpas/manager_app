// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_brand_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EditBrandState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isSaving => throw _privateConstructorUsedError;
  bool get brandStatus => throw _privateConstructorUsedError;
  String get brandName => throw _privateConstructorUsedError;
  XFile? get brandFile => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EditBrandStateCopyWith<EditBrandState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditBrandStateCopyWith<$Res> {
  factory $EditBrandStateCopyWith(
          EditBrandState value, $Res Function(EditBrandState) then) =
      _$EditBrandStateCopyWithImpl<$Res, EditBrandState>;
  @useResult
  $Res call(
      {bool isLoading,
      bool isSaving,
      bool brandStatus,
      String brandName,
      XFile? brandFile,
      String? imageUrl});
}

/// @nodoc
class _$EditBrandStateCopyWithImpl<$Res, $Val extends EditBrandState>
    implements $EditBrandStateCopyWith<$Res> {
  _$EditBrandStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isSaving = null,
    Object? brandStatus = null,
    Object? brandName = null,
    Object? brandFile = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isSaving: null == isSaving
          ? _value.isSaving
          : isSaving // ignore: cast_nullable_to_non_nullable
              as bool,
      brandStatus: null == brandStatus
          ? _value.brandStatus
          : brandStatus // ignore: cast_nullable_to_non_nullable
              as bool,
      brandName: null == brandName
          ? _value.brandName
          : brandName // ignore: cast_nullable_to_non_nullable
              as String,
      brandFile: freezed == brandFile
          ? _value.brandFile
          : brandFile // ignore: cast_nullable_to_non_nullable
              as XFile?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EditBrandStateImplCopyWith<$Res>
    implements $EditBrandStateCopyWith<$Res> {
  factory _$$EditBrandStateImplCopyWith(_$EditBrandStateImpl value,
          $Res Function(_$EditBrandStateImpl) then) =
      __$$EditBrandStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool isSaving,
      bool brandStatus,
      String brandName,
      XFile? brandFile,
      String? imageUrl});
}

/// @nodoc
class __$$EditBrandStateImplCopyWithImpl<$Res>
    extends _$EditBrandStateCopyWithImpl<$Res, _$EditBrandStateImpl>
    implements _$$EditBrandStateImplCopyWith<$Res> {
  __$$EditBrandStateImplCopyWithImpl(
      _$EditBrandStateImpl _value, $Res Function(_$EditBrandStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isSaving = null,
    Object? brandStatus = null,
    Object? brandName = null,
    Object? brandFile = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(_$EditBrandStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isSaving: null == isSaving
          ? _value.isSaving
          : isSaving // ignore: cast_nullable_to_non_nullable
              as bool,
      brandStatus: null == brandStatus
          ? _value.brandStatus
          : brandStatus // ignore: cast_nullable_to_non_nullable
              as bool,
      brandName: null == brandName
          ? _value.brandName
          : brandName // ignore: cast_nullable_to_non_nullable
              as String,
      brandFile: freezed == brandFile
          ? _value.brandFile
          : brandFile // ignore: cast_nullable_to_non_nullable
              as XFile?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$EditBrandStateImpl extends _EditBrandState {
  const _$EditBrandStateImpl(
      {this.isLoading = false,
      this.isSaving = false,
      this.brandStatus = false,
      this.brandName = '',
      this.brandFile,
      this.imageUrl})
      : super._();

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isSaving;
  @override
  @JsonKey()
  final bool brandStatus;
  @override
  @JsonKey()
  final String brandName;
  @override
  final XFile? brandFile;
  @override
  final String? imageUrl;

  @override
  String toString() {
    return 'EditBrandState(isLoading: $isLoading, isSaving: $isSaving, brandStatus: $brandStatus, brandName: $brandName, brandFile: $brandFile, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditBrandStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isSaving, isSaving) ||
                other.isSaving == isSaving) &&
            (identical(other.brandStatus, brandStatus) ||
                other.brandStatus == brandStatus) &&
            (identical(other.brandName, brandName) ||
                other.brandName == brandName) &&
            (identical(other.brandFile, brandFile) ||
                other.brandFile == brandFile) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, isSaving, brandStatus,
      brandName, brandFile, imageUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EditBrandStateImplCopyWith<_$EditBrandStateImpl> get copyWith =>
      __$$EditBrandStateImplCopyWithImpl<_$EditBrandStateImpl>(
          this, _$identity);
}

abstract class _EditBrandState extends EditBrandState {
  const factory _EditBrandState(
      {final bool isLoading,
      final bool isSaving,
      final bool brandStatus,
      final String brandName,
      final XFile? brandFile,
      final String? imageUrl}) = _$EditBrandStateImpl;
  const _EditBrandState._() : super._();

  @override
  bool get isLoading;
  @override
  bool get isSaving;
  @override
  bool get brandStatus;
  @override
  String get brandName;
  @override
  XFile? get brandFile;
  @override
  String? get imageUrl;
  @override
  @JsonKey(ignore: true)
  _$$EditBrandStateImplCopyWith<_$EditBrandStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
