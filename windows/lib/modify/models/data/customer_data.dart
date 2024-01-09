import 'package:intl/intl.dart';

class CustomerData {
  CustomerData(
      {String? id,
      String? searchkey,
      String? taxId,
      String? name,
      String? taxCusCategory,
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
      double? curDebt,
      String? fileOrdersId,
      List<CustomerData>? children,
      String? fileOrderId,
      DateTime? createDate,
      String? ngt}) {
    _id = id;
    _searchkey = searchkey;
    _taxId = _taxId;
    _name = name;
    _taxCusCategory = taxCusCategory;
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
    _curdate = curdate;
    _curDebt = curDebt;
    _fileOrdersId = fileOrdersId;
    _children = children;
    _fileOrdersId = fileOrderId;
    _createDate = createDate;
    _ngt = ngt;
  }

  CustomerData.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _searchkey = json['search_key'].toString();
    _taxId = json['tax_id'];
    _name = json['name'];
    _taxCusCategory = json['customer_category_id'];
    _card = json['card'];
    _maxDebt = double.parse(json['max_debt'].toString()) + 0.0;
    _address = json['address'];
    _address2 = json['address2'];
    _postal = json['postal'].toString();
    _city = json['city'];
    _region = json['region'];
    _country = json['country'];
    _firstname = json['firstname'];
    _lastname = json['lastname'];
    _email = json['email'];
    _phone = json['phone'].toString();
    _phone2 = json['phone2'];
    _fax = json['fax'];
    _note = json['notes'];
    _visible = json['visible'];
    _curdate = json["cur_date"] != "" ? DateTime.parse(json["cur_date"]) : DateTime.parse("0001-01-01 00:00:00");
    _curDebt = double.parse(json['cur_debt'].toString()) + 0.0;
    _fileOrdersId = json['file_orders_id'];
    _createDate = DateTime.parse(json['create_date']);
    _ngt = json['ngt'];
    if (json['children'] != null) {
      _children = [];
      json['children'].forEach((v) {
        _children?.add(CustomerData.fromJson(v));
      });
    }
  }

  String? _id;
  String? _searchkey;
  String? _taxId;
  String? _name;
  String? _taxCusCategory;
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
  double? _curDebt;
  String? _fileOrdersId;
  DateTime? _createDate;
  String? _ngt;
  List<CustomerData>? _children;

  CustomerData copyWith({
    String? id,
    String? searchkey,
    String? taxId,
    String? name,
    String? taxCusCategory,
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
    double? curDebt,
    String? fileOrdersId,
    DateTime? createDate,
    String? ngt,
    List<CustomerData>? children,
  }) =>
      CustomerData(
          id: id ?? _id,
          searchkey: searchkey ?? _searchkey,
          taxId: taxId ?? _taxId,
          name: name ?? _name,
          taxCusCategory: taxCusCategory ?? _taxCusCategory,
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
          curDebt: curDebt ?? _curDebt,
          children: children ?? _children,
          fileOrderId: fileOrdersId ?? _fileOrdersId,
          createDate: createDate ?? _createDate,
          ngt: ngt ?? _ngt);

  String? get id => _id;

  String? get searchkey => _searchkey;

  String? get taxId => _taxId;

  String? get name => _name;

  String? get taxCusCategory => _taxCusCategory;

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

  double? get curDebt => _curDebt;

  String? get fileOrdersId => _fileOrdersId;

  DateTime? get createDate => _createDate;

  String? get ngt => _ngt;

  List<CustomerData>? get children => _children;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['search_key'] = _searchkey;
    map['taxId'] = _taxId;
    map['name'] = _name;
    map['customer_category_id'] = _taxCusCategory;
    map['card'] = _card;
    map['max_debt'] = _maxDebt;
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
    map['notes'] = _note;
    map['visible'] = _visible;
    map['cur_date'] = "'${DateFormat("yyyy-MM-dd HH:mm:ss").format(_curdate!)}";
    map['cur_debt'] = _curDebt;
    map['file_orders_id'] = _fileOrdersId;
    if (_children != null) {
      map['children'] = _children?.map((v) => v.toJson()).toList();
    }
    map['create_date'] = "'${DateFormat("yyyy-MM-dd HH:mm:ss").format(_createDate!)}";
    map['ngt'] = _ngt;
    return map;
  }

  CustomerData initCustomer() {
    CustomerData customer = CustomerData(
      id: "",
      searchkey: "",
      taxId: "",
      name: "",
      taxCusCategory: "",
      card: "",
      maxDebt: 0.0,
      address: "",
      address2: "",
      postal: "",
      city: "",
      region: "",
      country: "",
      firstname: "",
      lastname: "",
      email: "",
      phone: "",
      phone2: "",
      fax: "",
      note: "",
      visible: 0,
      curdate: DateTime.now(),
      curDebt: 0.0,
      fileOrdersId: "",
      createDate: DateTime.now(),
      ngt: "",
      children: [],
    );
    return customer;
  }
}
