import '../data/brand_data.dart';

class SingleBrandResponse {
  SingleBrandResponse({
    String? timestamp,
    bool? status,
    String? message,
    BrandData? brandData,
  }) {
    _timestamp = timestamp;
    _status = status;
    _message = message;
    _brandData = brandData;
  }

  SingleBrandResponse.fromJson(dynamic json) {
    _timestamp = json['timestamp'];
    _status = json['status'];
    _message = json['message'];
    _brandData = json['data'] != null ? BrandData.fromJson(json['data']) : null;
  }

  String? _timestamp;
  bool? _status;
  String? _message;
  BrandData? _brandData;

  SingleBrandResponse copyWith({
    String? timestamp,
    bool? status,
    String? message,
    BrandData? brandData,
  }) =>
      SingleBrandResponse(
        timestamp: timestamp ?? _timestamp,
        status: status ?? _status,
        message: message ?? _message,
        brandData: brandData ?? _brandData,
      );

  String? get timestamp => _timestamp;

  bool? get status => _status;

  String? get message => _message;

  BrandData? get brandData => _brandData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['timestamp'] = _timestamp;
    map['status'] = _status;
    map['message'] = _message;
    if (_brandData != null) {
      map['data'] = _brandData?.toJson();
    }
    return map;
  }
}

