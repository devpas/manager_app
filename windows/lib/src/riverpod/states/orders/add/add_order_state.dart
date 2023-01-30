import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../models/models.dart';

part 'add_order_state.freezed.dart';

@freezed
class AddOrderState with _$AddOrderState {
  const factory AddOrderState({
    @Default(false) bool isLoading,
    @Default(false) bool isUsersLoading,
    @Default(false) bool isUserDetailsLoading,
    @Default(false) bool isCurrenciesLoading,
    @Default(false) bool isPaymentsLoading,
    @Default(false) bool isShopsLoading,
    @Default(false) bool isProductSearchLoading,
    @Default(false) bool isProductAdding,
    @Default(false) bool isCategoriesLoading,
    @Default(false) bool isBrandsLoading,
    @Default(false) bool isDeliveriesLoading,
    @Default(false) bool isCalculationsLoading,
    @Default(false) bool isCreatingOrder,
    @Default(false) bool isCreatingPayment,
    @Default(false) bool isDeliveryInfoFilled,
    @Default([]) List<UserData> users,
    @Default([]) List<AddressData> userAddresses,
    @Default([]) List<CurrencyData> currencies,
    @Default([]) List<PaymentData> payments,
    @Default([]) List<ShopData> shops,
    @Default([]) List<ProductData> searchedProducts,
    @Default([]) List<CategoryData> categories,
    @Default([]) List<BrandData> brands,
    @Default([]) List<OrderShopData> orderShops,
    @Default([]) List<OrderCartProductData> orderProducts,
    @Default([]) List<ShopDeliveryInfo> shopsDeliverInfo,
    @Default('') String userQuery,
    @Default('') String shopQuery,
    @Default('') String productQuery,
    @Default('') String categoryQuery,
    @Default('') String brandQuery,
    @Default(0) double subtotal,
    @Default(0) double productTax,
    @Default(0) double shopTax,
    UserData? selectedUser,
    AddressData? selectedAddress,
    CurrencyData? selectedCurrency,
    PaymentData? selectedPayment,
    ShopData? selectedShop,
    CategoryData? selectedCategory,
    BrandData? selectedBrand,
    ProductCalculateResponse? calculateResponse,
  }) = _AddOrderState;

  const AddOrderState._();
}
