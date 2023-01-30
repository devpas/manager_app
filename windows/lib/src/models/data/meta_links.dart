class MetaLinks {
  MetaLinks({dynamic url, String? label, bool? active}) {
    _url = url;
    _label = label;
    _active = active;
  }

  MetaLinks.fromJson(dynamic json) {
    _url = json['url'];
    _label = json['label'];
    _active = json['active'];
  }

  dynamic _url;
  String? _label;
  bool? _active;

  MetaLinks copyWith({dynamic url, String? label, bool? active}) => MetaLinks(
    url: url ?? _url,
    label: label ?? _label,
    active: active ?? _active,
  );

  dynamic get url => _url;

  String? get label => _label;

  bool? get active => _active;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = _url;
    map['label'] = _label;
    map['active'] = _active;
    return map;
  }
}
