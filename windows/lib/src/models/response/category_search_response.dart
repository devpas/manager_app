import '../data/category_data.dart';

class CategorySearchResponse {
  CategorySearchResponse({List<CategoryData>? data}) {
    _data = data;
  }

  CategorySearchResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(CategoryData.fromJson(v));
      });
    }
  }

  List<CategoryData>? _data;

  CategorySearchResponse copyWith({List<CategoryData>? data}) =>
      CategorySearchResponse(data: data ?? _data);

  List<CategoryData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
