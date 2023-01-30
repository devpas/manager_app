import '../data/location.dart';
import '../data/translation.dart';

class SingleShopResponse {
  SingleShopResponse({
    String? timestamp,
    bool? status,
    String? message,
    Data? data,
  }) {
    _timestamp = timestamp;
    _status = status;
    _message = message;
    _data = data;
  }

  SingleShopResponse.fromJson(dynamic json) {
    _timestamp = json['timestamp'];
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  String? _timestamp;
  bool? _status;
  String? _message;
  Data? _data;

  SingleShopResponse copyWith({
    String? timestamp,
    bool? status,
    String? message,
    Data? data,
  }) =>
      SingleShopResponse(
        timestamp: timestamp ?? _timestamp,
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );

  String? get timestamp => _timestamp;

  bool? get status => _status;

  String? get message => _message;

  Data? get data => _data;

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

class Data {
  Data({
    int? id,
    String? uuid,
    int? userId,
    int? tax,
    int? deliveryRange,
    int? percentage,
    Location? location,
    String? phone,
    bool? showType,
    bool? open,
    bool? visibility,
    String? openTime,
    String? closeTime,
    String? backgroundImg,
    String? logoImg,
    int? minAmount,
    String? status,
    String? statusNote,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
    Translation? translation,
    List<Translation>? translations,
  }) {
    _id = id;
    _uuid = uuid;
    _userId = userId;
    _tax = tax;
    _deliveryRange = deliveryRange;
    _percentage = percentage;
    _location = location;
    _phone = phone;
    _showType = showType;
    _open = open;
    _visibility = visibility;
    _openTime = openTime;
    _closeTime = closeTime;
    _backgroundImg = backgroundImg;
    _logoImg = logoImg;
    _minAmount = minAmount;
    _status = status;
    _statusNote = statusNote;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
    _translation = translation;
    _translations = translations;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _uuid = json['uuid'];
    _userId = json['user_id'];
    _tax = json['tax'];
    _deliveryRange = json['delivery_range'];
    _percentage = json['percentage'];
    _location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    _phone = json['phone'];
    _showType = json['show_type'];
    _open = json['open'];
    _visibility = json['visibility'];
    _openTime = json['open_time'];
    _closeTime = json['close_time'];
    _backgroundImg = json['background_img'];
    _logoImg = json['logo_img'];
    _minAmount = json['min_amount'];
    _status = json['status'];
    _statusNote = json['status_note'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
    _translation = json['translation'] != null
        ? Translation.fromJson(json['translation'])
        : null;
    if (json['translations'] != null) {
      _translations = [];
      json['translations'].forEach((v) {
        _translations?.add(Translation.fromJson(v));
      });
    }
  }

  int? _id;
  String? _uuid;
  int? _userId;
  int? _tax;
  int? _deliveryRange;
  int? _percentage;
  Location? _location;
  String? _phone;
  bool? _showType;
  bool? _open;
  bool? _visibility;
  String? _openTime;
  String? _closeTime;
  String? _backgroundImg;
  String? _logoImg;
  int? _minAmount;
  String? _status;
  String? _statusNote;
  String? _createdAt;
  String? _updatedAt;
  dynamic _deletedAt;
  Translation? _translation;
  List<Translation>? _translations;

  Data copyWith({
    int? id,
    String? uuid,
    int? userId,
    int? tax,
    int? deliveryRange,
    int? percentage,
    Location? location,
    String? phone,
    bool? showType,
    bool? open,
    bool? visibility,
    String? openTime,
    String? closeTime,
    String? backgroundImg,
    String? logoImg,
    int? minAmount,
    String? status,
    String? statusNote,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
    Translation? translation,
    List<Translation>? translations,
  }) =>
      Data(
        id: id ?? _id,
        uuid: uuid ?? _uuid,
        userId: userId ?? _userId,
        tax: tax ?? _tax,
        deliveryRange: deliveryRange ?? _deliveryRange,
        percentage: percentage ?? _percentage,
        location: location ?? _location,
        phone: phone ?? _phone,
        showType: showType ?? _showType,
        open: open ?? _open,
        visibility: visibility ?? _visibility,
        openTime: openTime ?? _openTime,
        closeTime: closeTime ?? _closeTime,
        backgroundImg: backgroundImg ?? _backgroundImg,
        logoImg: logoImg ?? _logoImg,
        minAmount: minAmount ?? _minAmount,
        status: status ?? _status,
        statusNote: statusNote ?? _statusNote,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        deletedAt: deletedAt ?? _deletedAt,
        translation: translation ?? _translation,
        translations: translations ?? _translations,
      );

  int? get id => _id;

  String? get uuid => _uuid;

  int? get userId => _userId;

  int? get tax => _tax;

  int? get deliveryRange => _deliveryRange;

  int? get percentage => _percentage;

  Location? get location => _location;

  String? get phone => _phone;

  bool? get showType => _showType;

  bool? get open => _open;

  bool? get visibility => _visibility;

  String? get openTime => _openTime;

  String? get closeTime => _closeTime;

  String? get backgroundImg => _backgroundImg;

  String? get logoImg => _logoImg;

  int? get minAmount => _minAmount;

  String? get status => _status;

  String? get statusNote => _statusNote;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  dynamic get deletedAt => _deletedAt;

  Translation? get translation => _translation;

  List<Translation>? get translations => _translations;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['uuid'] = _uuid;
    map['user_id'] = _userId;
    map['tax'] = _tax;
    map['delivery_range'] = _deliveryRange;
    map['percentage'] = _percentage;
    if (_location != null) {
      map['location'] = _location?.toJson();
    }
    map['phone'] = _phone;
    map['show_type'] = _showType;
    map['open'] = _open;
    map['visibility'] = _visibility;
    map['open_time'] = _openTime;
    map['close_time'] = _closeTime;
    map['background_img'] = _backgroundImg;
    map['logo_img'] = _logoImg;
    map['min_amount'] = _minAmount;
    map['status'] = _status;
    map['status_note'] = _statusNote;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['deleted_at'] = _deletedAt;
    if (_translation != null) {
      map['translation'] = _translation?.toJson();
    }
    if (_translations != null) {
      map['translations'] = _translations?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
