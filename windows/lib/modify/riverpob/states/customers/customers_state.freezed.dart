// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customers_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CustomersState {
  List<CustomerData>? get customers => throw _privateConstructorUsedError;
  List<ShopData>? get shops => throw _privateConstructorUsedError;
  List<CustomerData>? get customersAfterFilter =>
      throw _privateConstructorUsedError;
  CustomerData? get customerSelected => throw _privateConstructorUsedError;
  bool? get customerLoading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CustomersStateCopyWith<CustomersState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomersStateCopyWith<$Res> {
  factory $CustomersStateCopyWith(
          CustomersState value, $Res Function(CustomersState) then) =
      _$CustomersStateCopyWithImpl<$Res, CustomersState>;
  @useResult
  $Res call(
      {List<CustomerData>? customers,
      List<ShopData>? shops,
      List<CustomerData>? customersAfterFilter,
      CustomerData? customerSelected,
      bool? customerLoading});
}

/// @nodoc
class _$CustomersStateCopyWithImpl<$Res, $Val extends CustomersState>
    implements $CustomersStateCopyWith<$Res> {
  _$CustomersStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customers = freezed,
    Object? shops = freezed,
    Object? customersAfterFilter = freezed,
    Object? customerSelected = freezed,
    Object? customerLoading = freezed,
  }) {
    return _then(_value.copyWith(
      customers: freezed == customers
          ? _value.customers
          : customers // ignore: cast_nullable_to_non_nullable
              as List<CustomerData>?,
      shops: freezed == shops
          ? _value.shops
          : shops // ignore: cast_nullable_to_non_nullable
              as List<ShopData>?,
      customersAfterFilter: freezed == customersAfterFilter
          ? _value.customersAfterFilter
          : customersAfterFilter // ignore: cast_nullable_to_non_nullable
              as List<CustomerData>?,
      customerSelected: freezed == customerSelected
          ? _value.customerSelected
          : customerSelected // ignore: cast_nullable_to_non_nullable
              as CustomerData?,
      customerLoading: freezed == customerLoading
          ? _value.customerLoading
          : customerLoading // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CustomersStateCopyWith<$Res>
    implements $CustomersStateCopyWith<$Res> {
  factory _$$_CustomersStateCopyWith(
          _$_CustomersState value, $Res Function(_$_CustomersState) then) =
      __$$_CustomersStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<CustomerData>? customers,
      List<ShopData>? shops,
      List<CustomerData>? customersAfterFilter,
      CustomerData? customerSelected,
      bool? customerLoading});
}

/// @nodoc
class __$$_CustomersStateCopyWithImpl<$Res>
    extends _$CustomersStateCopyWithImpl<$Res, _$_CustomersState>
    implements _$$_CustomersStateCopyWith<$Res> {
  __$$_CustomersStateCopyWithImpl(
      _$_CustomersState _value, $Res Function(_$_CustomersState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customers = freezed,
    Object? shops = freezed,
    Object? customersAfterFilter = freezed,
    Object? customerSelected = freezed,
    Object? customerLoading = freezed,
  }) {
    return _then(_$_CustomersState(
      customers: freezed == customers
          ? _value._customers
          : customers // ignore: cast_nullable_to_non_nullable
              as List<CustomerData>?,
      shops: freezed == shops
          ? _value._shops
          : shops // ignore: cast_nullable_to_non_nullable
              as List<ShopData>?,
      customersAfterFilter: freezed == customersAfterFilter
          ? _value._customersAfterFilter
          : customersAfterFilter // ignore: cast_nullable_to_non_nullable
              as List<CustomerData>?,
      customerSelected: freezed == customerSelected
          ? _value.customerSelected
          : customerSelected // ignore: cast_nullable_to_non_nullable
              as CustomerData?,
      customerLoading: freezed == customerLoading
          ? _value.customerLoading
          : customerLoading // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

class _$_CustomersState extends _CustomersState {
  const _$_CustomersState(
      {final List<CustomerData>? customers = const [],
      final List<ShopData>? shops = const [],
      final List<CustomerData>? customersAfterFilter = const [],
      this.customerSelected,
      this.customerLoading = false})
      : _customers = customers,
        _shops = shops,
        _customersAfterFilter = customersAfterFilter,
        super._();

  final List<CustomerData>? _customers;
  @override
  @JsonKey()
  List<CustomerData>? get customers {
    final value = _customers;
    if (value == null) return null;
    if (_customers is EqualUnmodifiableListView) return _customers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ShopData>? _shops;
  @override
  @JsonKey()
  List<ShopData>? get shops {
    final value = _shops;
    if (value == null) return null;
    if (_shops is EqualUnmodifiableListView) return _shops;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<CustomerData>? _customersAfterFilter;
  @override
  @JsonKey()
  List<CustomerData>? get customersAfterFilter {
    final value = _customersAfterFilter;
    if (value == null) return null;
    if (_customersAfterFilter is EqualUnmodifiableListView)
      return _customersAfterFilter;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final CustomerData? customerSelected;
  @override
  @JsonKey()
  final bool? customerLoading;

  @override
  String toString() {
    return 'CustomersState(customers: $customers, shops: $shops, customersAfterFilter: $customersAfterFilter, customerSelected: $customerSelected, customerLoading: $customerLoading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CustomersState &&
            const DeepCollectionEquality()
                .equals(other._customers, _customers) &&
            const DeepCollectionEquality().equals(other._shops, _shops) &&
            const DeepCollectionEquality()
                .equals(other._customersAfterFilter, _customersAfterFilter) &&
            (identical(other.customerSelected, customerSelected) ||
                other.customerSelected == customerSelected) &&
            (identical(other.customerLoading, customerLoading) ||
                other.customerLoading == customerLoading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_customers),
      const DeepCollectionEquality().hash(_shops),
      const DeepCollectionEquality().hash(_customersAfterFilter),
      customerSelected,
      customerLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CustomersStateCopyWith<_$_CustomersState> get copyWith =>
      __$$_CustomersStateCopyWithImpl<_$_CustomersState>(this, _$identity);
}

abstract class _CustomersState extends CustomersState {
  const factory _CustomersState(
      {final List<CustomerData>? customers,
      final List<ShopData>? shops,
      final List<CustomerData>? customersAfterFilter,
      final CustomerData? customerSelected,
      final bool? customerLoading}) = _$_CustomersState;
  const _CustomersState._() : super._();

  @override
  List<CustomerData>? get customers;
  @override
  List<ShopData>? get shops;
  @override
  List<CustomerData>? get customersAfterFilter;
  @override
  CustomerData? get customerSelected;
  @override
  bool? get customerLoading;
  @override
  @JsonKey(ignore: true)
  _$$_CustomersStateCopyWith<_$_CustomersState> get copyWith =>
      throw _privateConstructorUsedError;
}
