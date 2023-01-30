import '../data/links.dart';
import '../data/shop_data.dart';
import '../data/meta.dart';

class ShopsPaginateResponse {
  ShopsPaginateResponse({List<ShopData>? shops, Links? links, Meta? meta}) {
    _shops = shops;
    _links = links;
    _meta = meta;
  }

  ShopsPaginateResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      _shops = [];
      json['data'].forEach((v) {
        _shops?.add(ShopData.fromJson(v));
      });
    }
    _links = json['links'] != null ? Links.fromJson(json['links']) : null;
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  List<ShopData>? _shops;
  Links? _links;
  Meta? _meta;

  ShopsPaginateResponse copyWith({
    List<ShopData>? shops,
    Links? links,
    Meta? meta,
  }) =>
      ShopsPaginateResponse(
        shops: shops ?? _shops,
        links: links ?? _links,
        meta: meta ?? _meta,
      );

  List<ShopData>? get shops => _shops;

  Links? get links => _links;

  Meta? get meta => _meta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_shops != null) {
      map['data'] = _shops?.map((v) => v.toJson()).toList();
    }
    if (_links != null) {
      map['links'] = _links?.toJson();
    }
    if (_meta != null) {
      map['meta'] = _meta?.toJson();
    }
    return map;
  }
}
