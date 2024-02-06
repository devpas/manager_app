//ticketlines[
//id, ticket, line, product_id,attributeset_instance_id,unit,price,tax_id,attributes
class TicketLineData {
  TicketLineData({
    int? id,
    int? ticketId,
    int? line,
    int? productId,
    String? attributesetInstanceId,
    double? unit,
    double? price,
    String? taxId,
    double? taxRate,
    String? attributes,
  }) {
    _id = id;
    _ticketId = ticketId;
    _line = line;
    _productId = productId;
    _attributesetInstanceId = attributesetInstanceId;
    _unit = unit;
    _price = price;
    _taxId = taxId;
    _taxRate = taxRate;
    _attributes = attributes;
  }

  TicketLineData.fromJson(dynamic json) {
    _id = json['id'];
    _ticketId = json['ticket'];
    _line = json['line'];
    _productId = json['product_id'];
    _attributesetInstanceId = json['attributeset_instance_id'] ?? "";
    _unit = double.parse(json['unit'].toString());
    _price = double.parse(json['price'].toString());
    _taxId = json['tax_id'];
    _attributes = json['attributes'].toString();
  }

  int? _id;
  int? _ticketId;
  int? _line;
  int? _productId;
  String? _attributesetInstanceId;
  double? _unit;
  double? _price;
  String? _taxId;
  double? _taxRate;
  String? _attributes;

  TicketLineData copyWith({
    int? id,
    int? ticketId,
    int? line,
    int? productId,
    String? attributesetInstanceId,
    double? unit,
    double? price,
    String? taxId,
    double? taxRate,
    String? attributes,
  }) =>
      TicketLineData(
          id: id ?? _id,
          ticketId: ticket ?? _ticketId,
          line: line ?? _line,
          productId: productId ?? _productId,
          attributesetInstanceId: attributesetInstanceId ?? _attributesetInstanceId,
          unit: unit ?? _unit,
          price: price ?? _price,
          taxId: taxId ?? _taxId,
          taxRate: taxRate ?? _taxRate,
          attributes: attributes ?? _attributes);

  int? get id => _id;

  int? get ticket => _ticketId;

  int? get line => _line;

  int? get productId => _productId;

  String? get attributesetInstanceId => _attributesetInstanceId;

  double? get unit => _unit;

  double? get price => _price;

  String? get taxId => _taxId;

  double? get taxRate => _taxRate;

  String? get attributes => _attributes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['ticket'] = _ticketId;
    map['line'] = _line;
    map['product_id'] = _productId;
    map['attributeset_instance_id'] = _attributesetInstanceId;
    map['unit'] = _unit;
    map['price'] = _price;
    map['tax_id'] = _taxId;
    map['tax_rate'] = _taxRate;
    map['attributes'] = _attributes;
    return map;
  }
}
