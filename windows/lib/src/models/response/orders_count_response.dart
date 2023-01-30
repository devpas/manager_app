class OrdersCountResponse {
  OrdersCountResponse({
    String? timestamp,
    bool? status,
    String? message,
    List<OrderCountData>? data,
  }) {
    _timestamp = timestamp;
    _status = status;
    _message = message;
    _data = data;
  }

  OrdersCountResponse.fromJson(dynamic json) {
    _timestamp = json['timestamp'];
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(OrderCountData.fromJson(v));
      });
    }
  }

  String? _timestamp;
  bool? _status;
  String? _message;
  List<OrderCountData>? _data;

  OrdersCountResponse copyWith({
    String? timestamp,
    bool? status,
    String? message,
    List<OrderCountData>? data,
  }) =>
      OrdersCountResponse(
        timestamp: timestamp ?? _timestamp,
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );

  String? get timestamp => _timestamp;

  bool? get status => _status;

  String? get message => _message;

  List<OrderCountData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['timestamp'] = _timestamp;
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class OrderCountData {
  OrderCountData({String? date, int? count}) {
    _date = date;
    _count = count;
  }

  OrderCountData.fromJson(dynamic json) {
    _date = json['date'];
    _count = json['count'];
  }

  String? _date;
  int? _count;

  OrderCountData copyWith({String? date, int? count}) =>
      OrderCountData(date: date ?? _date, count: count ?? _count);

  String? get date => _date;

  int? get count => _count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = _date;
    map['count'] = _count;
    return map;
  }
}
