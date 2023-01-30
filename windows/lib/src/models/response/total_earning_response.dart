class TotalEarningResponse {
  TotalEarningResponse({
    String? timestamp,
    bool? status,
    String? message,
    List<TotalEarningData>? data,
  }) {
    _timestamp = timestamp;
    _status = status;
    _message = message;
    _data = data;
  }

  TotalEarningResponse.fromJson(dynamic json) {
    _timestamp = json['timestamp'];
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(TotalEarningData.fromJson(v));
      });
    }
  }

  String? _timestamp;
  bool? _status;
  String? _message;
  List<TotalEarningData>? _data;

  TotalEarningResponse copyWith({
    String? timestamp,
    bool? status,
    String? message,
    List<TotalEarningData>? data,
  }) =>
      TotalEarningResponse(
        timestamp: timestamp ?? _timestamp,
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );

  String? get timestamp => _timestamp;

  bool? get status => _status;

  String? get message => _message;

  List<TotalEarningData>? get data => _data;

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

class TotalEarningData {
  TotalEarningData({
    num? totalEarned,
    num? deliveryEarned,
    num? taxEarned,
    num? commissionEarned,
  }) {
    _totalEarned = totalEarned;
    _deliveryEarned = deliveryEarned;
    _taxEarned = taxEarned;
    _commissionEarned = commissionEarned;
  }

  TotalEarningData.fromJson(dynamic json) {
    _totalEarned = json['total_earned'];
    _deliveryEarned = json['delivery_earned'];
    _taxEarned = json['tax_earned'];
    _commissionEarned = json['commission_earned'];
  }

  num? _totalEarned;
  num? _deliveryEarned;
  num? _taxEarned;
  num? _commissionEarned;

  TotalEarningData copyWith({
    num? totalEarned,
    num? deliveryEarned,
    num? taxEarned,
    num? commissionEarned,
  }) =>
      TotalEarningData(
        totalEarned: totalEarned ?? _totalEarned,
        deliveryEarned: deliveryEarned ?? _deliveryEarned,
        taxEarned: taxEarned ?? _taxEarned,
        commissionEarned: commissionEarned ?? _commissionEarned,
      );

  num? get totalEarned => _totalEarned;

  num? get deliveryEarned => _deliveryEarned;

  num? get taxEarned => _taxEarned;

  num? get commissionEarned => _commissionEarned;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total_earned'] = _totalEarned;
    map['delivery_earned'] = _deliveryEarned;
    map['tax_earned'] = _taxEarned;
    map['commission_earned'] = _commissionEarned;
    return map;
  }
}
