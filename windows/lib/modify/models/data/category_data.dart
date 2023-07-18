class CategoryPasData {
  CategoryPasData({
    int? index,
    int? id,
    String? name,
    int? parentId,
    String? img,
    int? active,
    List<CategoryPasData>? children,
  }) {
    _index = index;
    _id = id;
    _name = name;
    _parentId = parentId;
    _img = img;
    _active = active;
    _children = children;
  }

  CategoryPasData.fromJson(dynamic json) {
    _index = json['index'];
    _id = json['id'];
    _name = json['name'];
    _parentId = json['parent_id'];
    _img = json['image'];
    _active = json['active'];
    if (json['children'] != null) {
      _children = [];
      json['children'].forEach((v) {
        _children?.add(CategoryPasData.fromJson(v));
      });
    }
  }

  int? _index;
  int? _id;
  String? _name;
  int? _parentId;
  String? _img;
  int? _active;
  List<CategoryPasData>? _children;

  CategoryPasData copyWith({
    int? index,
    int? id,
    String? name,
    int? parentId,
    String? img,
    int? active,
    List<CategoryPasData>? children,
  }) =>
      CategoryPasData(
        index: index ?? _index,
        id: id ?? _id,
        name: name ?? _name,
        parentId: parentId ?? _parentId,
        img: img ?? _img,
        active: active ?? _active,
        children: children ?? _children,
      );

  int? get index => _index;

  int? get id => _id;

  String? get name => _name;

  int? get parentId => _parentId;

  String? get img => _img;

  int? get active => _active;

  List<CategoryPasData>? get children => _children;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['index'] = _index;
    map['id'] = _id;
    map['name'] = _name;
    map['parent_id'] = _parentId;
    map['image'] = _img;
    map['active'] = _active;
    if (_children != null) {
      map['children'] = _children?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
