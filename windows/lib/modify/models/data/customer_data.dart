//customer {id,searchkey,tax_id,name,tax_category,card,max_debt,address,address2,postal,city,region,country,firstnam,lastname,email,phone,phone2,fax,notes,visible,curdate,curdebt}
class CustomerData {
  CustomerData({
    int? id,
    String? searchkey,
    String? taxId,
    String? name,
    String? taxCategory,
    String? card,
    double? maxDebt,
    String? address,
    String? address2,
    String? postal,
    String? city,
    String? region,
    String? country,
    String? firstname,
    String? lastname,
    String? email,
    String? phone,
    String? phone2,
    String? fax,
    String? note,
    int? visible,
    DateTime? curdate,
    String? curdebt,
    String? fileOrdersId,
    List<CustomerData>? children,
  }) {
    _id = id;
    _searchkey = searchkey;
    _taxId = _taxId;
    _name = name;
    _taxCategory = taxCategory;
    _card = card;
    _maxDebt = maxDebt;
    _address = address;
    _address2 = address2;
    _postal = postal;
    _city = city;
    _region = region;
    _country = country;
    _firstname = firstname;
    _lastname = lastname;
    _email = email;
    _phone = phone;
    _phone2 = phone2;
    _fax = fax;
    _note = note;
    _visible = visible;
    _curdate = _curdate;
    _curdebt = _curdebt;
    _fileOrdersId = fileOrdersId;
    _children = children;
  }

  CustomerData.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _searchkey = json['search_key'];
    _taxId = json['tax_id'];
    _name = json['name'];
    _taxCategory = json['tax_category'];
    _card = json['card'];
    _maxDebt = json['max_debt'] + 0.0;
    _address = json['address'];
    _address2 = json['address2'];
    _postal = json['postal'];
    _city = json['city'];
    _region = json['region'];
    _country = json['country'];
    _firstname = json['firstname'];
    _lastname = json['lastname'];
    _email = json['email'];
    _phone = json['phone'];
    _phone2 = json['phone2'];
    _fax = json['fax'];
    _note = json['note'];
    _visible = json['visible'];
    _curdate = DateTime.now();
    _curdebt = json['curdebt'];
    _fileOrdersId = json['file_orders_id'];
    if (json['children'] != null) {
      _children = [];
      json['children'].forEach((v) {
        _children?.add(CustomerData.fromJson(v));
      });
    }
  }

  int? _id;
  String? _searchkey;
  String? _taxId;
  String? _name;
  String? _taxCategory;
  String? _card;
  double? _maxDebt;
  String? _address;
  String? _address2;
  String? _postal;
  String? _city;
  String? _region;
  String? _country;
  String? _firstname;
  String? _lastname;
  String? _email;
  String? _phone;
  String? _phone2;
  String? _fax;
  String? _note;
  int? _visible;
  DateTime? _curdate;
  String? _curdebt;
  String? _fileOrdersId;
  List<CustomerData>? _children;

  CustomerData copyWith({
    int? id,
    String? searchkey,
    String? taxId,
    String? name,
    String? taxCategory,
    String? card,
    double? maxDebt,
    String? address,
    String? address2,
    String? postal,
    String? city,
    String? region,
    String? country,
    String? firstname,
    String? lastname,
    String? email,
    String? phone,
    String? phone2,
    String? fax,
    String? note,
    int? visible,
    DateTime? curdate,
    String? curdebt,
    String? fileOrdersId,
    List<CustomerData>? children,
  }) =>
      CustomerData(
          id: id ?? _id,
          searchkey: searchkey ?? _searchkey,
          taxId: taxId ?? _taxId,
          name: name ?? _name,
          taxCategory: taxCategory ?? _taxCategory,
          card: card ?? _card,
          maxDebt: maxDebt ?? _maxDebt,
          address: address ?? _address,
          address2: address2 ?? _address2,
          postal: postal ?? _postal,
          city: city ?? _city,
          region: region ?? _region,
          country: country ?? _country,
          firstname: firstname ?? firstname,
          lastname: lastname ?? lastname,
          email: email ?? _email,
          phone: phone ?? _phone,
          phone2: phone2 ?? _phone2,
          fax: fax ?? _fax,
          note: note ?? _note,
          visible: visible ?? _visible,
          curdate: curdate ?? _curdate,
          curdebt: curdebt ?? _curdebt,
          children: children ?? _children);

  int? get id => _id;

  String? get searchkey => _searchkey;

  String? get taxId => _taxId;

  String? get name => _name;

  String? get taxCategory => _taxCategory;

  String? get card => _card;

  double? get maxDebt => _maxDebt;

  String? get address => _address;

  String? get address2 => _address2;

  String? get postal => _postal;

  String? get city => _city;

  String? get region => _region;

  String? get country => _country;

  String? get firstname => _firstname;

  String? get lastname => _lastname;

  String? get email => _email;

  String? get phone => _phone;

  String? get phone2 => _phone2;

  String? get fax => _fax;

  String? get note => _note;

  int? get visible => _visible;

  DateTime? get curdate => _curdate;

  String? get curdebt => _curdebt;

  String? get fileOrdersId => _fileOrdersId;

  List<CustomerData>? get children => _children;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['searchkey'] = _searchkey;
    map['taxId'] = _taxId;
    map['name'] = _name;
    map['taxCategory'] = _taxCategory;
    map['card'] = _card;
    map['maxDebt'] = _maxDebt;
    map['address'] = _address;
    map['address2'] = _address2;
    map['postal'] = _postal;
    map['city'] = _city;
    map['region'] = _region;
    map['country'] = _country;
    map['firstname'] = _firstname;
    map['lastname'] = _lastname;
    map['email'] = _email;
    map['phone'] = _phone;
    map['phone2'] = _phone2;
    map['fax'] = _fax;
    map['note'] = _note;
    map['visible'] = _visible;
    map['curdate'] = _curdate;
    map['curdebt'] = _curdebt;
    map['file_orders_id'] = _fileOrdersId;
    if (_children != null) {
      map['children'] = _children?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
