import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/constants.dart';
import '../../../core/utils/utils.dart';
import '../../../models/models.dart';
import '../../../repository/repository.dart';
import '../../states/states.dart';

class AddOrderNotifier extends StateNotifier<AddOrderState> {
  final UsersRepository _usersRepository;
  final CurrenciesRepository _currenciesRepository;
  final PaymentsRepository _paymentsRepository;
  final ShopsRepository _shopsRepository;
  final ProductsRepository _productsRepository;
  final CategoriesRepository _categoriesRepository;
  final BrandsRepository _brandsRepository;
  final OrdersRepository _ordersRepository;
  Timer? _userTimer;
  Timer? _shopTimer;
  Timer? _productTimer;
  Timer? _categoryTimer;
  Timer? _brandTimer;

  AddOrderNotifier(
    this._usersRepository,
    this._currenciesRepository,
    this._paymentsRepository,
    this._shopsRepository,
    this._productsRepository,
    this._categoriesRepository,
    this._brandsRepository,
    this._ordersRepository,
  ) : super(const AddOrderState());

  Future<void> fetchUsers({
    VoidCallback? checkYourNetwork,
    String? query,
  }) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(
          isUsersLoading: true, userQuery: query ?? state.userQuery);
      final response = await _usersRepository.searchUsers(
        query: state.userQuery.isEmpty ? null : state.userQuery,
      );
      response.when(
        success: (data) async {
          state = state.copyWith(
            isUsersLoading: false,
            users: data.data ?? [],
          );
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

  void setSelectedUser(BuildContext context, UserData? user) {
    state = state.copyWith(selectedUser: user, selectedAddress: null);
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
      final response =
          await _usersRepository.getUserDetails(state.selectedUser?.uuid);
      response.when(
        success: (data) async {
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

  void setSelectedAddress(AddressData address) {
    state = state.copyWith(selectedAddress: address);
  }

  Future<void> fetchCurrencies({VoidCallback? checkYourNetwork}) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isCurrenciesLoading: true, currencies: []);
      final response = await _currenciesRepository.getCurrencies();
      response.when(
        success: (data) async {
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

  void setSelectedCurrency(CurrencyData currency) {
    state = state.copyWith(selectedCurrency: currency);
  }

  Future<void> fetchPayments({VoidCallback? checkYourNetwork}) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isPaymentsLoading: true, payments: []);
      final response = await _paymentsRepository.getPayments();
      response.when(
        success: (data) async {
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

  void setSelectedPayment(PaymentData payment) {
    state = state.copyWith(selectedPayment: payment);
  }

  void clearAllProductFilters() {
    state = state.copyWith(
      selectedShop: null,
      selectedCategory: null,
      selectedBrand: null,
    );
  }

  Future<void> fetchShops({
    VoidCallback? checkYourNetwork,
    String? query,
  }) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(
        isShopsLoading: true,
        shops: [],
        shopQuery: query ?? state.shopQuery,
      );
      final response = await _shopsRepository
          .searchShops(state.shopQuery.isEmpty ? null : state.shopQuery);
      response.when(
        success: (data) {
          state =
              state.copyWith(isShopsLoading: false, shops: data.shops ?? []);
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

  void setShopQuery(BuildContext context, String query) {
    if (state.shopQuery == query) {
      return;
    }
    state = state.copyWith(shopQuery: query.trim());
    if (_shopTimer?.isActive ?? false) {
      _shopTimer?.cancel();
    }
    _shopTimer = Timer(
      const Duration(milliseconds: 500),
      () {
        fetchShops(
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

  void setSelectedShop(ShopData? shop) {
    state = state.copyWith(selectedShop: shop);
  }

  Future<void> fetchProducts({
    VoidCallback? checkYourNetwork,
    String? query,
  }) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(
        isProductSearchLoading: true,
        searchedProducts: [],
        productQuery: query ?? state.productQuery,
      );
      final response = await _productsRepository.getProductsPaginate(
        query: state.productQuery.isEmpty ? null : state.productQuery,
        shopId: state.selectedShop?.id,
        categoryId: state.selectedCategory?.id,
        brandId: state.selectedBrand?.id,
      );
      response.when(
        success: (data) async {
          state = state.copyWith(
            isProductSearchLoading: false,
            searchedProducts: data.data ?? [],
          );
        },
        failure: (failure) {
          state = state.copyWith(isProductSearchLoading: false);
          debugPrint('==> get products failure: $failure');
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }

  void setProductQuery(BuildContext context, String query) {
    if (state.productQuery == query) {
      return;
    }
    state = state.copyWith(productQuery: query.trim());
    if (_productTimer?.isActive ?? false) {
      _productTimer?.cancel();
    }
    _productTimer = Timer(
      const Duration(milliseconds: 500),
      () {
        fetchProducts(
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

  Future<void> fetchCategories({
    VoidCallback? checkYourNetwork,
    String? query,
  }) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(
        isCategoriesLoading: true,
        categories: [],
        categoryQuery: query ?? state.categoryQuery,
      );
      final response = await _categoriesRepository.searchCategory(
          state.categoryQuery.isEmpty ? null : state.categoryQuery);
      response.when(
        success: (data) {
          state = state.copyWith(
            isCategoriesLoading: false,
            categories: data.data ?? [],
          );
        },
        failure: (failure) {
          state = state.copyWith(isCategoriesLoading: false);
          debugPrint('==> get shops failure: $failure');
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }

  void setCategoryQuery(BuildContext context, String query) {
    if (state.categoryQuery == query) {
      return;
    }
    state = state.copyWith(categoryQuery: query.trim());
    if (_categoryTimer?.isActive ?? false) {
      _categoryTimer?.cancel();
    }
    _categoryTimer = Timer(
      const Duration(milliseconds: 500),
      () {
        fetchCategories(
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

  void setSelectedCategory(CategoryData? category) {
    state = state.copyWith(selectedCategory: category);
  }

  Future<void> fetchBrands({
    VoidCallback? checkYourNetwork,
    String? query,
  }) async {
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(
        isBrandsLoading: true,
        brands: [],
        brandQuery: query ?? state.brandQuery,
      );
      final response = await _brandsRepository
          .searchBrands(state.brandQuery.isEmpty ? null : state.brandQuery);
      response.when(
        success: (data) {
          state = state.copyWith(
            isBrandsLoading: false,
            brands: data.data ?? [],
          );
        },
        failure: (failure) {
          state = state.copyWith(isBrandsLoading: false);
          debugPrint('==> get brands failure: $failure');
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }

  void setBrandQuery(BuildContext context, String query) {
    if (state.brandQuery == query) {
      return;
    }
    state = state.copyWith(brandQuery: query.trim());
    if (_brandTimer?.isActive ?? false) {
      _brandTimer?.cancel();
    }
    _brandTimer = Timer(
      const Duration(milliseconds: 500),
      () {
        fetchBrands(
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

  void setSelectedBrand(BrandData? brand) {
    state = state.copyWith(selectedBrand: brand);
  }

  void addOrderProduct(
    BuildContext context,
    Stocks stock,
    int quantity,
    ProductData product,
  ) {
    List<OrderCartProductData> orderProducts = List.from(state.orderProducts);
    int? addedIndex;
    for (int i = 0; i < orderProducts.length; i++) {
      if (orderProducts[i].stock?.id == stock.id &&
          orderProducts[i].product?.id == product.id) {
        addedIndex = i;
        break;
      }
    }
    if (addedIndex != null) {
      orderProducts.removeAt(addedIndex);
    }
    orderProducts.insert(
      0,
      OrderCartProductData(quantity: quantity, stock: stock, product: product),
    );
    state = state.copyWith(orderProducts: orderProducts);
    fetchShopsForOrder(
      checkYourNetwork: () {
        AppHelpers.showCheckFlash(
          context,
          AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
        );
      },
    );
  }

  Future<void> fetchShopsForOrder({
    VoidCallback? checkYourNetwork,
  }) async {
    final List<OrderCartProductData> orderProducts = state.orderProducts;
    List<int> shopIds = [];
    for (final product in orderProducts) {
      shopIds.add(product.product?.shopId ?? 0);
    }
    shopIds = shopIds.toSet().toList();
    final connected = await AppConnectivity.connectivity();
    if (connected) {
      state = state.copyWith(isProductAdding: true);
      final response = await _shopsRepository.getShopsByIds(shopIds);
      response.when(
        success: (data) {
          final List<ShopData> shops = data.shops ?? [];
          List<OrderShopData> orderShops = [];
          double subtotal = 0;
          double productTax = 0;
          double shopTax = 0;
          for (final shop in shops) {
            List<OrderCartProductData> products = [];
            for (final product in orderProducts) {
              if (product.product?.shopId == shop.id) {
                products.add(product);
                subtotal += (product.stock?.totalPrice ?? 0) * product.quantity;
                productTax += (product.stock?.tax ?? 0) * product.quantity;
                shopTax += ((shop.tax ?? 0) / 100) *
                    ((product.stock?.totalPrice ?? 0)) *
                    product.quantity;
              }
            }
            orderShops.add(OrderShopData(shop: shop, products: products));
          }
          state = state.copyWith(
            orderShops: orderShops,
            isProductAdding: false,
            subtotal: subtotal,
            productTax: productTax,
            shopTax: shopTax,
          );
        },
        failure: (failure) {
          state = state.copyWith(isProductAdding: false);
          debugPrint('==> get brands failure: $failure');
        },
      );
    } else {
      checkYourNetwork?.call();
    }
  }

  void increaseProductCount(OrderCartProductData productData) {
    if (productData.quantity >= (productData.stock?.product?.maxQty ?? 10000)) {
      return;
    }
    final List<OrderCartProductData> orderProducts =
        List.from(state.orderProducts);
    int? index;
    for (int i = 0; i < orderProducts.length; i++) {
      if (productData.stock?.id == orderProducts[i].stock?.id) {
        index = i;
        break;
      }
    }
    if (index == null) {
      return;
    }
    orderProducts[index] =
        productData.copyWith(quantity: productData.quantity + 1);
    List<OrderShopData> orderShops = List.from(state.orderShops);
    int? shopIndex;
    int? productIndex;
    for (int i = 0; i < orderShops.length; i++) {
      for (int j = 0; j < orderShops[i].products.length; j++) {
        if (productData.stock?.id == orderShops[i].products[j].stock?.id) {
          shopIndex = i;
          productIndex = j;
          break;
        }
      }
    }
    if (shopIndex == null || productIndex == null) {
      return;
    }
    final List<OrderCartProductData> products = orderShops[shopIndex].products;
    products[productIndex] = orderProducts[index];
    orderShops[shopIndex] =
        OrderShopData(shop: orderShops[shopIndex].shop, products: products);
    double subtotal = 0;
    double productTax = 0;
    double shopTax = 0;
    for (final orderShop in orderShops) {
      for (final product in orderShop.products) {
        if (product.stock?.product?.shopId == orderShop.shop.id) {
          subtotal += (product.stock?.totalPrice ?? 0) * product.quantity;
          productTax += (product.stock?.tax ?? 0) * product.quantity;
          shopTax += ((orderShop.shop.tax ?? 0) / 100) *
              ((product.stock?.totalPrice ?? 0)) *
              product.quantity;
        }
      }
    }
    state = state.copyWith(
      orderShops: orderShops,
      orderProducts: orderProducts,
      subtotal: subtotal,
      productTax: productTax,
      shopTax: shopTax,
    );
  }

  void decreaseProductCount(OrderCartProductData productData) {
    if (productData.quantity < 2 ||
        (productData.quantity <= (productData.stock?.product?.minQty ?? 0))) {
      return;
    }
    final List<OrderCartProductData> orderProducts =
        List.from(state.orderProducts);
    int? index;
    for (int i = 0; i < orderProducts.length; i++) {
      if (productData.stock?.id == orderProducts[i].stock?.id) {
        index = i;
        break;
      }
    }
    if (index == null) {
      return;
    }
    orderProducts[index] =
        productData.copyWith(quantity: productData.quantity - 1);
    List<OrderShopData> orderShops = List.from(state.orderShops);
    int? shopIndex;
    int? productIndex;
    for (int i = 0; i < orderShops.length; i++) {
      for (int j = 0; j < orderShops[i].products.length; j++) {
        if (productData.stock?.id == orderShops[i].products[j].stock?.id) {
          shopIndex = i;
          productIndex = j;
          break;
        }
      }
    }
    if (shopIndex == null || productIndex == null) {
      return;
    }
    final List<OrderCartProductData> products = orderShops[shopIndex].products;
    products[productIndex] = orderProducts[index];
    orderShops[shopIndex] =
        OrderShopData(shop: orderShops[shopIndex].shop, products: products);
    double subtotal = 0;
    double productTax = 0;
    double shopTax = 0;
    for (final orderShop in orderShops) {
      for (final product in orderShop.products) {
        if (product.stock?.product?.shopId == orderShop.shop.id) {
          subtotal += (product.stock?.totalPrice ?? 0) * product.quantity;
          productTax += (product.stock?.tax ?? 0) * product.quantity;
          shopTax += ((orderShop.shop.tax ?? 0) / 100) *
              ((product.stock?.totalPrice ?? 0)) *
              product.quantity;
        }
      }
    }
    state = state.copyWith(
      orderShops: orderShops,
      orderProducts: orderProducts,
      subtotal: subtotal,
      productTax: productTax,
      shopTax: shopTax,
    );
  }

  void deleteProductFromCart(
      BuildContext context, OrderCartProductData productData) {
    final List<OrderCartProductData> orderProducts =
        List.from(state.orderProducts);
    int? index;
    for (int i = 0; i < orderProducts.length; i++) {
      if (orderProducts[i].stock?.id == productData.stock?.id) {
        index = i;
        break;
      }
    }
    if (index == null) {
      return;
    }
    orderProducts.removeAt(index);
    List<OrderShopData> orderShops = List.from(state.orderShops);
    int? shopIndex;
    int? productIndex;
    for (int i = 0; i < orderShops.length; i++) {
      for (int j = 0; j < orderShops[i].products.length; j++) {
        if (productData.stock?.id == orderShops[i].products[j].stock?.id) {
          shopIndex = i;
          productIndex = j;
          break;
        }
      }
    }
    if (shopIndex == null || productIndex == null) {
      return;
    }
    final List<OrderCartProductData> products = orderShops[shopIndex].products;
    products.removeAt(productIndex);
    if (products.isEmpty) {
      orderShops.removeAt(shopIndex);
      double subtotal = 0;
      double productTax = 0;
      double shopTax = 0;
      for (final orderShop in orderShops) {
        for (final product in orderShop.products) {
          if (product.stock?.product?.shopId == orderShop.shop.id) {
            subtotal += (product.stock?.totalPrice ?? 0) * product.quantity;
            productTax += (product.stock?.tax ?? 0) * product.quantity;
            shopTax += ((orderShop.shop.tax ?? 0) / 100) *
                ((product.stock?.totalPrice ?? 0)) *
                product.quantity;
          }
        }
      }
      state = state.copyWith(
        orderShops: orderShops,
        orderProducts: orderProducts,
        subtotal: subtotal,
        productTax: productTax,
        shopTax: shopTax,
      );
      fetchShops(
        checkYourNetwork: () {
          AppHelpers.showCheckFlash(
            context,
            AppHelpers.getTranslation(TrKeys.checkYourNetworkConnection),
          );
        },
      );
      return;
    }
    orderShops[shopIndex] =
        OrderShopData(shop: orderShops[shopIndex].shop, products: products);
    double subtotal = 0;
    double productTax = 0;
    double shopTax = 0;
    for (final orderShop in orderShops) {
      for (final product in orderShop.products) {
        if (product.stock?.product?.shopId == orderShop.shop.id) {
          subtotal += (product.stock?.totalPrice ?? 0) * product.quantity;
          productTax += (product.stock?.tax ?? 0) * product.quantity;
          shopTax += ((orderShop.shop.tax ?? 0) / 100) *
              ((product.stock?.totalPrice ?? 0)) *
              product.quantity;
        }
      }
    }
    state = state.copyWith(
      orderShops: orderShops,
      orderProducts: orderProducts,
      subtotal: subtotal,
      productTax: productTax,
      shopTax: shopTax,
    );
    fetchShops(
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
    debugPrint('===> fetch shop deliveries ');
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
      debugPrint('===> fetch shop deliveries is delivery $isDelivery');
      if (isDelivery) {
        final response = await _shopsRepository.getOnlyDeliveries();
        response.when(
          success: (data) {
            List<ShopDeliveryInfo> shopDeliveries = [];
            for (final shop in state.shops) {
              shopDeliveries.add(
                ShopDeliveryInfo(shop: shop, shopDeliveries: data.data),
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
        for (final orderShop in state.orderShops) {
          shopDeliveries.add(
            ShopDeliveryInfo(
              shop: orderShop.shop,
              shopDeliveries: orderShop.shop.deliveries,
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

      final response =
          await _productsRepository.getAllCalculations(state.orderProducts);
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
      for (final orderShop in state.orderShops) {
        List<ProductOrder> products = [];
        num shopTax = 0;
        for (final product in orderShop.products) {
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
          if (deliveryInfo.shop?.id == orderShop.shop.id) {
            deliveryId = deliveryInfo.selectedShopDelivery?.id;
            deliveryFee = deliveryInfo.selectedShopDelivery?.price;
            deliveryDate = deliveryInfo.deliveryDate;
            deliveryTime = deliveryInfo.deliveryTime;
            break;
          }
        }
        shopsOrder.add(
          ShopOrder(
            shopId: orderShop.shop.id ?? 0,
            deliveryFee: deliveryFee,
            deliveryTypeId: deliveryId,
            deliveryAddressId: state.selectedAddress?.id,
            tax: shopTax,
            products: products,
            deliveryDate: deliveryDate,
            deliveryTime: deliveryTime,
          ),
        );
      }
      final orderBody = OrderBodyData(
        userId: state.selectedUser?.id ?? 0,
        total: (state.calculateResponse?.data?.orderTotal ?? 0) +
            (deliveryFee ?? 0),
        currencyId: state.selectedCurrency?.id ?? 0,
        currencyRate: state.selectedCurrency?.rate ?? 0,
        shops: shopsOrder,
      );
      log(orderBody.toString());
      // return;
      final response = await _ordersRepository.createOrder(orderBody);
      response.when(
        success: (data) {
          createTransaction(
            orderId: data.data?.id,
            paymentId: state.selectedPayment?.id,
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
}
