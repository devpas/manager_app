class RoleBlockData {
  RoleBlockData({
    String? block,
    String? role,
    String? code,
  }) {
    _block = block;
    _role = role;
    _code = _code;
  }

  RoleBlockData.fromJson(dynamic json) {
    _block = json['block'];
    _role = json['role'];
    _code = json['code'];
  }

  String? _block;
  String? _role;
  String? _code;

  RoleBlockData copyWith({
    String? block,
    String? role,
    String? code,
  }) =>
      RoleBlockData(
        block: block ?? _block,
        role: role ?? _role,
        code: code ?? _code,
      );

  String? get block => _block;

  String? get role => _role;

  String? get code => _code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['block'] = _block;
    map['role'] = _role;
    map['code'] = _code;
    return map;
  }
}
