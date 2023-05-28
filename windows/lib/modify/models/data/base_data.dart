class BaseData {
  BaseData({
    String? baseName,
    String? ownerName,
    String? email,
    String? keyAccess,
    dynamic publicInfomation,
    String? status,
    List<String>? areaAccess,
    List<dynamic>? listRole,
    List<BaseData>? children,
  }) {
    _baseName = baseName;
    _ownerName = ownerName;
    _email = email;
    _keyAccess = keyAccess;
    _areaAccess = areaAccess;
    _listRole = listRole;
    _publicInfomation = publicInfomation;
    _children = children;
  }

  BaseData.fromJson(dynamic json) {
    _baseName = json['base_name'];
    _ownerName = json['name'];
    _email = json['email'];
    _keyAccess = json['key_access'];
    _publicInfomation = json["public_infomation"];
    _status = json["status"];
    if (json['area_access'] != null) {
      _areaAccess = [];
      json['area_access'].forEach((v) {
        _areaAccess?.add(v);
      });
    }
    if (json['role'] != null) {
      _listRole = [];
      json['role'].forEach((v) {
        _listRole?.add(v);
      });
    }

    if (json['children'] != null) {
      _children = [];
      json['children'].forEach((v) {
        _children?.add(BaseData.fromJson(v));
      });
    }
  }

  String? _baseName;
  String? _ownerName;
  String? _email;
  String? _keyAccess;
  dynamic _publicInfomation;
  String? _status;
  List<String>? _areaAccess;
  List<dynamic>? _listRole;
  List<BaseData>? _children;

  BaseData copyWith({
    String? baseName,
    String? ownerName,
    String? email,
    String? keyAccess,
    dynamic publicInfomation,
    String? status,
    List<String>? areaAccess,
    List<String>? listRole,
    List<BaseData>? children,
  }) =>
      BaseData(
        baseName: baseName ?? _baseName,
        ownerName: ownerName ?? _ownerName,
        email: email ?? _email,
        keyAccess: keyAccess ?? _keyAccess,
        publicInfomation: publicInfomation ?? _publicInfomation,
        status: status ?? _status,
        areaAccess: areaAccess ?? areaAccess,
        listRole: listRole ?? _listRole,
        children: children ?? _children,
      );

  String? get baseName => _baseName;

  String? get ownerName => _ownerName;

  String? get email => _email;

  String? get keyAccess => _keyAccess;

  dynamic get publicInfomation => _publicInfomation;

  String? get status => _status;

  List<String>? get areaAccess => _areaAccess;

  List<dynamic>? get listRole => _listRole;

  List<BaseData>? get children => _children;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['baseName'] = _baseName;
    map['ownerName'] = _ownerName;
    map['email'] = _email;
    map['keyAccess'] = _keyAccess;
    map['public_infomation'] = _publicInfomation;
    map['status'] = _status;
    map['areaAccess'] = _areaAccess;
    map['role'] = _listRole;
    if (_children != null) {
      map['children'] = _children?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
