//customer {id,searchkey,tax_id,name,tax_category,card,max_debt,address,address2,postal,city,region,country,firstnam,lastname,email,phone,phone2,fax,notes,visible,curdate,curdebt}
class CustomerData {
  CustomerData(
      {int? id,
      String? searchkey,
      int? taxId,
      String? name,
      int? taxCategory,
      int? card,
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
      DateTime? curdebt}) {
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
  }

  CustomerData.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _searchkey = json['searchkey'];
    _taxId = json['tax_id'];
    _name = json['name'];
    _taxCategory = json['tax_category'];
    _card = json['card'];
    _maxDebt = json['max_debt'];
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
    _curdate = DateTime.parse(json['curdate']);
    _curdebt = DateTime.parse(json['curdebt']);
  }

  int? _id;
  String? _searchkey;
  int? _taxId;
  String? _name;
  int? _taxCategory;
  int? _card;
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
  DateTime? _curdebt;

  CustomerData copyWith({
    int? id,
    String? searchkey,
    int? taxId,
    String? name,
    int? taxCategory,
    int? card,
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
    DateTime? curdebt,
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
          curdebt: curdebt ?? _curdebt);

  int? get id => _id;

  String? get searchkey => _searchkey;

  int? get taxId => _taxId;

  String? get name => _name;

  int? get taxCategory => _taxCategory;

  int? get card => _card;

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

  DateTime? get curdebt => _curdebt;

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
    return map;
  }
}
