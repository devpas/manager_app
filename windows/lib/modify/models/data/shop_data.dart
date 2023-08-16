import 'package:g_manager_app/modify/models/data/role_block_data.dart';

class ShopData {
  ShopData({
    String? name,
    String? email,
    String? id,
    List<ShopData>? children,
  }) {
    _name = name;
    _email = email;
    _id = id;
    _children = children;
  }

  ShopData.fromJson(dynamic json) {
    _name = json['name'];
    _id = json['id'];
    _email = json['email'];
    if (json['children'] != null) {
      _children = [];
      json['children'].forEach((v) {
        _children?.add(ShopData.fromJson(v));
      });
    }
  }

  String? _name;
  String? _email;
  String? _id;
  List<ShopData>? _children;

  ShopData copyWith({
    String? name,
    String? email,
    String? id,
    List<RoleBlockData>? listRoleBlock,
    List<ShopData>? children,
  }) =>
      ShopData(
        name: name ?? _name,
        email: email ?? _email,
        id: id ?? _id,
        children: children ?? _children,
      );

  String? get name => _name;

  String? get email => _email;

  String? get id => _id;

  List<ShopData>? get children => _children;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['email'] = _email;
    map['id'] = _id;
    if (_children != null) {
      map['children'] = _children?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
