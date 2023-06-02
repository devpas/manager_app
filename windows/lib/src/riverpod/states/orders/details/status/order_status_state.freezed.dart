// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_status_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$OrderStatusState {
  bool get isLoading => throw _privateConstructorUsedError;
  OrderStatus get activeOrderStatus => throw _privateConstructorUsedError;
  OrderStatus get initialOrderStatus => throw _privateConstructorUsedError;
  ShopOrderDetails? get shopOrderDetails => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OrderStatusStateCopyWith<OrderStatusState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderStatusStateCopyWith<$Res> {
  factory $OrderStatusStateCopyWith(
          OrderStatusState value, $Res Function(OrderStatusState) then) =
      _$OrderStatusStateCopyWithImpl<$Res, OrderStatusState>;
  @useResult
  $Res call(
      {bool isLoading,
      OrderStatus activeOrderStatus,
      OrderStatus initialOrderStatus,
      ShopOrderDetails? shopOrderDetails});
}

/// @nodoc
class _$OrderStatusStateCopyWithImpl<$Res, $Val extends OrderStatusState>
    implements $OrderStatusStateCopyWith<$Res> {
  _$OrderStatusStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? activeOrderStatus = null,
    Object? initialOrderStatus = null,
    Object? shopOrderDetails = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      activeOrderStatus: null == activeOrderStatus
          ? _value.activeOrderStatus
          : activeOrderStatus // ignore: cast_nullable_to_non_nullable
              as OrderStatus,
      initialOrderStatus: null == initialOrderStatus
          ? _value.initialOrderStatus
          : initialOrderStatus // ignore: cast_nullable_to_non_nullable
              as OrderStatus,
      shopOrderDetails: freezed == shopOrderDetails
          ? _value.shopOrderDetails
          : shopOrderDetails // ignore: cast_nullable_to_non_nullable
              as ShopOrderDetails?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_OrderStatusStateCopyWith<$Res>
    implements $OrderStatusStateCopyWith<$Res> {
  factory _$$_OrderStatusStateCopyWith(
          _$_OrderStatusState value, $Res Function(_$_OrderStatusState) then) =
      __$$_OrderStatusStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      OrderStatus activeOrderStatus,
      OrderStatus initialOrderStatus,
      ShopOrderDetails? shopOrderDetails});
}

/// @nodoc
class __$$_OrderStatusStateCopyWithImpl<$Res>
    extends _$OrderStatusStateCopyWithImpl<$Res, _$_OrderStatusState>
    implements _$$_OrderStatusStateCopyWith<$Res> {
  __$$_OrderStatusStateCopyWithImpl(
      _$_OrderStatusState _value, $Res Function(_$_OrderStatusState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? activeOrderStatus = null,
    Object? initialOrderStatus = null,
    Object? shopOrderDetails = freezed,
  }) {
    return _then(_$_OrderStatusState(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      activeOrderStatus: null == activeOrderStatus
          ? _value.activeOrderStatus
          : activeOrderStatus // ignore: cast_nullable_to_non_nullable
              as OrderStatus,
      initialOrderStatus: null == initialOrderStatus
          ? _value.initialOrderStatus
          : initialOrderStatus // ignore: cast_nullable_to_non_nullable
              as OrderStatus,
      shopOrderDetails: freezed == shopOrderDetails
          ? _value.shopOrderDetails
          : shopOrderDetails // ignore: cast_nullable_to_non_nullable
              as ShopOrderDetails?,
    ));
  }
}

/// @nodoc

class _$_OrderStatusState extends _OrderStatusState {
  const _$_OrderStatusState(
      {this.isLoading = false,
      this.activeOrderStatus = OrderStatus.newOrder,
      this.initialOrderStatus = OrderStatus.newOrder,
      this.shopOrderDetails})
      : super._();

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final OrderStatus activeOrderStatus;
  @override
  @JsonKey()
  final OrderStatus initialOrderStatus;
  @override
  final ShopOrderDetails? shopOrderDetails;

  @override
  String toString() {
    return 'OrderStatusState(isLoading: $isLoading, activeOrderStatus: $activeOrderStatus, initialOrderStatus: $initialOrderStatus, shopOrderDetails: $shopOrderDetails)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OrderStatusState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.activeOrderStatus, activeOrderStatus) ||
                other.activeOrderStatus == activeOrderStatus) &&
            (identical(other.initialOrderStatus, initialOrderStatus) ||
                other.initialOrderStatus == initialOrderStatus) &&
            (identical(other.shopOrderDetails, shopOrderDetails) ||
                other.shopOrderDetails == shopOrderDetails));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, activeOrderStatus,
      initialOrderStatus, shopOrderDetails);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OrderStatusStateCopyWith<_$_OrderStatusState> get copyWith =>
      __$$_OrderStatusStateCopyWithImpl<_$_OrderStatusState>(this, _$identity);
}

abstract class _OrderStatusState extends OrderStatusState {
  const factory _OrderStatusState(
      {final bool isLoading,
      final OrderStatus activeOrderStatus,
      final OrderStatus initialOrderStatus,
      final ShopOrderDetails? shopOrderDetails}) = _$_OrderStatusState;
  const _OrderStatusState._() : super._();

  @override
  bool get isLoading;
  @override
  OrderStatus get activeOrderStatus;
  @override
  OrderStatus get initialOrderStatus;
  @override
  ShopOrderDetails? get shopOrderDetails;
  @override
  @JsonKey(ignore: true)
  _$$_OrderStatusStateCopyWith<_$_OrderStatusState> get copyWith =>
      throw _privateConstructorUsedError;
}
