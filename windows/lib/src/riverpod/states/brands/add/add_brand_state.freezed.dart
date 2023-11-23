// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_brand_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AddBrandState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isSaving => throw _privateConstructorUsedError;
  bool get brandStatus => throw _privateConstructorUsedError;
  String get brandName => throw _privateConstructorUsedError;
  XFile? get brandFile => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AddBrandStateCopyWith<AddBrandState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddBrandStateCopyWith<$Res> {
  factory $AddBrandStateCopyWith(
          AddBrandState value, $Res Function(AddBrandState) then) =
      _$AddBrandStateCopyWithImpl<$Res, AddBrandState>;
  @useResult
  $Res call(
      {bool isLoading,
      bool isSaving,
      bool brandStatus,
      String brandName,
      XFile? brandFile});
}

/// @nodoc
class _$AddBrandStateCopyWithImpl<$Res, $Val extends AddBrandState>
    implements $AddBrandStateCopyWith<$Res> {
  _$AddBrandStateCopyWithImpl(this._value, this._then);

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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddBrandStateImplCopyWith<$Res>
    implements $AddBrandStateCopyWith<$Res> {
  factory _$$AddBrandStateImplCopyWith(
          _$AddBrandStateImpl value, $Res Function(_$AddBrandStateImpl) then) =
      __$$AddBrandStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool isSaving,
      bool brandStatus,
      String brandName,
      XFile? brandFile});
}

/// @nodoc
class __$$AddBrandStateImplCopyWithImpl<$Res>
    extends _$AddBrandStateCopyWithImpl<$Res, _$AddBrandStateImpl>
    implements _$$AddBrandStateImplCopyWith<$Res> {
  __$$AddBrandStateImplCopyWithImpl(
      _$AddBrandStateImpl _value, $Res Function(_$AddBrandStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isSaving = null,
    Object? brandStatus = null,
    Object? brandName = null,
    Object? brandFile = freezed,
  }) {
    return _then(_$AddBrandStateImpl(
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
    ));
  }
}

/// @nodoc

class _$AddBrandStateImpl extends _AddBrandState {
  const _$AddBrandStateImpl(
      {this.isLoading = false,
      this.isSaving = false,
      this.brandStatus = false,
      this.brandName = '',
      this.brandFile})
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
  String toString() {
    return 'AddBrandState(isLoading: $isLoading, isSaving: $isSaving, brandStatus: $brandStatus, brandName: $brandName, brandFile: $brandFile)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddBrandStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isSaving, isSaving) ||
                other.isSaving == isSaving) &&
            (identical(other.brandStatus, brandStatus) ||
                other.brandStatus == brandStatus) &&
            (identical(other.brandName, brandName) ||
                other.brandName == brandName) &&
            (identical(other.brandFile, brandFile) ||
                other.brandFile == brandFile));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, isLoading, isSaving, brandStatus, brandName, brandFile);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddBrandStateImplCopyWith<_$AddBrandStateImpl> get copyWith =>
      __$$AddBrandStateImplCopyWithImpl<_$AddBrandStateImpl>(this, _$identity);
}

abstract class _AddBrandState extends AddBrandState {
  const factory _AddBrandState(
      {final bool isLoading,
      final bool isSaving,
      final bool brandStatus,
      final String brandName,
      final XFile? brandFile}) = _$AddBrandStateImpl;
  const _AddBrandState._() : super._();

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
  @JsonKey(ignore: true)
  _$$AddBrandStateImplCopyWith<_$AddBrandStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
