import '../data/brand_data.dart';

class BrandSearchResponse {
  BrandSearchResponse({List<BrandData>? data}) {
    _data = data;
  }

  BrandSearchResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(BrandData.fromJson(v));
      });
    }
  }

  List<BrandData>? _data;

  BrandSearchResponse copyWith({List<BrandData>? data}) =>
      BrandSearchResponse(data: data ?? _data);

  List<BrandData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
