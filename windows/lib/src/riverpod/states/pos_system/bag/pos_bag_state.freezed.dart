// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pos_bag_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PosBagState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isUsersLoading => throw _privateConstructorUsedError;
  bool get isUserDetailsLoading => throw _privateConstructorUsedError;
  bool get isCurrenciesLoading => throw _privateConstructorUsedError;
  bool get isPaymentsLoading => throw _privateConstructorUsedError;
  bool get isDeliveriesLoading => throw _privateConstructorUsedError;
  bool get isCalculationsLoading => throw _privateConstructorUsedError;
  bool get isCreatingOrder => throw _privateConstructorUsedError;
  bool get isCreatingPayment => throw _privateConstructorUsedError;
  bool get isDeliveryInfoFilled => throw _privateConstructorUsedError;
  bool get isShopsLoading => throw _privateConstructorUsedError;
  List<UserData> get users => throw _privateConstructorUsedError;
  List<AddressData> get userAddresses => throw _privateConstructorUsedError;
  List<CurrencyData> get currencies => throw _privateConstructorUsedError;
  List<PaymentData> get payments => throw _privateConstructorUsedError;
  List<ShopDeliveryInfo> get shopsDeliverInfo =>
      throw _privateConstructorUsedError;
  String get userQuery => throw _privateConstructorUsedError;
  double get subtotal => throw _privateConstructorUsedError;
  double get productTax => throw _privateConstructorUsedError;
  double get shopTax => throw _privateConstructorUsedError;
  ProductCalculateResponse? get calculateResponse =>
      throw _privateConstructorUsedError;
  PosSystemBagData? get posBagData => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PosBagStateCopyWith<PosBagState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PosBagStateCopyWith<$Res> {
  factory $PosBagStateCopyWith(
          PosBagState value, $Res Function(PosBagState) then) =
      _$PosBagStateCopyWithImpl<$Res, PosBagState>;
  @useResult
  $Res call(
      {bool isLoading,
      bool isUsersLoading,
      bool isUserDetailsLoading,
      bool isCurrenciesLoading,
      bool isPaymentsLoading,
      bool isDeliveriesLoading,
      bool isCalculationsLoading,
      bool isCreatingOrder,
      bool isCreatingPayment,
      bool isDeliveryInfoFilled,
      bool isShopsLoading,
      List<UserData> users,
      List<AddressData> userAddresses,
      List<CurrencyData> currencies,
      List<PaymentData> payments,
      List<ShopDeliveryInfo> shopsDeliverInfo,
      String userQuery,
      double subtotal,
      double productTax,
      double shopTax,
      ProductCalculateResponse? calculateResponse,
      PosSystemBagData? posBagData});
}

/// @nodoc
class _$PosBagStateCopyWithImpl<$Res, $Val extends PosBagState>
    implements $PosBagStateCopyWith<$Res> {
  _$PosBagStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isUsersLoading = null,
    Object? isUserDetailsLoading = null,
    Object? isCurrenciesLoading = null,
    Object? isPaymentsLoading = null,
    Object? isDeliveriesLoading = null,
    Object? isCalculationsLoading = null,
    Object? isCreatingOrder = null,
    Object? isCreatingPayment = null,
    Object? isDeliveryInfoFilled = null,
    Object? isShopsLoading = null,
    Object? users = null,
    Object? userAddresses = null,
    Object? currencies = null,
    Object? payments = null,
    Object? shopsDeliverInfo = null,
    Object? userQuery = null,
    Object? subtotal = null,
    Object? productTax = null,
    Object? shopTax = null,
    Object? calculateResponse = freezed,
    Object? posBagData = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isUsersLoading: null == isUsersLoading
          ? _value.isUsersLoading
          : isUsersLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isUserDetailsLoading: null == isUserDetailsLoading
          ? _value.isUserDetailsLoading
          : isUserDetailsLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isCurrenciesLoading: null == isCurrenciesLoading
          ? _value.isCurrenciesLoading
          : isCurrenciesLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isPaymentsLoading: null == isPaymentsLoading
          ? _value.isPaymentsLoading
          : isPaymentsLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isDeliveriesLoading: null == isDeliveriesLoading
          ? _value.isDeliveriesLoading
          : isDeliveriesLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isCalculationsLoading: null == isCalculationsLoading
          ? _value.isCalculationsLoading
          : isCalculationsLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isCreatingOrder: null == isCreatingOrder
          ? _value.isCreatingOrder
          : isCreatingOrder // ignore: cast_nullable_to_non_nullable
              as bool,
      isCreatingPayment: null == isCreatingPayment
          ? _value.isCreatingPayment
          : isCreatingPayment // ignore: cast_nullable_to_non_nullable
              as bool,
      isDeliveryInfoFilled: null == isDeliveryInfoFilled
          ? _value.isDeliveryInfoFilled
          : isDeliveryInfoFilled // ignore: cast_nullable_to_non_nullable
              as bool,
      isShopsLoading: null == isShopsLoading
          ? _value.isShopsLoading
          : isShopsLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      users: null == users
          ? _value.users
          : users // ignore: cast_nullable_to_non_nullable
              as List<UserData>,
      userAddresses: null == userAddresses
          ? _value.userAddresses
          : userAddresses // ignore: cast_nullable_to_non_nullable
              as List<AddressData>,
      currencies: null == currencies
          ? _value.currencies
          : currencies // ignore: cast_nullable_to_non_nullable
              as List<CurrencyData>,
      payments: null == payments
          ? _value.payments
          : payments // ignore: cast_nullable_to_non_nullable
              as List<PaymentData>,
      shopsDeliverInfo: null == shopsDeliverInfo
          ? _value.shopsDeliverInfo
          : shopsDeliverInfo // ignore: cast_nullable_to_non_nullable
              as List<ShopDeliveryInfo>,
      userQuery: null == userQuery
          ? _value.userQuery
          : userQuery // ignore: cast_nullable_to_non_nullable
              as String,
      subtotal: null == subtotal
          ? _value.subtotal
          : subtotal // ignore: cast_nullable_to_non_nullable
              as double,
      productTax: null == productTax
          ? _value.productTax
          : productTax // ignore: cast_nullable_to_non_nullable
              as double,
      shopTax: null == shopTax
          ? _value.shopTax
          : shopTax // ignore: cast_nullable_to_non_nullable
              as double,
      calculateResponse: freezed == calculateResponse
          ? _value.calculateResponse
          : calculateResponse // ignore: cast_nullable_to_non_nullable
              as ProductCalculateResponse?,
      posBagData: freezed == posBagData
          ? _value.posBagData
          : posBagData // ignore: cast_nullable_to_non_nullable
              as PosSystemBagData?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PosBagStateCopyWith<$Res>
    implements $PosBagStateCopyWith<$Res> {
  factory _$$_PosBagStateCopyWith(
          _$_PosBagState value, $Res Function(_$_PosBagState) then) =
      __$$_PosBagStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool isUsersLoading,
      bool isUserDetailsLoading,
      bool isCurrenciesLoading,
      bool isPaymentsLoading,
      bool isDeliveriesLoading,
      bool isCalculationsLoading,
      bool isCreatingOrder,
      bool isCreatingPayment,
      bool isDeliveryInfoFilled,
      bool isShopsLoading,
      List<UserData> users,
      List<AddressData> userAddresses,
      List<CurrencyData> currencies,
      List<PaymentData> payments,
      List<ShopDeliveryInfo> shopsDeliverInfo,
      String userQuery,
      double subtotal,
      double productTax,
      double shopTax,
      ProductCalculateResponse? calculateResponse,
      PosSystemBagData? posBagData});
}

/// @nodoc
class __$$_PosBagStateCopyWithImpl<$Res>
    extends _$PosBagStateCopyWithImpl<$Res, _$_PosBagState>
    implements _$$_PosBagStateCopyWith<$Res> {
  __$$_PosBagStateCopyWithImpl(
      _$_PosBagState _value, $Res Function(_$_PosBagState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isUsersLoading = null,
    Object? isUserDetailsLoading = null,
    Object? isCurrenciesLoading = null,
    Object? isPaymentsLoading = null,
    Object? isDeliveriesLoading = null,
    Object? isCalculationsLoading = null,
    Object? isCreatingOrder = null,
    Object? isCreatingPayment = null,
    Object? isDeliveryInfoFilled = null,
    Object? isShopsLoading = null,
    Object? users = null,
    Object? userAddresses = null,
    Object? currencies = null,
    Object? payments = null,
    Object? shopsDeliverInfo = null,
    Object? userQuery = null,
    Object? subtotal = null,
    Object? productTax = null,
    Object? shopTax = null,
    Object? calculateResponse = freezed,
    Object? posBagData = freezed,
  }) {
    return _then(_$_PosBagState(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isUsersLoading: null == isUsersLoading
          ? _value.isUsersLoading
          : isUsersLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isUserDetailsLoading: null == isUserDetailsLoading
          ? _value.isUserDetailsLoading
          : isUserDetailsLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isCurrenciesLoading: null == isCurrenciesLoading
          ? _value.isCurrenciesLoading
          : isCurrenciesLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isPaymentsLoading: null == isPaymentsLoading
          ? _value.isPaymentsLoading
          : isPaymentsLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isDeliveriesLoading: null == isDeliveriesLoading
          ? _value.isDeliveriesLoading
          : isDeliveriesLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isCalculationsLoading: null == isCalculationsLoading
          ? _value.isCalculationsLoading
          : isCalculationsLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isCreatingOrder: null == isCreatingOrder
          ? _value.isCreatingOrder
          : isCreatingOrder // ignore: cast_nullable_to_non_nullable
              as bool,
      isCreatingPayment: null == isCreatingPayment
          ? _value.isCreatingPayment
          : isCreatingPayment // ignore: cast_nullable_to_non_nullable
              as bool,
      isDeliveryInfoFilled: null == isDeliveryInfoFilled
          ? _value.isDeliveryInfoFilled
          : isDeliveryInfoFilled // ignore: cast_nullable_to_non_nullable
              as bool,
      isShopsLoading: null == isShopsLoading
          ? _value.isShopsLoading
          : isShopsLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      users: null == users
          ? _value._users
          : users // ignore: cast_nullable_to_non_nullable
              as List<UserData>,
      userAddresses: null == userAddresses
          ? _value._userAddresses
          : userAddresses // ignore: cast_nullable_to_non_nullable
              as List<AddressData>,
      currencies: null == currencies
          ? _value._currencies
          : currencies // ignore: cast_nullable_to_non_nullable
              as List<CurrencyData>,
      payments: null == payments
          ? _value._payments
          : payments // ignore: cast_nullable_to_non_nullable
              as List<PaymentData>,
      shopsDeliverInfo: null == shopsDeliverInfo
          ? _value._shopsDeliverInfo
          : shopsDeliverInfo // ignore: cast_nullable_to_non_nullable
              as List<ShopDeliveryInfo>,
      userQuery: null == userQuery
          ? _value.userQuery
          : userQuery // ignore: cast_nullable_to_non_nullable
              as String,
      subtotal: null == subtotal
          ? _value.subtotal
          : subtotal // ignore: cast_nullable_to_non_nullable
              as double,
      productTax: null == productTax
          ? _value.productTax
          : productTax // ignore: cast_nullable_to_non_nullable
              as double,
      shopTax: null == shopTax
          ? _value.shopTax
          : shopTax // ignore: cast_nullable_to_non_nullable
              as double,
      calculateResponse: freezed == calculateResponse
          ? _value.calculateResponse
          : calculateResponse // ignore: cast_nullable_to_non_nullable
              as ProductCalculateResponse?,
      posBagData: freezed == posBagData
          ? _value.posBagData
          : posBagData // ignore: cast_nullable_to_non_nullable
              as PosSystemBagData?,
    ));
  }
}

/// @nodoc

class _$_PosBagState extends _PosBagState {
  const _$_PosBagState(
      {this.isLoading = false,
      this.isUsersLoading = false,
      this.isUserDetailsLoading = false,
      this.isCurrenciesLoading = false,
      this.isPaymentsLoading = false,
      this.isDeliveriesLoading = false,
      this.isCalculationsLoading = false,
      this.isCreatingOrder = false,
      this.isCreatingPayment = false,
      this.isDeliveryInfoFilled = false,
      this.isShopsLoading = false,
      final List<UserData> users = const [],
      final List<AddressData> userAddresses = const [],
      final List<CurrencyData> currencies = const [],
      final List<PaymentData> payments = const [],
      final List<ShopDeliveryInfo> shopsDeliverInfo = const [],
      this.userQuery = '',
      this.subtotal = 0,
      this.productTax = 0,
      this.shopTax = 0,
      this.calculateResponse,
      this.posBagData})
      : _users = users,
        _userAddresses = userAddresses,
        _currencies = currencies,
        _payments = payments,
        _shopsDeliverInfo = shopsDeliverInfo,
        super._();

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isUsersLoading;
  @override
  @JsonKey()
  final bool isUserDetailsLoading;
  @override
  @JsonKey()
  final bool isCurrenciesLoading;
  @override
  @JsonKey()
  final bool isPaymentsLoading;
  @override
  @JsonKey()
  final bool isDeliveriesLoading;
  @override
  @JsonKey()
  final bool isCalculationsLoading;
  @override
  @JsonKey()
  final bool isCreatingOrder;
  @override
  @JsonKey()
  final bool isCreatingPayment;
  @override
  @JsonKey()
  final bool isDeliveryInfoFilled;
  @override
  @JsonKey()
  final bool isShopsLoading;
  final List<UserData> _users;
  @override
  @JsonKey()
  List<UserData> get users {
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_users);
  }

  final List<AddressData> _userAddresses;
  @override
  @JsonKey()
  List<AddressData> get userAddresses {
    if (_userAddresses is EqualUnmodifiableListView) return _userAddresses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_userAddresses);
  }

  final List<CurrencyData> _currencies;
  @override
  @JsonKey()
  List<CurrencyData> get currencies {
    if (_currencies is EqualUnmodifiableListView) return _currencies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_currencies);
  }

  final List<PaymentData> _payments;
  @override
  @JsonKey()
  List<PaymentData> get payments {
    if (_payments is EqualUnmodifiableListView) return _payments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_payments);
  }

  final List<ShopDeliveryInfo> _shopsDeliverInfo;
  @override
  @JsonKey()
  List<ShopDeliveryInfo> get shopsDeliverInfo {
    if (_shopsDeliverInfo is EqualUnmodifiableListView)
      return _shopsDeliverInfo;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_shopsDeliverInfo);
  }

  @override
  @JsonKey()
  final String userQuery;
  @override
  @JsonKey()
  final double subtotal;
  @override
  @JsonKey()
  final double productTax;
  @override
  @JsonKey()
  final double shopTax;
  @override
  final ProductCalculateResponse? calculateResponse;
  @override
  final PosSystemBagData? posBagData;

  @override
  String toString() {
    return 'PosBagState(isLoading: $isLoading, isUsersLoading: $isUsersLoading, isUserDetailsLoading: $isUserDetailsLoading, isCurrenciesLoading: $isCurrenciesLoading, isPaymentsLoading: $isPaymentsLoading, isDeliveriesLoading: $isDeliveriesLoading, isCalculationsLoading: $isCalculationsLoading, isCreatingOrder: $isCreatingOrder, isCreatingPayment: $isCreatingPayment, isDeliveryInfoFilled: $isDeliveryInfoFilled, isShopsLoading: $isShopsLoading, users: $users, userAddresses: $userAddresses, currencies: $currencies, payments: $payments, shopsDeliverInfo: $shopsDeliverInfo, userQuery: $userQuery, subtotal: $subtotal, productTax: $productTax, shopTax: $shopTax, calculateResponse: $calculateResponse, posBagData: $posBagData)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PosBagState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isUsersLoading, isUsersLoading) ||
                other.isUsersLoading == isUsersLoading) &&
            (identical(other.isUserDetailsLoading, isUserDetailsLoading) ||
                other.isUserDetailsLoading == isUserDetailsLoading) &&
            (identical(other.isCurrenciesLoading, isCurrenciesLoading) ||
                other.isCurrenciesLoading == isCurrenciesLoading) &&
            (identical(other.isPaymentsLoading, isPaymentsLoading) ||
                other.isPaymentsLoading == isPaymentsLoading) &&
            (identical(other.isDeliveriesLoading, isDeliveriesLoading) ||
                other.isDeliveriesLoading == isDeliveriesLoading) &&
            (identical(other.isCalculationsLoading, isCalculationsLoading) ||
                other.isCalculationsLoading == isCalculationsLoading) &&
            (identical(other.isCreatingOrder, isCreatingOrder) ||
                other.isCreatingOrder == isCreatingOrder) &&
            (identical(other.isCreatingPayment, isCreatingPayment) ||
                other.isCreatingPayment == isCreatingPayment) &&
            (identical(other.isDeliveryInfoFilled, isDeliveryInfoFilled) ||
                other.isDeliveryInfoFilled == isDeliveryInfoFilled) &&
            (identical(other.isShopsLoading, isShopsLoading) ||
                other.isShopsLoading == isShopsLoading) &&
            const DeepCollectionEquality().equals(other._users, _users) &&
            const DeepCollectionEquality()
                .equals(other._userAddresses, _userAddresses) &&
            const DeepCollectionEquality()
                .equals(other._currencies, _currencies) &&
            const DeepCollectionEquality().equals(other._payments, _payments) &&
            const DeepCollectionEquality()
                .equals(other._shopsDeliverInfo, _shopsDeliverInfo) &&
            (identical(other.userQuery, userQuery) ||
                other.userQuery == userQuery) &&
            (identical(other.subtotal, subtotal) ||
                other.subtotal == subtotal) &&
            (identical(other.productTax, productTax) ||
                other.productTax == productTax) &&
            (identical(other.shopTax, shopTax) || other.shopTax == shopTax) &&
            (identical(other.calculateResponse, calculateResponse) ||
                other.calculateResponse == calculateResponse) &&
            (identical(other.posBagData, posBagData) ||
                other.posBagData == posBagData));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        isLoading,
        isUsersLoading,
        isUserDetailsLoading,
        isCurrenciesLoading,
        isPaymentsLoading,
        isDeliveriesLoading,
        isCalculationsLoading,
        isCreatingOrder,
        isCreatingPayment,
        isDeliveryInfoFilled,
        isShopsLoading,
        const DeepCollectionEquality().hash(_users),
        const DeepCollectionEquality().hash(_userAddresses),
        const DeepCollectionEquality().hash(_currencies),
        const DeepCollectionEquality().hash(_payments),
        const DeepCollectionEquality().hash(_shopsDeliverInfo),
        userQuery,
        subtotal,
        productTax,
        shopTax,
        calculateResponse,
        posBagData
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PosBagStateCopyWith<_$_PosBagState> get copyWith =>
      __$$_PosBagStateCopyWithImpl<_$_PosBagState>(this, _$identity);
}

abstract class _PosBagState extends PosBagState {
  const factory _PosBagState(
      {final bool isLoading,
      final bool isUsersLoading,
      final bool isUserDetailsLoading,
      final bool isCurrenciesLoading,
      final bool isPaymentsLoading,
      final bool isDeliveriesLoading,
      final bool isCalculationsLoading,
      final bool isCreatingOrder,
      final bool isCreatingPayment,
      final bool isDeliveryInfoFilled,
      final bool isShopsLoading,
      final List<UserData> users,
      final List<AddressData> userAddresses,
      final List<CurrencyData> currencies,
      final List<PaymentData> payments,
      final List<ShopDeliveryInfo> shopsDeliverInfo,
      final String userQuery,
      final double subtotal,
      final double productTax,
      final double shopTax,
      final ProductCalculateResponse? calculateResponse,
      final PosSystemBagData? posBagData}) = _$_PosBagState;
  const _PosBagState._() : super._();

  @override
  bool get isLoading;
  @override
  bool get isUsersLoading;
  @override
  bool get isUserDetailsLoading;
  @override
  bool get isCurrenciesLoading;
  @override
  bool get isPaymentsLoading;
  @override
  bool get isDeliveriesLoading;
  @override
  bool get isCalculationsLoading;
  @override
  bool get isCreatingOrder;
  @override
  bool get isCreatingPayment;
  @override
  bool get isDeliveryInfoFilled;
  @override
  bool get isShopsLoading;
  @override
  List<UserData> get users;
  @override
  List<AddressData> get userAddresses;
  @override
  List<CurrencyData> get currencies;
  @override
  List<PaymentData> get payments;
  @override
  List<ShopDeliveryInfo> get shopsDeliverInfo;
  @override
  String get userQuery;
  @override
  double get subtotal;
  @override
  double get productTax;
  @override
  double get shopTax;
  @override
  ProductCalculateResponse? get calculateResponse;
  @override
  PosSystemBagData? get posBagData;
  @override
  @JsonKey(ignore: true)
  _$$_PosBagStateCopyWith<_$_PosBagState> get copyWith =>
      throw _privateConstructorUsedError;
}
