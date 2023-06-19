import '../data/employee_data.dart';

class EmployeeResponse {
  EmployeeResponse({List<EmployeeData>? employee}) {
    _employee = employee;
  }

  EmployeeResponse.fromJson(dynamic json) {
    if (json["data"] != null) {
      _employee = [];
      json["data"].forEach((v) {
        _employee?.add(EmployeeData.fromJson(v));
      });
    }
  }

  List<EmployeeData>? _employee;

  EmployeeResponse copyWith({List<EmployeeData>? employee}) =>
      EmployeeResponse(employee: employee ?? _employee);

  List<EmployeeData>? get employee => _employee;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_employee != null) {
      map['data'] = _employee?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
