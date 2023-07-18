//taxlines[
//id, receipt, tax_id, base, amount
//],

class TaxlineData {
  TaxlineData(
      {int? id, int? receiptId, int? taxId, double? base, double? amount}) {
    _id = id;
    _receiptId = receiptId;
    _taxId = taxId;
    _base = base;
    _amount = amount;
  }

  TaxlineData.fromJson(dynamic json) {
    _id = json['id'];
    _receiptId = json['receipt_id'];
    // _taxId = json['tax_id'];
    _taxId = 0;
    _base = double.parse(json['base'].toString());
    _amount = double.parse(json['amount'].toString());
  }

  int? _id;
  int? _receiptId;
  int? _taxId;
  double? _base;
  double? _amount;

  TaxlineData copyWith({
    int? id,
    int? receiptId,
    int? taxId,
    double? base,
    double? amount,
  }) =>
      TaxlineData(
        id: id ?? _id,
        receiptId: receiptId ?? _receiptId,
        taxId: taxId ?? _taxId,
        base: base ?? _base,
        amount: amount ?? _amount,
      );

  int? get id => _id;

  int? get receiptId => _receiptId;

  int? get taxId => _taxId;

  double? get base => _base;

  double? get amount => _amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['receipt_id'] = _receiptId;
    map['tax_id'] = _taxId;
    map['base'] = _base;
    map['amount'] = _amount;
    return map;
  }
}
