import '../data/shop_data.dart';

class ShopResponse {
  ShopResponse({List<ShopData>? shops}) {
    _shops = shops;
  }

  ShopResponse.fromJson(dynamic json) {
    if (json["data"] != null) {
      _shops = [];
      json["data"].forEach((v) {
        _shops?.add(ShopData.fromJson(v));
      });
    }
  }

  List<ShopData>? _shops;

  ShopResponse copyWith({List<ShopData>? shops}) =>
      ShopResponse(shops: shops ?? _shops);

  List<ShopData>? get shops => _shops;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_shops != null) {
      map['data'] = _shops?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
