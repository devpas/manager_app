import '../data/ticket_data.dart';

class TicketsResponse {
  TicketsResponse({List<TicketData>? tickets}) {
    _tickets = tickets;
  }

  TicketsResponse.fromJson(dynamic json) {
    if (json["data"] != null) {
      _tickets = [];
      json["data"].forEach((v) {
        _tickets?.add(TicketData.fromJson(v));
      });
    }
  }

  List<TicketData>? _tickets;

  TicketsResponse copyWith({List<TicketData>? products}) =>
      TicketsResponse(tickets: ticket ?? _tickets);

  List<TicketData>? get ticket => _tickets;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_tickets != null) {
      map['data'] = _tickets?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
