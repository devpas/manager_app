class TopCustomersResponse {
  TopCustomersResponse({List<TopCustomerData>? data}) {
    _data = data;
  }

  TopCustomersResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(TopCustomerData.fromJson(v));
      });
    }
  }

  List<TopCustomerData>? _data;

  TopCustomersResponse copyWith({List<TopCustomerData>? data}) =>
      TopCustomersResponse(data: data ?? _data);

  List<TopCustomerData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class TopCustomerData {
  TopCustomerData({
    int? id,
    String? uuid,
    String? firstname,
    String? lastname,
    String? email,
    String? phone,
    String? gender,
    String? emailVerifiedAt,
    String? registeredAt,
    bool? active,
    String? img,
    String? role,
    num? ordersSumPrice,
  }) {
    _id = id;
    _uuid = uuid;
    _firstname = firstname;
    _lastname = lastname;
    _email = email;
    _phone = phone;
    _gender = gender;
    _emailVerifiedAt = emailVerifiedAt;
    _registeredAt = registeredAt;
    _active = active;
    _img = img;
    _role = role;
    _ordersSumPrice = ordersSumPrice;
  }

  TopCustomerData.fromJson(dynamic json) {
    _id = json['id'];
    _uuid = json['uuid'];
    _firstname = json['firstname'];
    _lastname = json['lastname'];
    _email = json['email'];
    _phone = json['phone'];
    _gender = json['gender'];
    _emailVerifiedAt = json['email_verified_at'];
    _registeredAt = json['registered_at'];
    _active = json['active'];
    _img = json['img'];
    _role = json['role'];
    _ordersSumPrice = json['orders_sum_price'];
  }

  int? _id;
  String? _uuid;
  String? _firstname;
  String? _lastname;
  String? _email;
  String? _phone;
  String? _gender;
  String? _emailVerifiedAt;
  String? _registeredAt;
  bool? _active;
  String? _img;
  String? _role;
  num? _ordersSumPrice;

  TopCustomerData copyWith({
    int? id,
    String? uuid,
    String? firstname,
    String? lastname,
    String? email,
    String? phone,
    String? gender,
    String? emailVerifiedAt,
    String? registeredAt,
    bool? active,
    String? img,
    String? role,
    num? ordersSumPrice,
  }) =>
      TopCustomerData(
        id: id ?? _id,
        uuid: uuid ?? _uuid,
        firstname: firstname ?? _firstname,
        lastname: lastname ?? _lastname,
        email: email ?? _email,
        phone: phone ?? _phone,
        gender: gender ?? _gender,
        emailVerifiedAt: emailVerifiedAt ?? _emailVerifiedAt,
        registeredAt: registeredAt ?? _registeredAt,
        active: active ?? _active,
        img: img ?? _img,
        role: role ?? _role,
        ordersSumPrice: ordersSumPrice ?? _ordersSumPrice,
      );

  int? get id => _id;

  String? get uuid => _uuid;

  String? get firstname => _firstname;

  String? get lastname => _lastname;

  String? get email => _email;

  String? get phone => _phone;

  String? get gender => _gender;

  String? get emailVerifiedAt => _emailVerifiedAt;

  String? get registeredAt => _registeredAt;

  bool? get active => _active;

  String? get img => _img;

  String? get role => _role;

  num? get ordersSumPrice => _ordersSumPrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['uuid'] = _uuid;
    map['firstname'] = _firstname;
    map['lastname'] = _lastname;
    map['email'] = _email;
    map['phone'] = _phone;
    map['gender'] = _gender;
    map['email_verified_at'] = _emailVerifiedAt;
    map['registered_at'] = _registeredAt;
    map['active'] = _active;
    map['img'] = _img;
    map['role'] = _role;
    map['orders_sum_price'] = _ordersSumPrice;
    return map;
  }
}
