import '../data/product_data.dart';

class ProductsPasResponse {
  ProductsPasResponse({List<ProductPasData>? products}) {
    _products = products;
  }

  ProductsPasResponse.fromJson(dynamic json) {
    if (json["data"] != null) {
      _products = [];
      json["data"].forEach((v) {
        _products?.add(ProductPasData.fromJson(v));
      });
    }
  }

  List<ProductPasData>? _products;

  ProductsPasResponse copyWith({List<ProductPasData>? products}) =>
      ProductsPasResponse(products: products ?? _products);

  List<ProductPasData>? get products => _products;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_products != null) {
      map['data'] = _products?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
