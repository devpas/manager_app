import 'dart:async';
import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils/utils.dart';
import '../../../../models/models.dart';
import '../../../../presentation/pages/pos_system/pos_bag/widgets/choose_deliveries_modal_in_pos_bag.dart';
import '../../../../repository/repository.dart';
import '../../../states/states.dart';
import '../../notifiers.dart';

class PosBagNotifier extends StateNotifier<PosBagState> {
  final UsersRepository _usersRepository;
  final CurrenciesRepository _currenciesRepository;
  final PaymentsRepository _paymentsRepository;
  final ShopsRepository _shopsRepository;
  final ProductsRepository _productsRepository;
  final OrdersRepository _ordersRepository;
  Timer? _userTimer;

  PosBagNotifier(
    this._usersRepository,
    this._currenciesRepository,
    this._paymentsRepository,
    this._shopsRepository,
    this._productsRepository,
    this._ordersRepository,
  ) : super(const PosBagState());

  void setInitialPosBag(BuildContext context, PosSystemBagData bag) {
    state = state.copyWith(posBagData: bag);
    fetchCurrencies(
      checkYourNetwork: () {
        AppHelpers.showCheckFlash(
          context,
          AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
        );
      },
    );
    fetchPayments(
      checkYourNetwork: () {
        AppHelpers.showCheckFlash(
          context,
          AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
        );
      },
    );
    fetchShopsForOrder(
      checkYourNetwork: () {
        AppHelpers.showCheckFlash(
          context,
          AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
        );
      },
    );
  }

  Future<void> fetchUsers({
    VoidCallback? checkYourNetwork,
    String? query,
  }) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(
        isUsersLoading: true,
        userQuery: query ?? state.userQuery,
      );
      final response = await _usersRepository.searchUsers(
        query: state.userQuery.isEmpty ? null : state.userQuery,
      );
      response.when(
        success: (data) {
          state = state.copyWith(isUsersLoading: false, users: data.data ?? []);
        },
        failure: (failure) {
          state = state.copyWith(isUsersLoading: false);
          debugPrint('==> get users failure: $failure');
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }

  void setUserQuery(BuildContext context, String query) {
    if (state.userQuery == query) {
      return;
    }
    state = state.copyWith(userQuery: query.trim());
    if (_userTimer?.isActive ?? false) {
      _userTimer?.cancel();
    }
    _userTimer = Timer(
      const Duration(milliseconds: 500),
      () {
        fetchUsers(
          checkYourNetwork: () {
            AppHelpers.showCheckFlash(
              context,
              AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
            );
          },
        );
      },
    );
  }

  void setSelectedUser(
    BuildContext context,
    PosSystemNotifier posSystemNotifier,
    UserData? user,
  ) {
    final bag = state.posBagData?.copyWith(selectedUser: user);
    state = state.copyWith(posBagData: bag);
    posSystemNotifier.updatePosBag(bag);
    fetchUserDetails(
      checkYourNetwork: () {
        AppHelpers.showCheckFlash(
          context,
          AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
        );
      },
    );
  }

  Future<void> fetchUserDetails({VoidCallback? checkYourNetwork}) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isUserDetailsLoading: true);
      final response = await _usersRepository
          .getUserDetails(state.posBagData?.selectedUser?.uuid);
      response.when(
        success: (data) {
          state = state.copyWith(
            isUserDetailsLoading: false,
            userAddresses: data.data?.addresses ?? [],
          );
        },
        failure: (failure) {
          state = state.copyWith(isUserDetailsLoading: false);
          debugPrint('==> get users details failure: $failure');
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }

  void setSelectedAddress(
    PosSystemNotifier posSystemNotifier,
    AddressData address,
  ) {
    final user = state.posBagData?.selectedUser;
    final bag = state.posBagData
        ?.copyWith(selectedAddress: address, selectedUser: user);
    state = state.copyWith(posBagData: bag);
    posSystemNotifier.updatePosBag(bag);
  }

  Future<void> fetchCurrencies({VoidCallback? checkYourNetwork}) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isCurrenciesLoading: true, currencies: []);
      final response = await _currenciesRepository.getCurrencies();
      response.when(
        success: (data) {
          state = state.copyWith(
            isCurrenciesLoading: false,
            currencies: data.data ?? [],
          );
        },
        failure: (failure) {
          state = state.copyWith(isCurrenciesLoading: false);
          debugPrint('==> get currencies failure: $failure');
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }

  void setSelectedCurrency(
    PosSystemNotifier posSystemNotifier,
    CurrencyData currency,
  ) {
    final user = state.posBagData?.selectedUser;
    final address = state.posBagData?.selectedAddress;
    final bag = state.posBagData?.copyWith(
      selectedCurrency: currency,
      selectedUser: user,
      selectedAddress: address,
    );
    state = state.copyWith(posBagData: bag);
    posSystemNotifier.updatePosBag(bag);
  }

  Future<void> fetchPayments({VoidCallback? checkYourNetwork}) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isPaymentsLoading: true, payments: []);
      final response = await _paymentsRepository.getPayments();
      response.when(
        success: (data) {
          final List<PaymentData> payments = data.data ?? [];
          List<PaymentData> filteredPayments = [];
          for (final payment in payments) {
            if (payment.tag == 'cash' || payment.tag == 'wallet') {
              filteredPayments.add(payment);
            }
          }
          state = state.copyWith(
            isPaymentsLoading: false,
            payments: filteredPayments,
          );
        },
        failure: (failure) {
          state = state.copyWith(isPaymentsLoading: false);
          debugPrint('==> get payments failure: $failure');
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }

  void setSelectedPayment(
    PosSystemNotifier posSystemNotifier,
    PaymentData payment,
  ) {
    final user = state.posBagData?.selectedUser;
    final address = state.posBagData?.selectedAddress;
    final bag = state.posBagData?.copyWith(
      selectedPayment: payment,
      selectedUser: user,
      selectedAddress: address,
    );
    state = state.copyWith(posBagData: bag);
    posSystemNotifier.updatePosBag(bag);
  }

  Future<void> fetchShopsForOrder({
    VoidCallback? checkYourNetwork,
  }) async {
    final List<PosSystemBagProductData> bagProducts =
        state.posBagData?.bagProducts ?? [];
    List<int> shopIds = [];
    for (final product in bagProducts) {
      shopIds.add(product.product?.shopId ?? 0);
    }
    shopIds = shopIds.toSet().toList();
    if (shopIds.isEmpty) {
      return;
    }
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isShopsLoading: true);
      final response = await _shopsRepository.getShopsByIds(shopIds);
      response.when(
        success: (data) {
          final List<ShopData> shops = data.shops ?? [];
          List<PosShopData> posShops = [];
          double subtotal = 0;
          double productTax = 0;
          double shopTax = 0;
          for (int i = 0; i < shops.length; i++) {
            List<PosSystemBagProductData> products = [];
            for (final product in (state.posBagData?.bagProducts ??
                <PosSystemBagProductData>[])) {
              if (product.product?.shopId == shops[i].id) {
                products.add(product);
                subtotal +=
                    (product.stock?.totalPrice ?? 0) * (product.quantity ?? 1);
                productTax +=
                    (product.stock?.tax ?? 0) * (product.quantity ?? 1);
                shopTax += ((shops[i].tax ?? 0) / 100) *
                    ((product.stock?.totalPrice ?? 0)) *
                    (product.quantity ?? 1);
              }
            }
            posShops.add(
              PosShopData(
                shopDelivery: ShopDeliveryInfo(shop: shops[i]),
                products: products,
              ),
            );
          }
          final bag = state.posBagData?.copyWith(posShops: posShops);
          state = state.copyWith(
            posBagData: bag,
            isShopsLoading: false,
            subtotal: subtotal,
            productTax: productTax,
            shopTax: shopTax,
          );
        },
        failure: (failure) {
          state = state.copyWith(isShopsLoading: false);
          debugPrint('==> get shops failure: $failure');
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }

  void increaseProductCount(
    PosSystemNotifier posSystemNotifier,
    PosSystemBagProductData? productData,
  ) {
    if ((productData?.quantity ?? 1) >=
        (productData?.stock?.product?.maxQty ?? 10000)) {
      return;
    }
    final List<PosSystemBagProductData> posProducts =
        List.from(state.posBagData?.bagProducts ?? []);
    int? index;
    for (int i = 0; i < posProducts.length; i++) {
      if (productData?.stock?.id == posProducts[i].stock?.id) {
        index = i;
        break;
      }
    }
    if (index == null || productData == null) {
      return;
    }
    posProducts[index] =
        productData.copyWith(quantity: (productData.quantity ?? 1) + 1);
    List<PosShopData> posShops = List.from(state.posBagData?.posShops ?? []);
    int? shopIndex;
    int? productIndex;
    for (int i = 0; i < posShops.length; i++) {
      final List<PosSystemBagProductData> products = posShops[i].products ?? [];
      for (int j = 0; j < products.length; j++) {
        if (productData.stock?.id == products[j].stock?.id) {
          shopIndex = i;
          productIndex = j;
          break;
        }
      }
    }
    if (shopIndex == null || productIndex == null) {
      return;
    }
    final List<PosSystemBagProductData> products =
        posShops[shopIndex].products ?? [];
    products[productIndex] = posProducts[index];
    posShops[shopIndex] = posShops[shopIndex].copyWith(products: products);
    double subtotal = 0;
    double productTax = 0;
    double shopTax = 0;
    for (final posShop in posShops) {
      for (final product in (posShop.products ?? <PosSystemBagProductData>[])) {
        if (product.stock?.product?.shopId == posShop.shopDelivery?.shop?.id) {
          subtotal +=
              (product.stock?.totalPrice ?? 0) * (product.quantity ?? 1);
          productTax += (product.stock?.tax ?? 0) * (product.quantity ?? 1);
          shopTax += ((posShop.shopDelivery?.shop?.tax ?? 0) / 100) *
              ((product.stock?.totalPrice ?? 0)) *
              (product.quantity ?? 1);
        }
      }
    }
    final bag = state.posBagData
        ?.copyWith(posShops: posShops, bagProducts: posProducts);
    state = state.copyWith(
      posBagData: bag,
      subtotal: subtotal,
      productTax: productTax,
      shopTax: shopTax,
    );
    posSystemNotifier.updatePosBag(bag);
  }

  void decreaseProductCount(
    PosSystemNotifier posSystemNotifier,
    PosSystemBagProductData? productData,
  ) {
    if ((productData?.quantity ?? 1) < 2 ||
        ((productData?.quantity ?? 1) <=
            (productData?.stock?.product?.minQty ?? 0))) {
      return;
    }
    final List<PosSystemBagProductData> posProducts =
        List.from(state.posBagData?.bagProducts ?? []);
    int? index;
    for (int i = 0; i < posProducts.length; i++) {
      if (productData?.stock?.id == posProducts[i].stock?.id) {
        index = i;
        break;
      }
    }
    if (index == null || productData == null) {
      return;
    }
    posProducts[index] =
        productData.copyWith(quantity: (productData.quantity ?? 1) - 1);
    List<PosShopData> posShops = List.from(state.posBagData?.posShops ?? []);
    int? shopIndex;
    int? productIndex;
    for (int i = 0; i < posShops.length; i++) {
      final List<PosSystemBagProductData> products = posShops[i].products ?? [];
      for (int j = 0; j < products.length; j++) {
        if (productData.stock?.id == products[j].stock?.id) {
          shopIndex = i;
          productIndex = j;
          break;
        }
      }
    }
    if (shopIndex == null || productIndex == null) {
      return;
    }
    final List<PosSystemBagProductData> products =
        posShops[shopIndex].products ?? [];
    products[productIndex] = posProducts[index];
    posShops[shopIndex] = posShops[shopIndex].copyWith(products: products);
    double subtotal = 0;
    double productTax = 0;
    double shopTax = 0;
    for (final posShop in posShops) {
      for (final product in (posShop.products ?? [])) {
        if (product.stock?.product?.shopId == posShop.shopDelivery?.shop?.id) {
          subtotal += (product.stock?.totalPrice ?? 0) * product.quantity;
          productTax += (product.stock?.tax ?? 0) * product.quantity;
          shopTax += ((posShop.shopDelivery?.shop?.tax ?? 0) / 100) *
              ((product.stock?.totalPrice ?? 0)) *
              product.quantity;
        }
      }
    }
    final bag = state.posBagData?.copyWith(posShops: posShops);
    state = state.copyWith(
      posBagData: bag,
      subtotal: subtotal,
      productTax: productTax,
      shopTax: shopTax,
    );
    posSystemNotifier.updatePosBag(bag);
  }

  void deleteProductFromBag(
    BuildContext context,
    PosSystemNotifier posSystemNotifier,
    PosSystemBagProductData? productData,
  ) {
    final List<PosSystemBagProductData> posProducts =
        List.from(state.posBagData?.bagProducts ?? []);
    int? index;
    for (int i = 0; i < posProducts.length; i++) {
      if (posProducts[i].stock?.id == productData?.stock?.id) {
        index = i;
        break;
      }
    }
    if (index == null) {
      return;
    }
    posProducts.removeAt(index);
    List<PosShopData> posShops = List.from(state.posBagData?.posShops ?? []);
    int? shopIndex;
    int? productIndex;
    for (int i = 0; i < posShops.length; i++) {
      final List<PosSystemBagProductData> products = posShops[i].products ?? [];
      for (int j = 0; j < products.length; j++) {
        if (productData?.stock?.id == products[j].stock?.id) {
          shopIndex = i;
          productIndex = j;
          break;
        }
      }
    }
    if (shopIndex == null || productIndex == null) {
      return;
    }
    final List<PosSystemBagProductData> products =
        posShops[shopIndex].products ?? [];
    products.removeAt(productIndex);
    if (products.isEmpty) {
      posShops.removeAt(shopIndex);
      double subtotal = 0;
      double productTax = 0;
      double shopTax = 0;
      for (final posShop in posShops) {
        for (final product in (posShop.products ?? [])) {
          if (product.stock?.product?.shopId ==
              posShop.shopDelivery?.shop?.id) {
            subtotal += (product.stock?.totalPrice ?? 0) * product.quantity;
            productTax += (product.stock?.tax ?? 0) * product.quantity;
            shopTax += ((posShop.shopDelivery?.shop?.tax ?? 0) / 100) *
                ((product.stock?.totalPrice ?? 0)) *
                product.quantity;
          }
        }
      }
      final bag = state.posBagData
          ?.copyWith(posShops: posShops, bagProducts: posProducts);
      state = state.copyWith(
        posBagData: bag,
        subtotal: subtotal,
        productTax: productTax,
        shopTax: shopTax,
      );
      posSystemNotifier.updatePosBag(bag);
      fetchShopsForOrder(
        checkYourNetwork: () {
          AppHelpers.showCheckFlash(
            context,
            AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
          );
        },
      );
      return;
    }
    posShops[shopIndex] = posShops[shopIndex].copyWith(products: products);
    double subtotal = 0;
    double productTax = 0;
    double shopTax = 0;
    for (final posShop in posShops) {
      for (final product in (posShop.products ?? [])) {
        if (product.stock?.product?.shopId == posShop.shopDelivery?.shop?.id) {
          subtotal += (product.stock?.totalPrice ?? 0) * product.quantity;
          productTax += (product.stock?.tax ?? 0) * product.quantity;
          shopTax += ((posShop.shopDelivery?.shop?.tax ?? 0) / 100) *
              ((product.stock?.totalPrice ?? 0)) *
              product.quantity;
        }
      }
    }
    final bag = state.posBagData
        ?.copyWith(posShops: posShops, bagProducts: posProducts);
    state = state.copyWith(
      posBagData: bag,
      subtotal: subtotal,
      productTax: productTax,
      shopTax: shopTax,
    );
    posSystemNotifier.updatePosBag(bag);
    fetchShopsForOrder(
      checkYourNetwork: () {
        AppHelpers.showCheckFlash(
          context,
          AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
        );
      },
    );
  }

  Future<void> fetchShopDeliveries({
    VoidCallback? checkYourNetwork,
  }) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(
        isDeliveriesLoading: true,
        isDeliveryInfoFilled: false,
      );
      final List<SettingsData> settings =
          LocalStorage.instance.getSettingsList();
      bool isDelivery = false;
      for (final setting in settings) {
        if (setting.key == 'delivery') {
          isDelivery = setting.value == '0';
          break;
        }
      }
      if (isDelivery) {
        final response = await _shopsRepository.getOnlyDeliveries();
        response.when(
          success: (data) {
            List<ShopDeliveryInfo> shopDeliveries = [];
            List<PosShopData> posShops = state.posBagData?.posShops ?? [];
            for (final posShop in posShops) {
              shopDeliveries.add(
                ShopDeliveryInfo(
                  shop: posShop.shopDelivery?.shop,
                  shopDeliveries: data.data,
                ),
              );
            }
            state = state.copyWith(
              shopsDeliverInfo: shopDeliveries,
              isDeliveriesLoading: false,
            );
          },
          failure: (failure) {
            state = state.copyWith(isDeliveriesLoading: false);
            debugPrint('==> get shop deliveries failure: $failure');
          },
        );
      } else {
        List<ShopDeliveryInfo> shopDeliveries = [];
        List<PosShopData> posShops = state.posBagData?.posShops ?? [];
        for (final posShop in posShops) {
          shopDeliveries.add(
            ShopDeliveryInfo(
              shop: posShop.shopDelivery?.shop,
              shopDeliveries: posShop.shopDelivery?.shop?.deliveries,
            ),
          );
        }
        state = state.copyWith(
          shopsDeliverInfo: shopDeliveries,
          isDeliveriesLoading: false,
        );
      }
    } else {
      checkYourNetwork?.call();
    }
  }

  void setDeliveryType(int? deliveryId, ShopDeliveryInfo deliveryInfo) {
    List<ShopDeliveryInfo> shopDeliveries = List.from(state.shopsDeliverInfo);
    int? index;
    for (int i = 0; i < shopDeliveries.length; i++) {
      if (shopDeliveries[i].shop?.id == deliveryInfo.shop?.id) {
        index = i;
        break;
      }
    }
    if (index != null) {
      ShopDelivery? shopDelivery;
      final List<ShopDelivery> deliveries = deliveryInfo.shopDeliveries ?? [];
      for (final delivery in deliveries) {
        if (delivery.id == deliveryId) {
          shopDelivery = delivery;
          break;
        }
      }
      shopDeliveries[index] =
          shopDeliveries[index].copyWith(selectedShopDelivery: shopDelivery);
      bool isDeliveriesSelected = true;
      for (final delivery in shopDeliveries) {
        if (delivery.selectedShopDelivery == null ||
            delivery.deliveryTime == null ||
            delivery.deliveryDate == null) {
          isDeliveriesSelected = false;
          break;
        }
      }
      state = state.copyWith(
        shopsDeliverInfo: shopDeliveries,
        isDeliveryInfoFilled: isDeliveriesSelected,
      );
    }
  }

  void setDeliveryDate(DateTime? deliveryDate, ShopDeliveryInfo deliveryInfo) {
    List<ShopDeliveryInfo> shopDeliveries = List.from(state.shopsDeliverInfo);
    int? index;
    for (int i = 0; i < shopDeliveries.length; i++) {
      if (shopDeliveries[i].shop?.id == deliveryInfo.shop?.id) {
        index = i;
        break;
      }
    }
    if (index != null) {
      final String formattedDate =
          DateFormat('yyyy-MM-dd').format(deliveryDate ?? DateTime.now());
      shopDeliveries[index] =
          shopDeliveries[index].copyWith(deliveryDate: formattedDate);
      bool isDeliveriesSelected = true;
      for (final delivery in shopDeliveries) {
        if (delivery.selectedShopDelivery == null ||
            delivery.deliveryTime == null ||
            delivery.deliveryDate == null) {
          isDeliveriesSelected = false;
          break;
        }
      }
      state = state.copyWith(
        shopsDeliverInfo: shopDeliveries,
        isDeliveryInfoFilled: isDeliveriesSelected,
      );
    }
  }

  void setDeliveryTime(DateTime? deliveryTime, ShopDeliveryInfo deliveryInfo) {
    List<ShopDeliveryInfo> shopDeliveries = List.from(state.shopsDeliverInfo);
    int? index;
    for (int i = 0; i < shopDeliveries.length; i++) {
      if (shopDeliveries[i].shop?.id == deliveryInfo.shop?.id) {
        index = i;
        break;
      }
    }
    if (index != null) {
      final String formattedDate =
          DateFormat.Hm().format(deliveryTime ?? DateTime.now());
      shopDeliveries[index] =
          shopDeliveries[index].copyWith(deliveryTime: formattedDate);
      bool isDeliveriesSelected = true;
      for (final delivery in shopDeliveries) {
        if (delivery.selectedShopDelivery == null ||
            delivery.deliveryTime == null ||
            delivery.deliveryDate == null) {
          isDeliveriesSelected = false;
          break;
        }
      }
      state = state.copyWith(
        shopsDeliverInfo: shopDeliveries,
        isDeliveryInfoFilled: isDeliveriesSelected,
      );
    }
  }

  Future<void> getCalculations({
    VoidCallback? checkYourNetwork,
  }) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isCalculationsLoading: true);
      final response = await _productsRepository
          .getAllCalculationsInPos(state.posBagData?.bagProducts ?? []);
      response.when(
        success: (data) async {
          state = state.copyWith(
            isCalculationsLoading: false,
            calculateResponse: data,
          );
        },
        failure: (failure) {
          state = state.copyWith(isCalculationsLoading: false);
          debugPrint('==> get calculations failure: $failure');
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }

  Future<void> makeAnOrder({
    VoidCallback? checkYourNetwork,
    VoidCallback? goToOrders,
  }) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isCreatingOrder: true);
      List<ShopOrder> shopsOrder = [];
      final List<CalculatedProduct> calculatedProducts =
          state.calculateResponse?.data?.products ?? [];
      num? deliveryFee;
      for (final posShop in (state.posBagData?.posShops ?? <PosShopData>[])) {
        List<ProductOrder> products = [];
        num shopTax = 0;
        for (final product
            in (posShop.products ?? <PosSystemBagProductData>[])) {
          for (final calculatedProduct in calculatedProducts) {
            if (calculatedProduct.id == product.stock?.id) {
              shopTax += calculatedProduct.shopTax ?? 0;
              products.add(
                ProductOrder(
                  stockId: calculatedProduct.id ?? 0,
                  price: calculatedProduct.price ?? 0,
                  quantity: calculatedProduct.qty ?? 0,
                  tax: calculatedProduct.tax ?? 0,
                  discount: calculatedProduct.discount ?? 0,
                  totalPrice: calculatedProduct.totalPrice ?? 0,
                ),
              );
            }
          }
        }
        int? deliveryId;
        String? deliveryDate;
        String? deliveryTime;
        for (final deliveryInfo in state.shopsDeliverInfo) {
          if (deliveryInfo.shop?.id == posShop.shopDelivery?.shop?.id) {
            deliveryId = deliveryInfo.selectedShopDelivery?.id;
            deliveryFee = deliveryInfo.selectedShopDelivery?.price;
            deliveryDate = deliveryInfo.deliveryDate;
            deliveryTime = deliveryInfo.deliveryTime;
            break;
          }
        }
        shopsOrder.add(
          ShopOrder(
            shopId: posShop.shopDelivery?.shop?.id ?? 0,
            deliveryFee: deliveryFee,
            deliveryTypeId: deliveryId,
            deliveryAddressId: state.posBagData?.selectedAddress?.id,
            tax: shopTax,
            products: products,
            deliveryDate: deliveryDate,
            deliveryTime: deliveryTime,
          ),
        );
      }
      final orderBody = OrderBodyData(
        userId: state.posBagData?.selectedUser?.id ?? 0,
        total: (state.calculateResponse?.data?.orderTotal ?? 0) +
            (deliveryFee ?? 0),
        currencyId: state.posBagData?.selectedCurrency?.id ?? 0,
        currencyRate: state.posBagData?.selectedCurrency?.rate ?? 0,
        shops: shopsOrder,
      );
      log(orderBody.toString());
      // return;
      final response = await _ordersRepository.createOrder(orderBody);
      response.when(
        success: (data) {
          createTransaction(
            orderId: data.data?.id,
            paymentId: state.posBagData?.selectedPayment?.id,
            checkYourNetwork: checkYourNetwork,
            goToOrders: goToOrders,
          );
        },
        failure: (failure) {
          state = state.copyWith(isCreatingOrder: false);
          debugPrint('==> create order failure: $failure');
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }

  Future<void> createTransaction({
    int? orderId,
    int? paymentId,
    VoidCallback? checkYourNetwork,
    VoidCallback? goToOrders,
  }) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isCreatingPayment: true);
      final transactionResponse = await _paymentsRepository.createTransaction(
        orderId: orderId ?? 0,
        paymentId: paymentId ?? 0,
      );
      transactionResponse.when(
        success: (data) {
          state = state.copyWith(isCreatingPayment: false);
          goToOrders?.call();
        },
        failure: (failure) {
          state = state.copyWith(isCreatingPayment: false);
          goToOrders?.call();
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }

  void chooseDeliveries(BuildContext context) {
    if (state.posBagData?.selectedUser == null) {
      AppHelpers.showCheckFlash(
        context,
        AppHelpers.getTranslation(TrKeys.pleaseSelectAUser),
      );
      return;
    }
    if (state.posBagData?.selectedAddress == null) {
      AppHelpers.showCheckFlash(
        context,
        AppHelpers.getTranslation(TrKeys.pleaseSelectAnAddress),
      );
      return;
    }
    if (state.posBagData?.selectedCurrency == null) {
      AppHelpers.showCheckFlash(
        context,
        AppHelpers.getTranslation(TrKeys.pleaseSelectACurrency),
      );
      return;
    }
    if (state.posBagData?.selectedPayment == null) {
      AppHelpers.showCheckFlash(
        context,
        AppHelpers.getTranslation(TrKeys.pleaseSelectAPayment),
      );
      return;
    }
    showCupertinoModalBottomSheet(
      context: context,
      builder: (context) => const ChooseDeliveriesModalInPosBag(),
    );
  }
}
