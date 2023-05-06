import '../data/category_data.dart';

class CategoriesPasResponse {
  CategoriesPasResponse({List<CategoryPasData>? categories}) {
    _categories = categories;
  }

  CategoriesPasResponse.fromJson(dynamic json) {
    if (json["data"] != null) {
      _categories = [];
      json["data"].forEach((v) {
        _categories?.add(CategoryPasData.fromJson(v));
      });
    }
  }

  List<CategoryPasData>? _categories;

  CategoriesPasResponse copyWith({List<CategoryPasData>? categories}) =>
      CategoriesPasResponse(categories: categories ?? _categories);

  List<CategoryPasData>? get categories => _categories;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_categories != null) {
      map['data'] = _categories?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
