import 'package:g_manager_app/modify/models/models.dart';

class BaseData {
  BaseData({
    String? baseName,
    String? ownerName,
    String? email,
    String? phone,
    String? baseStatus,
    String? baseType,
    String? address,
    String? keyAccess,
    String? shareStatus,
    List<dynamic>? properties,
    List<RoleBlockData>? listRoleBlock,
    List<BaseData>? children,
  }) {
    _baseName = baseName;
    _ownerName = ownerName;
    _email = email;
    _phone = phone;
    _baseStatus = baseStatus;
    _baseType = baseType;
    _address = address;
    _keyAccess = keyAccess;
    _shareStatus = shareStatus;
    _properties = properties;
    _listRoleBlock = listRoleBlock;
    _children = children;
  }

  BaseData.fromJson(dynamic json) {
    _baseName = json['base_name'];
    _ownerName = json['owner_name'];
    _email = json['email'];
    _phone = json['phone'];
    _baseStatus = json['base_status'];
    _baseType = json['base_type'];
    _address = json['address'];
    _keyAccess = json['key_access'];
    _shareStatus = json['share_status'];
    if (json['properties'] != null) {
      _properties = [];
      json['properties'].forEach((v) {
        _properties?.add(v);
      });
    }

    if (json['role-block'] != null) {
      _listRoleBlock = [];
      json['role-block'].forEach((v) {
        _listRoleBlock?.add(RoleBlockData.fromJson(v));
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
  String? _phone;
  String? _baseStatus;
  String? _baseType;
  String? _address;
  String? _keyAccess;
  String? _shareStatus;
  List<dynamic>? _properties;
  List<RoleBlockData>? _listRoleBlock;
  List<BaseData>? _children;

  BaseData copyWith({
    String? baseName,
    String? ownerName,
    String? email,
    String? phone,
    String? baseStatus,
    String? baseType,
    String? address,
    String? keyAccess,
    String? shareStatus,
    List<dynamic>? properties,
    List<RoleBlockData>? listRoleBlock,
    List<BaseData>? children,
  }) =>
      BaseData(
        baseName: baseName ?? _baseName,
        ownerName: ownerName ?? _ownerName,
        email: email ?? _email,
        phone: phone ?? _phone,
        baseStatus: baseStatus ?? _baseStatus,
        baseType: baseType ?? _baseType,
        address: address ?? _address,
        keyAccess: keyAccess ?? _keyAccess,
        shareStatus: shareStatus ?? _shareStatus,
        properties: properties ?? _properties,
        listRoleBlock: listRoleBlock ?? _listRoleBlock,
        children: children ?? _children,
      );

  String? get baseName => _baseName;

  String? get ownerName => _ownerName;

  String? get email => _email;

  String? get phone => _phone;

  String? get baseStatus => _baseStatus;

  String? get baseType => _baseType;

  String? get address => _address;

  String? get keyAccess => _keyAccess;

  String? get shareStatus => _shareStatus;

  List<dynamic>? get properties => _properties;

  List<RoleBlockData>? get listRoleBlock => _listRoleBlock;

  List<BaseData>? get children => _children;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['base_name'] = _baseName;
    map['owner_name'] = _ownerName;
    map['email'] = _email;
    map['phone'] = _phone;
    map['base_status'] = _baseStatus;
    map['base_type'] = _baseType;
    map['address'] = _address;
    map['key_access'] = _keyAccess;
    map['share_status'] = _shareStatus;
    map['properties'] = properties;
    map['role-block'] = _listRoleBlock;
    if (_children != null) {
      map['children'] = _children?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
