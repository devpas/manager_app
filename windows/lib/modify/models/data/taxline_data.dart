//taxlines[
//id, receipt, tax_id, base, amount
//],

class TaxlineData {
  TaxlineData({int? id, int? receiptId, int? taxId, int? base, int? amount}) {
    _id = id;
    _receiptId = receiptId;
    _taxId = taxId;
    _base = base;
    _amount = amount;
  }

  TaxlineData.fromJson(dynamic json) {
    _id = json['id'];
    _receiptId = json['receipt_id'];
    _taxId = json['tax_id'];
    _base = json['base'];
    _amount = json['amount'];
  }

  int? _id;
  int? _receiptId;
  int? _taxId;
  int? _base;
  int? _amount;

  TaxlineData copyWith({
    int? id,
    int? receiptId,
    int? taxId,
    int? base,
    int? amount,
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

  int? get base => _base;

  int? get amount => _amount;

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
