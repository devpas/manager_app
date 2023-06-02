// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_order_product_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AddOrderProductState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<TypedExtra> get typedExtras => throw _privateConstructorUsedError;
  List<Stocks> get initialStocks => throw _privateConstructorUsedError;
  List<int> get selectedIndexes => throw _privateConstructorUsedError;
  int get stockCount => throw _privateConstructorUsedError;
  ProductData? get product => throw _privateConstructorUsedError;
  Stocks? get selectedStock => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AddOrderProductStateCopyWith<AddOrderProductState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddOrderProductStateCopyWith<$Res> {
  factory $AddOrderProductStateCopyWith(AddOrderProductState value,
          $Res Function(AddOrderProductState) then) =
      _$AddOrderProductStateCopyWithImpl<$Res, AddOrderProductState>;
  @useResult
  $Res call(
      {bool isLoading,
      List<TypedExtra> typedExtras,
      List<Stocks> initialStocks,
      List<int> selectedIndexes,
      int stockCount,
      ProductData? product,
      Stocks? selectedStock});
}

/// @nodoc
class _$AddOrderProductStateCopyWithImpl<$Res,
        $Val extends AddOrderProductState>
    implements $AddOrderProductStateCopyWith<$Res> {
  _$AddOrderProductStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? typedExtras = null,
    Object? initialStocks = null,
    Object? selectedIndexes = null,
    Object? stockCount = null,
    Object? product = freezed,
    Object? selectedStock = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      typedExtras: null == typedExtras
          ? _value.typedExtras
          : typedExtras // ignore: cast_nullable_to_non_nullable
              as List<TypedExtra>,
      initialStocks: null == initialStocks
          ? _value.initialStocks
          : initialStocks // ignore: cast_nullable_to_non_nullable
              as List<Stocks>,
      selectedIndexes: null == selectedIndexes
          ? _value.selectedIndexes
          : selectedIndexes // ignore: cast_nullable_to_non_nullable
              as List<int>,
      stockCount: null == stockCount
          ? _value.stockCount
          : stockCount // ignore: cast_nullable_to_non_nullable
              as int,
      product: freezed == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as ProductData?,
      selectedStock: freezed == selectedStock
          ? _value.selectedStock
          : selectedStock // ignore: cast_nullable_to_non_nullable
              as Stocks?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AddOrderProductStateCopyWith<$Res>
    implements $AddOrderProductStateCopyWith<$Res> {
  factory _$$_AddOrderProductStateCopyWith(_$_AddOrderProductState value,
          $Res Function(_$_AddOrderProductState) then) =
      __$$_AddOrderProductStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      List<TypedExtra> typedExtras,
      List<Stocks> initialStocks,
      List<int> selectedIndexes,
      int stockCount,
      ProductData? product,
      Stocks? selectedStock});
}

/// @nodoc
class __$$_AddOrderProductStateCopyWithImpl<$Res>
    extends _$AddOrderProductStateCopyWithImpl<$Res, _$_AddOrderProductState>
    implements _$$_AddOrderProductStateCopyWith<$Res> {
  __$$_AddOrderProductStateCopyWithImpl(_$_AddOrderProductState _value,
      $Res Function(_$_AddOrderProductState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? typedExtras = null,
    Object? initialStocks = null,
    Object? selectedIndexes = null,
    Object? stockCount = null,
    Object? product = freezed,
    Object? selectedStock = freezed,
  }) {
    return _then(_$_AddOrderProductState(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      typedExtras: null == typedExtras
          ? _value._typedExtras
          : typedExtras // ignore: cast_nullable_to_non_nullable
              as List<TypedExtra>,
      initialStocks: null == initialStocks
          ? _value._initialStocks
          : initialStocks // ignore: cast_nullable_to_non_nullable
              as List<Stocks>,
      selectedIndexes: null == selectedIndexes
          ? _value._selectedIndexes
          : selectedIndexes // ignore: cast_nullable_to_non_nullable
              as List<int>,
      stockCount: null == stockCount
          ? _value.stockCount
          : stockCount // ignore: cast_nullable_to_non_nullable
              as int,
      product: freezed == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as ProductData?,
      selectedStock: freezed == selectedStock
          ? _value.selectedStock
          : selectedStock // ignore: cast_nullable_to_non_nullable
              as Stocks?,
    ));
  }
}

/// @nodoc

class _$_AddOrderProductState extends _AddOrderProductState {
  const _$_AddOrderProductState(
      {this.isLoading = false,
      final List<TypedExtra> typedExtras = const [],
      final List<Stocks> initialStocks = const [],
      final List<int> selectedIndexes = const [],
      this.stockCount = 0,
      this.product,
      this.selectedStock})
      : _typedExtras = typedExtras,
        _initialStocks = initialStocks,
        _selectedIndexes = selectedIndexes,
        super._();

  @override
  @JsonKey()
  final bool isLoading;
  final List<TypedExtra> _typedExtras;
  @override
  @JsonKey()
  List<TypedExtra> get typedExtras {
    if (_typedExtras is EqualUnmodifiableListView) return _typedExtras;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_typedExtras);
  }

  final List<Stocks> _initialStocks;
  @override
  @JsonKey()
  List<Stocks> get initialStocks {
    if (_initialStocks is EqualUnmodifiableListView) return _initialStocks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_initialStocks);
  }

  final List<int> _selectedIndexes;
  @override
  @JsonKey()
  List<int> get selectedIndexes {
    if (_selectedIndexes is EqualUnmodifiableListView) return _selectedIndexes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedIndexes);
  }

  @override
  @JsonKey()
  final int stockCount;
  @override
  final ProductData? product;
  @override
  final Stocks? selectedStock;

  @override
  String toString() {
    return 'AddOrderProductState(isLoading: $isLoading, typedExtras: $typedExtras, initialStocks: $initialStocks, selectedIndexes: $selectedIndexes, stockCount: $stockCount, product: $product, selectedStock: $selectedStock)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AddOrderProductState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality()
                .equals(other._typedExtras, _typedExtras) &&
            const DeepCollectionEquality()
                .equals(other._initialStocks, _initialStocks) &&
            const DeepCollectionEquality()
                .equals(other._selectedIndexes, _selectedIndexes) &&
            (identical(other.stockCount, stockCount) ||
                other.stockCount == stockCount) &&
            (identical(other.product, product) || other.product == product) &&
            (identical(other.selectedStock, selectedStock) ||
                other.selectedStock == selectedStock));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      const DeepCollectionEquality().hash(_typedExtras),
      const DeepCollectionEquality().hash(_initialStocks),
      const DeepCollectionEquality().hash(_selectedIndexes),
      stockCount,
      product,
      selectedStock);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AddOrderProductStateCopyWith<_$_AddOrderProductState> get copyWith =>
      __$$_AddOrderProductStateCopyWithImpl<_$_AddOrderProductState>(
          this, _$identity);
}

abstract class _AddOrderProductState extends AddOrderProductState {
  const factory _AddOrderProductState(
      {final bool isLoading,
      final List<TypedExtra> typedExtras,
      final List<Stocks> initialStocks,
      final List<int> selectedIndexes,
      final int stockCount,
      final ProductData? product,
      final Stocks? selectedStock}) = _$_AddOrderProductState;
  const _AddOrderProductState._() : super._();

  @override
  bool get isLoading;
  @override
  List<TypedExtra> get typedExtras;
  @override
  List<Stocks> get initialStocks;
  @override
  List<int> get selectedIndexes;
  @override
  int get stockCount;
  @override
  ProductData? get product;
  @override
  Stocks? get selectedStock;
  @override
  @JsonKey(ignore: true)
  _$$_AddOrderProductStateCopyWith<_$_AddOrderProductState> get copyWith =>
      throw _privateConstructorUsedError;
}
