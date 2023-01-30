import 'pos_system_bag_data.dart';
import 'shop_delivery_info.dart';

class PosShopData {
  PosShopData({
    ShopDeliveryInfo? shopDelivery,
    List<PosSystemBagProductData>? products,
  }) {
    _shopDelivery = shopDelivery;
    _products = products;
  }

  ShopDeliveryInfo? _shopDelivery;
  List<PosSystemBagProductData>? _products;

  PosShopData copyWith({
    ShopDeliveryInfo? shopDelivery,
    List<PosSystemBagProductData>? products,
  }) =>
      PosShopData(
        shopDelivery: shopDelivery ?? _shopDelivery,
        products: products ?? _products,
      );

  ShopDeliveryInfo? get shopDelivery => _shopDelivery;

  List<PosSystemBagProductData>? get products => _products;
}
