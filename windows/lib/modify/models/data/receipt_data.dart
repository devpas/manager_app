//receipts{
//id, money, datenew, attributes
//},

import 'package:intl/intl.dart';

class ReceiptData {
  ReceiptData({int? id, int? moneyId, DateTime? datenew, String? attributes}) {
    _id = id;
    _moneyId = moneyId;
    _datenew = datenew;
    _attributes = attributes;
  }

  ReceiptData.fromJson(dynamic json) {
    _id = json['id'];
    _moneyId = json['money_id'];
    _datenew = json['datenew'];
    _attributes = json['attributes'];
  }

  int? _id;
  int? _moneyId;
  DateTime? _datenew;
  String? _attributes;

  ReceiptData copyWith(
          {int? id, int? moneyId, DateTime? datenew, String? attributes}) =>
      ReceiptData(
        id: id ?? _id,
        moneyId: moneyId ?? _moneyId,
        datenew: datenew ?? _datenew,
        attributes: attributes ?? _attributes,
      );

  int? get id => _id;

  int? get moneyId => _moneyId;

  DateTime? get datenew => _datenew;

  String? get attributes => _attributes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['money_id'] = _moneyId;
    map['datenew'] = DateFormat.yMd().add_Hms().format(_datenew!);
    map['attributes'] = _attributes;
    return map;
  }
}
