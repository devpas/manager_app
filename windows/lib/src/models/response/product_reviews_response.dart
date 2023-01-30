import '../data/product_data.dart';
import '../data/user_data.dart';

class ProductReviewsResponse {
  ProductReviewsResponse({List<ProductReviewData>? data}) {
    _data = data;
  }

  ProductReviewsResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ProductReviewData.fromJson(v));
      });
    }
  }

  List<ProductReviewData>? _data;

  ProductReviewsResponse copyWith({List<ProductReviewData>? data}) =>
      ProductReviewsResponse(data: data ?? _data);

  List<ProductReviewData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ProductReviewData {
  ProductReviewData({
    int? id,
    int? reviewableId,
    String? rating,
    String? comment,
    String? img,
    String? createdAt,
    String? updatedAt,
    UserData? user,
    ProductData? product,
  }) {
    _id = id;
    _reviewableId = reviewableId;
    _rating = rating;
    _comment = comment;
    _img = img;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _user = user;
    _product = product;
  }

  ProductReviewData.fromJson(dynamic json) {
    _id = json['id'];
    _reviewableId = json['reviewable_id'];
    _rating = json['rating'];
    _comment = json['comment'];
    _img = json['img'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _user = json['user'] != null ? UserData.fromJson(json['user']) : null;
    _product =
        json['product'] != null ? ProductData.fromJson(json['product']) : null;
  }

  int? _id;
  int? _reviewableId;
  String? _rating;
  String? _comment;
  String? _img;
  String? _createdAt;
  String? _updatedAt;
  UserData? _user;
  ProductData? _product;

  ProductReviewData copyWith({
    int? id,
    int? reviewableId,
    String? rating,
    String? comment,
    String? img,
    String? createdAt,
    String? updatedAt,
    UserData? user,
    ProductData? product,
  }) =>
      ProductReviewData(
        id: id ?? _id,
        reviewableId: reviewableId ?? _reviewableId,
        rating: rating ?? _rating,
        comment: comment ?? _comment,
        img: img ?? _img,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        user: user ?? _user,
        product: product ?? _product,
      );

  int? get id => _id;

  int? get reviewableId => _reviewableId;

  String? get rating => _rating;

  String? get comment => _comment;

  String? get img => _img;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  UserData? get user => _user;

  ProductData? get product => _product;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['reviewable_id'] = _reviewableId;
    map['rating'] = _rating;
    map['comment'] = _comment;
    map['img'] = _img;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    if (_product != null) {
      map['product'] = _product?.toJson();
    }
    return map;
  }
}
