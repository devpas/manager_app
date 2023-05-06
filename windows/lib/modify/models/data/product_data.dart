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
    int? taxCat,
    String? attribuseteId,
    int? stockCost,
    int? stockVolume,
    int? isCom,
    int? isScale,
    String? attribute,
    String? image,
    int? active,
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
    _attribute = attribute;
    _image = image;
    _active = active;
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
    _taxCat = json['tax_cat'];
    _attribuseteId = json['_attribuseteId'];
    _stockCost = json['stock_cost'];
    _stockVolume = json['stock_volume'];
    _isCom = json['is_com'];
    _isScale = json['is_scale'];
    _attribute = json['attribute'];
    _image = json['image'];
    _active = json['active'];
    _children = json['children'] != null
        ? List<ProductPasData>.from(
            json['children'].map((x) => ProductPasData.fromJson(x)))
        : null;
  }

  int? _index;
  int? _id;
  String? _reference;
  String? _code;
  String? _name;
  double? _priceBuy;
  double? _priceSell;
  int? _categoryId;
  int? _taxCat;
  String? _attribuseteId;
  int? _stockCost;
  int? _stockVolume;
  int? _isCom;
  int? _isScale;
  String? _attribute;
  String? _image;
  int? _active;
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
    int? taxCat,
    String? attribuseteId,
    int? stockCost,
    int? stockVolume,
    int? isCom,
    int? isScale,
    String? attribute,
    String? image,
    int? active,
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
        attribute: attribute ?? _attribute,
        image: image ?? _image,
        active: active ?? _active,
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

  int? get taxCat => _taxCat;

  String? get attribuseteId => _attribuseteId;

  int? get stockCost => _stockCost;

  int? get stockVolume => _stockVolume;

  int? get isCom => _isCom;

  int? get isScale => _isScale;

  String? get attribute => _attribute;

  String? get image => _image;

  int? get active => _active;

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
    map['attribute_id'] = _attribuseteId;
    map['stock_cost'] = _stockCost;
    map['stock_volume'] = _stockVolume;
    map['is_com'] = _isCom;
    map['is_scale'] = _isScale;
    map['attribute'] = _attribute;
    map['image'] = _image;
    map['active'] = _active;
    if (_children != null) {
      map['children'] = _children?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
