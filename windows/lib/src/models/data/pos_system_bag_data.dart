import '../response/payments_response.dart';
import 'address_data.dart';
import 'currency_data.dart';
import 'pos_shop_data.dart';
import 'product_data.dart';
import 'user_data.dart';

class PosSystemBagData {
  PosSystemBagData({
    int? index,
    UserData? selectedUser,
    AddressData? selectedAddress,
    CurrencyData? selectedCurrency,
    PaymentData? selectedPayment,
    List<PosSystemBagProductData>? bagProducts,
    List<PosShopData>? posShops,
  }) {
    _index = index;
    _selectedUser = selectedUser;
    _selectedAddress = selectedAddress;
    _selectedCurrency = selectedCurrency;
    _selectedPayment = selectedPayment;
    _bagProducts = bagProducts;
    _posShops = posShops;
  }

  int? _index;
  UserData? _selectedUser;
  AddressData? _selectedAddress;
  CurrencyData? _selectedCurrency;
  PaymentData? _selectedPayment;
  List<PosSystemBagProductData>? _bagProducts;
  List<PosShopData>? _posShops;

  PosSystemBagData copyWith({
    int? index,
    UserData? selectedUser,
    AddressData? selectedAddress,
    CurrencyData? selectedCurrency,
    PaymentData? selectedPayment,
    List<PosSystemBagProductData>? bagProducts,
    List<PosShopData>? posShops,
  }) =>
      PosSystemBagData(
        index: index ?? _index,
        selectedUser: selectedUser,
        selectedAddress: selectedAddress,
        selectedCurrency: selectedCurrency ?? _selectedCurrency,
        selectedPayment: selectedPayment ?? _selectedPayment,
        bagProducts: bagProducts ?? _bagProducts,
        posShops: posShops ?? _posShops,
      );

  int? get index => _index;

  UserData? get selectedUser => _selectedUser;

  AddressData? get selectedAddress => _selectedAddress;

  CurrencyData? get selectedCurrency => _selectedCurrency;

  PaymentData? get selectedPayment => _selectedPayment;

  List<PosSystemBagProductData>? get bagProducts => _bagProducts;

  List<PosShopData>? get posShops => _posShops;
}

class PosSystemBagProductData {
  PosSystemBagProductData({
    int? quantity,
    Stocks? stock,
    ProductData? product,
  }) {
    _quantity = quantity;
    _stock = stock;
    _product = product;
  }

  int? _quantity;
  Stocks? _stock;
  ProductData? _product;

  PosSystemBagProductData copyWith({
    int? quantity,
    Stocks? stock,
    ProductData? product,
  }) =>
      PosSystemBagProductData(
        quantity: quantity ?? _quantity,
        stock: stock ?? _stock,
        product: product ?? _product,
      );

  int? get quantity => _quantity;

  Stocks? get stock => _stock;

  ProductData? get product => _product;
}
