class StockData {
  StockData({
    String? warehouse,
    int? stockCurrent,
    List<StockData>? children,
  }) {
    _warehouse = warehouse;
    _stockCurrent = stockCurrent;
    _children = children;
  }

  StockData.fromJson(dynamic json) {
    _warehouse = json['warehouse'];
    _stockCurrent = json['stock_current'];
    _children = json['children'] != null
        ? List<StockData>.from(
            json['children'].map((x) => StockData.fromJson(x)))
        : null;
  }

  String? _warehouse;
  int? _stockCurrent;
  List<StockData>? _children;

  StockData copyWith({
    String? warehouse,
    int? stockCurrent,
    List<StockData>? children,
  }) =>
      StockData(
        warehouse: warehouse ?? _warehouse,
        stockCurrent: stockCurrent ?? _stockCurrent,
        children: children ?? _children,
      );

  String? get warehouse => _warehouse;

  int? get stockCurrent => _stockCurrent;

  List<StockData>? get children => _children;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['warehouse'] = _warehouse;
    map['stock_current'] = _stockCurrent;
    if (_children != null) {
      map['children'] = _children?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
