/// uid : 0
/// userId : "userId"
/// password : "password"
/// email : "email"
/// name : "name"
/// birthday : "birthday"
/// address : "address"
/// phoneNumber : "phoneNumber"
/// isCheckedAgreement : false
/// isCheckedAgreementAD : false
/// bank : "bank"
/// account : "account"

class CarOwner {
  CarOwner({
      num? uid, 
      String? userId, 
      String? password, 
      String? email, 
      String? name, 
      String? birthday, 
      String? address, 
      String? phoneNumber, 
      bool? isCheckedAgreement, 
      bool? isCheckedAgreementAD, 
      String? bank, 
      String? account,}){
    _uid = uid;
    _userId = userId;
    _password = password;
    _email = email;
    _name = name;
    _birthday = birthday;
    _address = address;
    _phoneNumber = phoneNumber;
    _isCheckedAgreement = isCheckedAgreement;
    _isCheckedAgreementAD = isCheckedAgreementAD;
    _bank = bank;
    _account = account;
}

  CarOwner.fromJson(dynamic json) {
    _uid = json['uid'];
    _userId = json['userId'];
    _password = json['password'];
    _email = json['email'];
    _name = json['name'];
    _birthday = json['birthday'];
    _address = json['address'];
    _phoneNumber = json['phoneNumber'];
    _isCheckedAgreement = json['isCheckedAgreement'];
    _isCheckedAgreementAD = json['isCheckedAgreementAD'];
    _bank = json['bank'];
    _account = json['account'];
  }
  num? _uid;
  String? _userId;
  String? _password;
  String? _email;
  String? _name;
  String? _birthday;
  String? _address;
  String? _phoneNumber;
  bool? _isCheckedAgreement;
  bool? _isCheckedAgreementAD;
  String? _bank;
  String? _account;
CarOwner copyWith({  num? uid,
  String? userId,
  String? password,
  String? email,
  String? name,
  String? birthday,
  String? address,
  String? phoneNumber,
  bool? isCheckedAgreement,
  bool? isCheckedAgreementAD,
  String? bank,
  String? account,
}) => CarOwner(  uid: uid ?? _uid,
  userId: userId ?? _userId,
  password: password ?? _password,
  email: email ?? _email,
  name: name ?? _name,
  birthday: birthday ?? _birthday,
  address: address ?? _address,
  phoneNumber: phoneNumber ?? _phoneNumber,
  isCheckedAgreement: isCheckedAgreement ?? _isCheckedAgreement,
  isCheckedAgreementAD: isCheckedAgreementAD ?? _isCheckedAgreementAD,
  bank: bank ?? _bank,
  account: account ?? _account,
);
  num? get uid => _uid;
  String? get userId => _userId;
  String? get password => _password;
  String? get email => _email;
  String? get name => _name;
  String? get birthday => _birthday;
  String? get address => _address;
  String? get phoneNumber => _phoneNumber;
  bool? get isCheckedAgreement => _isCheckedAgreement;
  bool? get isCheckedAgreementAD => _isCheckedAgreementAD;
  String? get bank => _bank;
  String? get account => _account;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uid'] = _uid;
    map['userId'] = _userId;
    map['password'] = _password;
    map['email'] = _email;
    map['name'] = _name;
    map['birthday'] = _birthday;
    map['address'] = _address;
    map['phoneNumber'] = _phoneNumber;
    map['isCheckedAgreement'] = _isCheckedAgreement;
    map['isCheckedAgreementAD'] = _isCheckedAgreementAD;
    map['bank'] = _bank;
    map['account'] = _account;
    return map;
  }

}