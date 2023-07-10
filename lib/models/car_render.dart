/// uid : 0
/// email : "email"
/// password : "password"
/// name : "name"
/// address : "address"
/// phoneNumber : "phoneNumber"
/// isCheckedAgreement : false
/// isCheckedAgreementAD : false
/// bank : "bank"
/// account : "account"

class CarRender {
  CarRender({
    num? uid,
    String? email,
    String? password,
    String? name,
    String? address,
    String? phoneNumber,
    bool? isCheckedAgreement,
    bool? isCheckedAgreementAD,
    String? bank,
    String? account,}) {
    _uid = uid;
    _email = email;
    _password = password;
    _name = name;
    _address = address;
    _phoneNumber = phoneNumber;
    _isCheckedAgreement = isCheckedAgreement;
    _isCheckedAgreementAD = isCheckedAgreementAD;
    _bank = bank;
    _account = account;
  }

  CarRender.fromJson(dynamic json) {
    _uid = json['uid'];
    _email = json['email'];
    _password = json['password'];
    _name = json['name'];
    _address = json['address'];
    _phoneNumber = json['phoneNumber'];
    _isCheckedAgreement = json['isCheckedAgreement'];
    _isCheckedAgreementAD = json['isCheckedAgreementAD'];
    _bank = json['bank'];
    _account = json['account'];
  }

  num? _uid;
  String? _email;
  String? _password;
  String? _name;
  String? _address;
  String? _phoneNumber;
  bool? _isCheckedAgreement;
  bool? _isCheckedAgreementAD;
  String? _bank;
  String? _account;

  CarRender copyWith({ num? uid,
    String? email,
    String? password,
    String? name,
    String? address,
    String? phoneNumber,
    bool? isCheckedAgreement,
    bool? isCheckedAgreementAD,
    String? bank,
    String? account,
  }) =>
      CarRender(
        uid: uid ?? _uid,
        email: email ?? _email,
        password: password ?? _password,
        name: name ?? _name,
        address: address ?? _address,
        phoneNumber: phoneNumber ?? _phoneNumber,
        isCheckedAgreement: isCheckedAgreement ?? _isCheckedAgreement,
        isCheckedAgreementAD: isCheckedAgreementAD ?? _isCheckedAgreementAD,
        bank: bank ?? _bank,
        account: account ?? _account,
      );

  num? get uid => _uid;

  String? get email => _email;

  String? get password => _password;

  String? get name => _name;

  String? get address => _address;

  String? get phoneNumber => _phoneNumber;

  bool? get isCheckedAgreement => _isCheckedAgreement;

  bool? get isCheckedAgreementAD => _isCheckedAgreementAD;

  String? get bank => _bank;

  String? get account => _account;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uid'] = _uid;
    map['email'] = _email;
    map['password'] = _password;
    map['name'] = _name;
    map['address'] = _address;
    map['phoneNumber'] = _phoneNumber;
    map['isCheckedAgreement'] = _isCheckedAgreement;
    map['isCheckedAgreementAD'] = _isCheckedAgreementAD;
    map['bank'] = _bank;
    map['account'] = _account;
    return map;
  }

}