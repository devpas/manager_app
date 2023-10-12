class StockData {
  StockData({
    int? id,
    int? stockCurrent,
    int? stockMin,
    int? stockMax,
    List<StockData>? children,
  }) {
    _id = id;
    _stockMin = stockMin;
    _stockMax = stockMax;
    _stockCurrent = stockCurrent;
    _children = children;
  }

  StockData.fromJson(dynamic json) {
    _id = json['warehouse_id'];
    _stockMin = json["stock_min"];
    _stockMax = json["stock_max"];
    _stockCurrent = json['stock_current'];
    _children = json['children'] != null ? List<StockData>.from(json['children'].map((x) => StockData.fromJson(x))) : null;
  }

  int? _id;
  int? _stockCurrent;
  int? _stockMin;
  int? _stockMax;
  List<StockData>? _children;

  StockData copyWith({
    int? id,
    int? stockMin,
    int? stockMax,
    int? stockCurrent,
    List<StockData>? children,
  }) =>
      StockData(
        id: id ?? _id,
        stockMin: stockMin ?? stockMin,
        stockMax: stockMax ?? stockMax,
        stockCurrent: stockCurrent ?? _stockCurrent,
        children: children ?? _children,
      );

  int? get id => _id;

  int? get stockMin => _stockMin;

  int? get stockMax => _stockMax;

  int? get stockCurrent => _stockCurrent;

  List<StockData>? get children => _children;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['warehouse_id'] = _id;
    map['stock_min'] = _stockMin;
    map['stock_max'] = _stockMax;
    map['stock_current'] = _stockCurrent;
    if (_children != null) {
      map['children'] = _children?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
