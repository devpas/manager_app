//payment{
//id, receipt, payment, total, trans_id, return_msg, notes
//},

class PaymentData {
  PaymentData(
      {int? id,
      int? receiptId,
      String? payment,
      double? total,
      String? transId,
      String? returnMSG,
      String? notes}) {
    _id = id;
    _receiptId = receiptId;
    _payment = payment;
    _total = total;
    _transId = transId;
    _returnMSG = returnMSG;
    _notes = notes;
  }

  PaymentData.fromJson(dynamic json) {
    _id = json['id'];
    _receiptId = json['receipt_id'];
    _payment = json['payment'];
    _total = json['total'];
    _transId = json['trans_id'];
    _returnMSG = json['return_msg'];
    _notes = json['notes'];
  }

  int? _id;
  int? _receiptId;
  String? _payment;
  double? _total;
  String? _transId;
  String? _returnMSG;
  String? _notes;

  PaymentData copyWith(
          {int? id,
          int? receiptId,
          String? payment,
          double? total,
          String? transId,
          String? returnMSG,
          String? notes}) =>
      PaymentData(
        id: id ?? _id,
        receiptId: receiptId ?? _receiptId,
        payment: payment ?? _payment,
        total: total ?? _total,
        transId: transId ?? _transId,
        returnMSG: returnMSG ?? _returnMSG,
        notes: notes ?? _notes,
      );

  int? get id => _id;

  int? get receiptId => _receiptId;

  String? get payment => _payment;

  double? get total => _total;

  String? get transId => _transId;

  String? get returnMSG => _returnMSG;

  String? get notes => _notes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['receipt_id'] = _receiptId;
    map['payment'] = _payment;
    map['total'] = _total;
    map['trans_id'] = _transId;
    map['return_msg'] = _returnMSG;
    map['notes'] = _notes;
    return map;
  }
}
