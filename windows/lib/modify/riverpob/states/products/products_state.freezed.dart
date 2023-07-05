// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'products_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ProductsPasState {
  List<ProductPasData>? get products => throw _privateConstructorUsedError;
  List<ProductPasData>? get productsAfterFilter =>
      throw _privateConstructorUsedError;
  bool? get productsLoading => throw _privateConstructorUsedError;
  ProductPasData? get productsSelected => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProductsPasStateCopyWith<ProductsPasState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductsPasStateCopyWith<$Res> {
  factory $ProductsPasStateCopyWith(
          ProductsPasState value, $Res Function(ProductsPasState) then) =
      _$ProductsPasStateCopyWithImpl<$Res, ProductsPasState>;
  @useResult
  $Res call(
      {List<ProductPasData>? products,
      List<ProductPasData>? productsAfterFilter,
      bool? productsLoading,
      ProductPasData? productsSelected});
}

/// @nodoc
class _$ProductsPasStateCopyWithImpl<$Res, $Val extends ProductsPasState>
    implements $ProductsPasStateCopyWith<$Res> {
  _$ProductsPasStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? products = freezed,
    Object? productsAfterFilter = freezed,
    Object? productsLoading = freezed,
    Object? productsSelected = freezed,
  }) {
    return _then(_value.copyWith(
      products: freezed == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ProductPasData>?,
      productsAfterFilter: freezed == productsAfterFilter
          ? _value.productsAfterFilter
          : productsAfterFilter // ignore: cast_nullable_to_non_nullable
              as List<ProductPasData>?,
      productsLoading: freezed == productsLoading
          ? _value.productsLoading
          : productsLoading // ignore: cast_nullable_to_non_nullable
              as bool?,
      productsSelected: freezed == productsSelected
          ? _value.productsSelected
          : productsSelected // ignore: cast_nullable_to_non_nullable
              as ProductPasData?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ProductsPasStateCopyWith<$Res>
    implements $ProductsPasStateCopyWith<$Res> {
  factory _$$_ProductsPasStateCopyWith(
          _$_ProductsPasState value, $Res Function(_$_ProductsPasState) then) =
      __$$_ProductsPasStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<ProductPasData>? products,
      List<ProductPasData>? productsAfterFilter,
      bool? productsLoading,
      ProductPasData? productsSelected});
}

/// @nodoc
class __$$_ProductsPasStateCopyWithImpl<$Res>
    extends _$ProductsPasStateCopyWithImpl<$Res, _$_ProductsPasState>
    implements _$$_ProductsPasStateCopyWith<$Res> {
  __$$_ProductsPasStateCopyWithImpl(
      _$_ProductsPasState _value, $Res Function(_$_ProductsPasState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? products = freezed,
    Object? productsAfterFilter = freezed,
    Object? productsLoading = freezed,
    Object? productsSelected = freezed,
  }) {
    return _then(_$_ProductsPasState(
      products: freezed == products
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ProductPasData>?,
      productsAfterFilter: freezed == productsAfterFilter
          ? _value._productsAfterFilter
          : productsAfterFilter // ignore: cast_nullable_to_non_nullable
              as List<ProductPasData>?,
      productsLoading: freezed == productsLoading
          ? _value.productsLoading
          : productsLoading // ignore: cast_nullable_to_non_nullable
              as bool?,
      productsSelected: freezed == productsSelected
          ? _value.productsSelected
          : productsSelected // ignore: cast_nullable_to_non_nullable
              as ProductPasData?,
    ));
  }
}

/// @nodoc

class _$_ProductsPasState extends _ProductsPasState {
  const _$_ProductsPasState(
      {final List<ProductPasData>? products = const [],
      final List<ProductPasData>? productsAfterFilter = const [],
      this.productsLoading = false,
      this.productsSelected})
      : _products = products,
        _productsAfterFilter = productsAfterFilter,
        super._();

  final List<ProductPasData>? _products;
  @override
  @JsonKey()
  List<ProductPasData>? get products {
    final value = _products;
    if (value == null) return null;
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ProductPasData>? _productsAfterFilter;
  @override
  @JsonKey()
  List<ProductPasData>? get productsAfterFilter {
    final value = _productsAfterFilter;
    if (value == null) return null;
    if (_productsAfterFilter is EqualUnmodifiableListView)
      return _productsAfterFilter;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final bool? productsLoading;
  @override
  final ProductPasData? productsSelected;

  @override
  String toString() {
    return 'ProductsPasState(products: $products, productsAfterFilter: $productsAfterFilter, productsLoading: $productsLoading, productsSelected: $productsSelected)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProductsPasState &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            const DeepCollectionEquality()
                .equals(other._productsAfterFilter, _productsAfterFilter) &&
            (identical(other.productsLoading, productsLoading) ||
                other.productsLoading == productsLoading) &&
            (identical(other.productsSelected, productsSelected) ||
                other.productsSelected == productsSelected));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_products),
      const DeepCollectionEquality().hash(_productsAfterFilter),
      productsLoading,
      productsSelected);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProductsPasStateCopyWith<_$_ProductsPasState> get copyWith =>
      __$$_ProductsPasStateCopyWithImpl<_$_ProductsPasState>(this, _$identity);
}

abstract class _ProductsPasState extends ProductsPasState {
  const factory _ProductsPasState(
      {final List<ProductPasData>? products,
      final List<ProductPasData>? productsAfterFilter,
      final bool? productsLoading,
      final ProductPasData? productsSelected}) = _$_ProductsPasState;
  const _ProductsPasState._() : super._();

  @override
  List<ProductPasData>? get products;
  @override
  List<ProductPasData>? get productsAfterFilter;
  @override
  bool? get productsLoading;
  @override
  ProductPasData? get productsSelected;
  @override
  @JsonKey(ignore: true)
  _$$_ProductsPasStateCopyWith<_$_ProductsPasState> get copyWith =>
      throw _privateConstructorUsedError;
}
