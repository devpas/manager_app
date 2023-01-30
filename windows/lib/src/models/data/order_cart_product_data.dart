import 'product_data.dart';
import 'shop_data.dart';

class OrderShopData {
  final ShopData shop;
  final List<OrderCartProductData> products;

  OrderShopData({required this.shop, required this.products});
}

class OrderCartProductData {
  final int quantity;
  final Stocks? stock;
  final ProductData? product;

  OrderCartProductData({
    required this.quantity,
    this.stock,
    this.product,
  });

  OrderCartProductData copyWith({
    required int quantity,
    Stocks? stock,
    ProductData? product,
  }) =>
      OrderCartProductData(
        quantity: quantity,
        stock: stock ?? this.stock,
        product: product ?? this.product,
      );
}
