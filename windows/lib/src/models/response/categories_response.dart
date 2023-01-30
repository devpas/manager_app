import '../data/category_data.dart';

class CategoriesResponse {
  CategoriesResponse({List<CategoryData>? categories}) {
    _categories = categories;
  }

  CategoriesResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      _categories = [];
      json['data'].forEach((v) {
        _categories?.add(CategoryData.fromJson(v));
      });
    }
  }

  List<CategoryData>? _categories;

  CategoriesResponse copyWith({List<CategoryData>? categories}) =>
      CategoriesResponse(categories: categories ?? _categories);

  List<CategoryData>? get categories => _categories;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_categories != null) {
      map['data'] = _categories?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
