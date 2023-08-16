import '../data/customer_data.dart';

class CustomerResponse {
  CustomerResponse({List<CustomerData>? customers}) {
    _customers = customers;
  }

  CustomerResponse.fromJson(dynamic json) {
    if (json["data"] != null) {
      _customers = [];
      json["data"].forEach((v) {
        _customers?.add(CustomerData.fromJson(v));
      });
    }
  }

  List<CustomerData>? _customers;

  CustomerResponse copyWith({List<CustomerData>? customers}) =>
      CustomerResponse(customers: customers ?? _customers);

  List<CustomerData>? get customers => _customers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_customers != null) {
      map['data'] = _customers?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
