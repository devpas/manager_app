// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'brands_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BrandsState {
  List<BrandData> get brands => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isSaving => throw _privateConstructorUsedError;
  bool get isMoreLoading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BrandsStateCopyWith<BrandsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BrandsStateCopyWith<$Res> {
  factory $BrandsStateCopyWith(
          BrandsState value, $Res Function(BrandsState) then) =
      _$BrandsStateCopyWithImpl<$Res, BrandsState>;
  @useResult
  $Res call(
      {List<BrandData> brands,
      bool isLoading,
      bool isSaving,
      bool isMoreLoading});
}

/// @nodoc
class _$BrandsStateCopyWithImpl<$Res, $Val extends BrandsState>
    implements $BrandsStateCopyWith<$Res> {
  _$BrandsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? brands = null,
    Object? isLoading = null,
    Object? isSaving = null,
    Object? isMoreLoading = null,
  }) {
    return _then(_value.copyWith(
      brands: null == brands
          ? _value.brands
          : brands // ignore: cast_nullable_to_non_nullable
              as List<BrandData>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isSaving: null == isSaving
          ? _value.isSaving
          : isSaving // ignore: cast_nullable_to_non_nullable
              as bool,
      isMoreLoading: null == isMoreLoading
          ? _value.isMoreLoading
          : isMoreLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BrandsStateImplCopyWith<$Res>
    implements $BrandsStateCopyWith<$Res> {
  factory _$$BrandsStateImplCopyWith(
          _$BrandsStateImpl value, $Res Function(_$BrandsStateImpl) then) =
      __$$BrandsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<BrandData> brands,
      bool isLoading,
      bool isSaving,
      bool isMoreLoading});
}

/// @nodoc
class __$$BrandsStateImplCopyWithImpl<$Res>
    extends _$BrandsStateCopyWithImpl<$Res, _$BrandsStateImpl>
    implements _$$BrandsStateImplCopyWith<$Res> {
  __$$BrandsStateImplCopyWithImpl(
      _$BrandsStateImpl _value, $Res Function(_$BrandsStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? brands = null,
    Object? isLoading = null,
    Object? isSaving = null,
    Object? isMoreLoading = null,
  }) {
    return _then(_$BrandsStateImpl(
      brands: null == brands
          ? _value._brands
          : brands // ignore: cast_nullable_to_non_nullable
              as List<BrandData>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isSaving: null == isSaving
          ? _value.isSaving
          : isSaving // ignore: cast_nullable_to_non_nullable
              as bool,
      isMoreLoading: null == isMoreLoading
          ? _value.isMoreLoading
          : isMoreLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$BrandsStateImpl extends _BrandsState {
  const _$BrandsStateImpl(
      {final List<BrandData> brands = const [],
      this.isLoading = false,
      this.isSaving = false,
      this.isMoreLoading = false})
      : _brands = brands,
        super._();

  final List<BrandData> _brands;
  @override
  @JsonKey()
  List<BrandData> get brands {
    if (_brands is EqualUnmodifiableListView) return _brands;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_brands);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isSaving;
  @override
  @JsonKey()
  final bool isMoreLoading;

  @override
  String toString() {
    return 'BrandsState(brands: $brands, isLoading: $isLoading, isSaving: $isSaving, isMoreLoading: $isMoreLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BrandsStateImpl &&
            const DeepCollectionEquality().equals(other._brands, _brands) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isSaving, isSaving) ||
                other.isSaving == isSaving) &&
            (identical(other.isMoreLoading, isMoreLoading) ||
                other.isMoreLoading == isMoreLoading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_brands),
      isLoading,
      isSaving,
      isMoreLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BrandsStateImplCopyWith<_$BrandsStateImpl> get copyWith =>
      __$$BrandsStateImplCopyWithImpl<_$BrandsStateImpl>(this, _$identity);
}

abstract class _BrandsState extends BrandsState {
  const factory _BrandsState(
      {final List<BrandData> brands,
      final bool isLoading,
      final bool isSaving,
      final bool isMoreLoading}) = _$BrandsStateImpl;
  const _BrandsState._() : super._();

  @override
  List<BrandData> get brands;
  @override
  bool get isLoading;
  @override
  bool get isSaving;
  @override
  bool get isMoreLoading;
  @override
  @JsonKey(ignore: true)
  _$$BrandsStateImplCopyWith<_$BrandsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
