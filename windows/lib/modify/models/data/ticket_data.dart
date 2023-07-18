import 'package:g_manager_app/modify/models/models.dart';
import 'package:intl/intl.dart';

class TicketData {
  TicketData(
      {int? id,
      String? title,
      int? ticketType,
      int? ticketId,
      int? personId,
      int? customerId,
      int? status,
      DateTime? datenew,
      List<TicketLineData>? ticketlines,
      List<TaxlineData>? taxlines,
      List<PaymentData>? payments,
      ReceiptData? receipt}) {
    _id = id;
    _title = title;
    _ticketType = ticketType;
    _ticketId = ticketId;
    _personId = personId;
    _customerId = customerId;
    _status = status;
    _datenew = datenew;
    _ticketlines = ticketlines;
    _taxlines = taxlines;
    _payments = payments;
    _receipt = receipt;
  }

  TicketData.fromJson(dynamic json) {
    _id = json['ticket_data']['ticket']['id'];
    _title = json['ticket_data']['ticket']['title'];
    _ticketType = json['ticket_data']['ticket']['ticket_type'];
    _ticketId = json['ticket_data']['ticket']['ticket_id'];
    _personId = json['ticket_data']['ticket']['person_id'];
    _customerId = json['ticket_data']['ticket']['customer_id'];
    _status = json['ticket_data']['ticket']['status'];
    _datenew = DateTime.parse(json['date_new']);
    if (json['ticket_data']['ticketlines'] != null) {
      _ticketlines = [];
      json['ticket_data']['ticketlines'].forEach((v) {
        _ticketlines?.add(TicketLineData.fromJson(v));
      });
    }
    if (json['ticket_data']['taxlines'] != null) {
      _taxlines = [];
      json['ticket_data']['taxlines'].forEach((v) {
        _taxlines?.add(TaxlineData.fromJson(v));
      });
    }
    if (json['ticket_data']['payments'] != null) {
      _payments = [];
      json['ticket_data']['payments'].forEach((v) {
        _payments?.add(PaymentData.fromJson(v));
      });
    }
    _receipt = json['ticket_data']['receipt'] != null
        ? ReceiptData.fromJson(json['ticket_data']['receipt'])
        : null;
  }

  int? _id;
  String? _title;
  int? _ticketType;
  int? _ticketId;
  int? _personId;
  int? _customerId;
  int? _status;
  DateTime? _datenew;
  List<TicketLineData>? _ticketlines;
  List<TaxlineData>? _taxlines;
  List<PaymentData>? _payments;
  ReceiptData? _receipt;

  TicketData copyWith(
          {int? id,
          String? title,
          int? ticketType,
          int? ticketId,
          int? person,
          int? customer,
          int? status,
          DateTime? datenew,
          List<TicketLineData>? ticketlines,
          List<TaxlineData>? taxlines,
          List<PaymentData>? payments,
          ReceiptData? receipt}) =>
      TicketData(
          id: id ?? _id,
          title: title ?? _title,
          ticketType: ticketType ?? _ticketType,
          ticketId: ticketId ?? _ticketId,
          personId: personId ?? _personId,
          customerId: customerId ?? _customerId,
          status: status ?? _status,
          datenew: datenew ?? _datenew,
          ticketlines: ticketlines ?? _ticketlines,
          taxlines: taxlines ?? _taxlines,
          payments: payments ?? _payments,
          receipt: receipt ?? _receipt);

  int? get id => _id;

  String? get title => _title;

  int? get ticketType => _ticketType;

  int? get ticketId => _ticketId;

  int? get personId => _personId;

  int? get customerId => _customerId;

  int? get status => _status;

  DateTime? get datenew => _datenew;

  List<TicketLineData>? get ticketlines => _ticketlines;

  List<TaxlineData>? get taxlines => _taxlines;

  List<PaymentData>? get payments => _payments;

  ReceiptData? get receipt => _receipt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['ticket_type'] = _ticketType;
    map['ticket_id'] = _ticketId;
    map['person_id'] = _personId;
    map['customer_id'] = _customerId;
    map['status'] = _status;
    map['date'] = DateFormat.yMd().add_Hms().format(_datenew!);
    if (_taxlines != null) {
      map['taxlines'] = _taxlines?.map((v) => v.toJson()).toList();
    }
    if (_ticketlines != null) {
      map['ticketlines'] = _ticketlines?.map((v) => v.toJson()).toList();
    }
    if (_payments != null) {
      map['payments'] = _payments?.map((v) => v.toJson()).toList();
    }
    if (_receipt != null) {
      map['receipt'] = _receipt?.toJson();
    }
    return map;
  }
}
