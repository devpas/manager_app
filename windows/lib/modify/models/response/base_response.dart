import '../data/base_data.dart';

class BaseResponse {
  BaseResponse({List<BaseData>? base}) {
    _base = base;
  }

  BaseResponse.fromJson(dynamic json) {
    if (json["data"] != null) {
      _base = [];
      json["data"].forEach((v) {
        _base?.add(BaseData.fromJson(v));
      });
    }
  }

  List<BaseData>? _base;

  BaseResponse copyWith({List<BaseData>? base}) =>
      BaseResponse(base: base ?? _base);

  List<BaseData>? get base => _base;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_base != null) {
      map['data'] = _base?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
