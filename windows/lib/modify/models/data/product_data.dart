import 'dart:convert';

import 'package:g_manager_app/modify/models/data/stocks.dart';

class ProductPasData {
  ProductPasData({
    int? index,
    int? id,
    String? reference,
    String? code,
    String? name,
    double? priceBuy,
    double? priceSell,
    int? categoryId,
    String? taxCat,
    String? attribuseteId,
    int? stockCost,
    int? stockVolume,
    int? isCom,
    int? isScale,
    String? attributes,
    String? image,
    int? active,
    int? attributesetInstanceId,
    List<StockData>? stocks,
    int? maxStockCurrent,
    List<dynamic>? listImport,
    double? priceBuyAuto,
    int? isAuto,
    List<ProductPasData>? children,
  }) {
    _index = index;
    _id = id;
    _reference = reference;
    _code = code;
    _name = name;
    _priceBuy = priceBuy;
    _priceSell = priceSell;
    _categoryId = categoryId;
    _taxCat = taxCat;
    _attribuseteId = attribuseteId;
    _stockCost = stockCost;
    _stockVolume = stockVolume;
    _isCom = isCom;
    _isScale = isScale;
    _attributes = attributes;
    _image = image;
    _active = active;
    _attributesetInstanceId = attributesetInstanceId;
    _stocks = stocks;
    _maxStockCurrent = maxStockCurrent;
    _listImport = listImport;
    _priceBuyAuto = priceBuyAuto;
    _isAuto = isAuto;
    _children = children;
  }

  ProductPasData.fromJson(dynamic json) {
    _index = json['index'];
    _id = json['id'];
    _reference = json['reference'];
    _code = json['code'];
    _name = json['name'];
    _priceBuy = json['price_buy'] + 0.0;
    _priceSell = json['price_sell'] + 0.0;
    _categoryId = json['category_id'];
    // _taxCat = json['tax_cat'];
    _taxCat = json['tax_cat'];
    _attribuseteId = json['_attribuseteId'];
    _stockCost = json['stock_cost'];
    _stockVolume = json['stock_volume'];
    _isCom = json['is_com'];
    _isScale = json['is_scale'];
    _attributes = json['attributes'];
    _image = json['image'];
    _active = json['active'];
    _attributesetInstanceId = json["attributeset_instance_id"];
    json['stocks'] = jsonDecode(json['stocks']);
    _stocks = json['stocks'] != null ? List<StockData>.from(json['stocks'].map((x) => StockData.fromJson(x))) : null;
    _maxStockCurrent = json["max_stock_current"];
    if (json['list_import'] != null) {
      _listImport = [];
      json['list_import'] = jsonDecode(json['list_import']);
      json['list_import'].forEach((v) {
        _listImport!.add(v);
      });
    }
    print(json["price_buy_auto"]);
    _priceBuyAuto = json["price_buy_auto"] + 0.0;
    _isAuto = json["is_auto"];
    _children = json['children'] != null ? List<ProductPasData>.from(json['children'].map((x) => ProductPasData.fromJson(x))) : null;
  }

  int? _index;
  int? _id;
  String? _reference;
  String? _code;
  String? _name;
  double? _priceBuy;
  double? _priceSell;
  int? _categoryId;
  String? _taxCat;
  String? _attribuseteId;
  int? _stockCost;
  int? _stockVolume;
  int? _isCom;
  int? _isScale;
  String? _attributes;
  String? _image;
  int? _active;
  int? _attributesetInstanceId;
  List<StockData>? _stocks;
  int? _maxStockCurrent;
  List<dynamic>? _listImport;
  double? _priceBuyAuto;
  int? _isAuto;
  List<ProductPasData>? _children;

  ProductPasData copyWith({
    int? index,
    int? id,
    String? reference,
    String? code,
    String? name,
    double? priceBuy,
    double? priceSell,
    int? categoryId,
    String? taxCat,
    String? attribuseteId,
    int? stockCost,
    int? stockVolume,
    int? isCom,
    int? isScale,
    String? attributes,
    String? image,
    int? active,
    int? attributesetInstanceId,
    List<StockData>? stocks,
    int? maxStockCurrent,
    List<dynamic>? listImport,
    double? priceBuyAuto,
    int? isAuto,
    List<ProductPasData>? children,
  }) =>
      ProductPasData(
        index: index ?? _index,
        id: id ?? _id,
        reference: reference ?? _reference,
        code: code ?? _code,
        name: name ?? _name,
        priceBuy: priceBuy ?? _priceBuy,
        priceSell: priceSell ?? _priceSell,
        categoryId: categoryId ?? _categoryId,
        taxCat: taxCat ?? _taxCat,
        attribuseteId: attribuseteId ?? _attribuseteId,
        stockCost: stockCost ?? _stockCost,
        stockVolume: stockVolume ?? _stockVolume,
        isCom: isCom ?? _isCom,
        isScale: isScale ?? _isScale,
        attributes: attributes ?? _attributes,
        image: image ?? _image,
        active: active ?? _active,
        attributesetInstanceId: attributesetInstanceId ?? _attributesetInstanceId,
        stocks: stocks ?? _stocks,
        maxStockCurrent: maxStockCurrent ?? _maxStockCurrent,
        listImport: listImport ?? _listImport,
        priceBuyAuto: priceBuyAuto ?? _priceBuyAuto,
        isAuto: isAuto ?? _isAuto,
        children: children ?? _children,
      );

  int? get index => _index;

  int? get id => _id;

  String? get reference => _reference;

  String? get code => _code;

  String? get name => _name;

  double? get priceBuy => _priceBuy;

  double? get priceSell => _priceSell;

  int? get categoryId => _categoryId;

  String? get taxCat => _taxCat;

  String? get attribuseteId => _attribuseteId;

  int? get stockCost => _stockCost;

  int? get stockVolume => _stockVolume;

  int? get isCom => _isCom;

  int? get isScale => _isScale;

  String? get attributes => _attributes;

  String? get image => _image;

  int? get active => _active;

  int? get attributesetInstanceId => _attributesetInstanceId;

  List<StockData>? get stocks => _stocks;

  int? get maxStockCurrent => _maxStockCurrent;

  List<dynamic>? get listImport => _listImport;

  double? get priceBuyAuto => _priceBuyAuto;

  int? get isAuto => _isAuto;

  List<ProductPasData>? get children => _children;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['index'] = _index;
    map['id'] = _id;
    map['reference'] = _reference;
    map['code'] = _code;
    map['name'] = _name;
    map['price_buy'] = _priceBuy;
    map['price_sell'] = _priceSell;
    map['category_id'] = _categoryId;
    map['tax_cat'] = _taxCat;
    map['attributeset_id'] = _attribuseteId;
    map['stock_cost'] = _stockCost;
    map['stock_volume'] = _stockVolume;
    map['is_com'] = _isCom;
    map['is_scale'] = _isScale;
    map['attributes'] = _attributes;
    map['image'] = _image;
    map['active'] = _active;
    map['attributeset_instance_id'] = _attributesetInstanceId;
    map['stocks'] = _stocks;
    if (_children != null) {
      map['children'] = _children?.map((v) => v.toJson()).toList();
    }
    map['max_stock_current'] = _maxStockCurrent;
    map["list_import"] = _listImport;
    map["price_buy_auto"] = _priceBuyAuto;
    map["is_auto"] = _isAuto;
    return map;
  }

  ProductPasData initProduct() {
    ProductPasData product = ProductPasData(
        id: 0,
        index: -1,
        reference: "",
        code: "",
        name: "",
        categoryId: -1,
        priceBuy: 0,
        priceSell: 0,
        taxCat: "",
        attribuseteId: "",
        attributesetInstanceId: -1,
        stockCost: 0,
        stockVolume: 0,
        isCom: 0,
        isScale: 0,
        attributes: "",
        image: "",
        active: -1,
        stocks: [],
        maxStockCurrent: 0,
        listImport: [],
        priceBuyAuto: 0,
        isAuto: 0);
    print(product);
    return product;
  }
}
