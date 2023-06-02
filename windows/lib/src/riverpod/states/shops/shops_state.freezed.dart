// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shops_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ShopsState {
  List<ShopData> get shops => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isSaving => throw _privateConstructorUsedError;
  bool get isMoreLoading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ShopsStateCopyWith<ShopsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShopsStateCopyWith<$Res> {
  factory $ShopsStateCopyWith(
          ShopsState value, $Res Function(ShopsState) then) =
      _$ShopsStateCopyWithImpl<$Res, ShopsState>;
  @useResult
  $Res call(
      {List<ShopData> shops,
      bool isLoading,
      bool isSaving,
      bool isMoreLoading});
}

/// @nodoc
class _$ShopsStateCopyWithImpl<$Res, $Val extends ShopsState>
    implements $ShopsStateCopyWith<$Res> {
  _$ShopsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shops = null,
    Object? isLoading = null,
    Object? isSaving = null,
    Object? isMoreLoading = null,
  }) {
    return _then(_value.copyWith(
      shops: null == shops
          ? _value.shops
          : shops // ignore: cast_nullable_to_non_nullable
              as List<ShopData>,
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
abstract class _$$_ShopsStateCopyWith<$Res>
    implements $ShopsStateCopyWith<$Res> {
  factory _$$_ShopsStateCopyWith(
          _$_ShopsState value, $Res Function(_$_ShopsState) then) =
      __$$_ShopsStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<ShopData> shops,
      bool isLoading,
      bool isSaving,
      bool isMoreLoading});
}

/// @nodoc
class __$$_ShopsStateCopyWithImpl<$Res>
    extends _$ShopsStateCopyWithImpl<$Res, _$_ShopsState>
    implements _$$_ShopsStateCopyWith<$Res> {
  __$$_ShopsStateCopyWithImpl(
      _$_ShopsState _value, $Res Function(_$_ShopsState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shops = null,
    Object? isLoading = null,
    Object? isSaving = null,
    Object? isMoreLoading = null,
  }) {
    return _then(_$_ShopsState(
      shops: null == shops
          ? _value._shops
          : shops // ignore: cast_nullable_to_non_nullable
              as List<ShopData>,
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

class _$_ShopsState extends _ShopsState {
  const _$_ShopsState(
      {final List<ShopData> shops = const [],
      this.isLoading = false,
      this.isSaving = false,
      this.isMoreLoading = false})
      : _shops = shops,
        super._();

  final List<ShopData> _shops;
  @override
  @JsonKey()
  List<ShopData> get shops {
    if (_shops is EqualUnmodifiableListView) return _shops;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_shops);
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
    return 'ShopsState(shops: $shops, isLoading: $isLoading, isSaving: $isSaving, isMoreLoading: $isMoreLoading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ShopsState &&
            const DeepCollectionEquality().equals(other._shops, _shops) &&
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
      const DeepCollectionEquality().hash(_shops),
      isLoading,
      isSaving,
      isMoreLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ShopsStateCopyWith<_$_ShopsState> get copyWith =>
      __$$_ShopsStateCopyWithImpl<_$_ShopsState>(this, _$identity);
}

abstract class _ShopsState extends ShopsState {
  const factory _ShopsState(
      {final List<ShopData> shops,
      final bool isLoading,
      final bool isSaving,
      final bool isMoreLoading}) = _$_ShopsState;
  const _ShopsState._() : super._();

  @override
  List<ShopData> get shops;
  @override
  bool get isLoading;
  @override
  bool get isSaving;
  @override
  bool get isMoreLoading;
  @override
  @JsonKey(ignore: true)
  _$$_ShopsStateCopyWith<_$_ShopsState> get copyWith =>
      throw _privateConstructorUsedError;
}
