import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../models/models.dart';

part 'pos_bag_state.freezed.dart';

@freezed
class PosBagState with _$PosBagState {
  const factory PosBagState({
    @Default(false) bool isLoading,
    @Default(false) bool isUsersLoading,
    @Default(false) bool isUserDetailsLoading,
    @Default(false) bool isCurrenciesLoading,
    @Default(false) bool isPaymentsLoading,
    @Default(false) bool isDeliveriesLoading,
    @Default(false) bool isCalculationsLoading,
    @Default(false) bool isCreatingOrder,
    @Default(false) bool isCreatingPayment,
    @Default(false) bool isDeliveryInfoFilled,
    @Default(false) bool isShopsLoading,
    @Default([]) List<UserData> users,
    @Default([]) List<AddressData> userAddresses,
    @Default([]) List<CurrencyData> currencies,
    @Default([]) List<PaymentData> payments,
    @Default([]) List<ShopDeliveryInfo> shopsDeliverInfo,
    @Default('') String userQuery,
    @Default(0) double subtotal,
    @Default(0) double productTax,
    @Default(0) double shopTax,
    ProductCalculateResponse? calculateResponse,
    PosSystemBagData? posBagData,
  }) = _PosBagState;

  const PosBagState._();
}
