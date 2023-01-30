// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'completed_orders_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CompletedOrdersState {
  List<OrderData> get orders => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isMoreLoading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CompletedOrdersStateCopyWith<CompletedOrdersState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompletedOrdersStateCopyWith<$Res> {
  factory $CompletedOrdersStateCopyWith(CompletedOrdersState value,
          $Res Function(CompletedOrdersState) then) =
      _$CompletedOrdersStateCopyWithImpl<$Res, CompletedOrdersState>;
  @useResult
  $Res call({List<OrderData> orders, bool isLoading, bool isMoreLoading});
}

/// @nodoc
class _$CompletedOrdersStateCopyWithImpl<$Res,
        $Val extends CompletedOrdersState>
    implements $CompletedOrdersStateCopyWith<$Res> {
  _$CompletedOrdersStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orders = null,
    Object? isLoading = null,
    Object? isMoreLoading = null,
  }) {
    return _then(_value.copyWith(
      orders: null == orders
          ? _value.orders
          : orders // ignore: cast_nullable_to_non_nullable
              as List<OrderData>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isMoreLoading: null == isMoreLoading
          ? _value.isMoreLoading
          : isMoreLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CompletedOrdersStateCopyWith<$Res>
    implements $CompletedOrdersStateCopyWith<$Res> {
  factory _$$_CompletedOrdersStateCopyWith(_$_CompletedOrdersState value,
          $Res Function(_$_CompletedOrdersState) then) =
      __$$_CompletedOrdersStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<OrderData> orders, bool isLoading, bool isMoreLoading});
}

/// @nodoc
class __$$_CompletedOrdersStateCopyWithImpl<$Res>
    extends _$CompletedOrdersStateCopyWithImpl<$Res, _$_CompletedOrdersState>
    implements _$$_CompletedOrdersStateCopyWith<$Res> {
  __$$_CompletedOrdersStateCopyWithImpl(_$_CompletedOrdersState _value,
      $Res Function(_$_CompletedOrdersState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orders = null,
    Object? isLoading = null,
    Object? isMoreLoading = null,
  }) {
    return _then(_$_CompletedOrdersState(
      orders: null == orders
          ? _value._orders
          : orders // ignore: cast_nullable_to_non_nullable
              as List<OrderData>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isMoreLoading: null == isMoreLoading
          ? _value.isMoreLoading
          : isMoreLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_CompletedOrdersState extends _CompletedOrdersState {
  const _$_CompletedOrdersState(
      {final List<OrderData> orders = const [],
      this.isLoading = false,
      this.isMoreLoading = false})
      : _orders = orders,
        super._();

  final List<OrderData> _orders;
  @override
  @JsonKey()
  List<OrderData> get orders {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orders);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isMoreLoading;

  @override
  String toString() {
    return 'CompletedOrdersState(orders: $orders, isLoading: $isLoading, isMoreLoading: $isMoreLoading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CompletedOrdersState &&
            const DeepCollectionEquality().equals(other._orders, _orders) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isMoreLoading, isMoreLoading) ||
                other.isMoreLoading == isMoreLoading));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_orders), isLoading, isMoreLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CompletedOrdersStateCopyWith<_$_CompletedOrdersState> get copyWith =>
      __$$_CompletedOrdersStateCopyWithImpl<_$_CompletedOrdersState>(
          this, _$identity);
}

abstract class _CompletedOrdersState extends CompletedOrdersState {
  const factory _CompletedOrdersState(
      {final List<OrderData> orders,
      final bool isLoading,
      final bool isMoreLoading}) = _$_CompletedOrdersState;
  const _CompletedOrdersState._() : super._();

  @override
  List<OrderData> get orders;
  @override
  bool get isLoading;
  @override
  bool get isMoreLoading;
  @override
  @JsonKey(ignore: true)
  _$$_CompletedOrdersStateCopyWith<_$_CompletedOrdersState> get copyWith =>
      throw _privateConstructorUsedError;
}
