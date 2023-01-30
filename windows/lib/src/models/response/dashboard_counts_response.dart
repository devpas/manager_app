class DashboardCountsResponse {
  DashboardCountsResponse({
    String? timestamp,
    bool? status,
    String? message,
    DashboardCountData? data,
  }) {
    _timestamp = timestamp;
    _status = status;
    _message = message;
    _data = data;
  }

  DashboardCountsResponse.fromJson(dynamic json) {
    _timestamp = json['timestamp'];
    _status = json['status'];
    _message = json['message'];
    _data =
        json['data'] != null ? DashboardCountData.fromJson(json['data']) : null;
  }

  String? _timestamp;
  bool? _status;
  String? _message;
  DashboardCountData? _data;

  DashboardCountsResponse copyWith({
    String? timestamp,
    bool? status,
    String? message,
    DashboardCountData? data,
  }) =>
      DashboardCountsResponse(
        timestamp: timestamp ?? _timestamp,
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );

  String? get timestamp => _timestamp;

  bool? get status => _status;

  String? get message => _message;

  DashboardCountData? get data => _data;

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

class DashboardCountData {
  DashboardCountData({
    int? productsOutOfCount,
    int? productsCount,
    int? progressOrdersCount,
    int? deliveredOrdersCount,
    int? cancelOrdersCount,
    int? ordersCount,
    int? reviewsCount,
  }) {
    _productsOutOfCount = productsOutOfCount;
    _productsCount = productsCount;
    _progressOrdersCount = progressOrdersCount;
    _deliveredOrdersCount = deliveredOrdersCount;
    _cancelOrdersCount = cancelOrdersCount;
    _ordersCount = ordersCount;
    _reviewsCount = reviewsCount;
  }

  DashboardCountData.fromJson(dynamic json) {
    _productsOutOfCount = json['products_out_of_count'];
    _productsCount = json['products_count'];
    _progressOrdersCount = json['progress_orders_count'];
    _deliveredOrdersCount = json['delivered_orders_count'];
    _cancelOrdersCount = json['cancel_orders_count'];
    _ordersCount = json['orders_count'];
    _reviewsCount = json['reviews_count'];
  }

  int? _productsOutOfCount;
  int? _productsCount;
  int? _progressOrdersCount;
  int? _deliveredOrdersCount;
  int? _cancelOrdersCount;
  int? _ordersCount;
  int? _reviewsCount;

  DashboardCountData copyWith({
    int? productsOutOfCount,
    int? productsCount,
    int? progressOrdersCount,
    int? deliveredOrdersCount,
    int? cancelOrdersCount,
    int? ordersCount,
    int? reviewsCount,
  }) =>
      DashboardCountData(
        productsOutOfCount: productsOutOfCount ?? _productsOutOfCount,
        productsCount: productsCount ?? _productsCount,
        progressOrdersCount: progressOrdersCount ?? _progressOrdersCount,
        deliveredOrdersCount: deliveredOrdersCount ?? _deliveredOrdersCount,
        cancelOrdersCount: cancelOrdersCount ?? _cancelOrdersCount,
        ordersCount: ordersCount ?? _ordersCount,
        reviewsCount: reviewsCount ?? _reviewsCount,
      );

  int? get productsOutOfCount => _productsOutOfCount;

  int? get productsCount => _productsCount;

  int? get progressOrdersCount => _progressOrdersCount;

  int? get deliveredOrdersCount => _deliveredOrdersCount;

  int? get cancelOrdersCount => _cancelOrdersCount;

  int? get ordersCount => _ordersCount;

  int? get reviewsCount => _reviewsCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['products_out_of_count'] = _productsOutOfCount;
    map['products_count'] = _productsCount;
    map['progress_orders_count'] = _progressOrdersCount;
    map['delivered_orders_count'] = _deliveredOrdersCount;
    map['cancel_orders_count'] = _cancelOrdersCount;
    map['orders_count'] = _ordersCount;
    map['reviews_count'] = _reviewsCount;
    return map;
  }
}
