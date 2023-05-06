import '../data/category_data.dart';

class SingleCategoryPasResponse {
  SingleCategoryPasResponse({
    String? timestamp,
    bool? status,
    String? message,
    CategoryPasData? data,
  }) {
    _timestamp = timestamp;
    _status = status;
    _message = message;
    _data = data;
  }

  SingleCategoryPasResponse.fromJson(dynamic json) {
    _timestamp = json['timestamp'];
    _status = json['status'];
    _message = json['message'];
    _data =
        json['data'] != null ? CategoryPasData.fromJson(json['data']) : null;
  }

  String? _timestamp;
  bool? _status;
  String? _message;
  CategoryPasData? _data;

  SingleCategoryPasResponse copyWith({
    String? timestamp,
    bool? status,
    String? message,
    CategoryPasData? data,
  }) =>
      SingleCategoryPasResponse(
        timestamp: timestamp ?? _timestamp,
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );

  String? get timestamp => _timestamp;

  bool? get status => _status;

  String? get message => _message;

  CategoryPasData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['timestamp'] = _timestamp;
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}
