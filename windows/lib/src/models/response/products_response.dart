import '../data/product_data.dart';

class ProductsResponse {
  ProductsResponse({List<ProductData>? data}) {
    _data = data;
  }

  ProductsResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ProductData.fromJson(v));
      });
    }
  }

  List<ProductData>? _data;

  ProductsResponse copyWith({List<ProductData>? data}) =>
      ProductsResponse(data: data ?? _data);

  List<ProductData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
