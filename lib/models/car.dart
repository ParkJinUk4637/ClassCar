/// uid : 0
/// isExhibit : false
/// carNumber : "carNumber"
/// carModel : "carModel"
/// carType : "carType"
/// carDrivetrain : "carDrivetrain"
/// maker : "maker"
/// seats : 10
/// carGasMil : 10.0
/// carLocation : "carLocation"
/// FWD : false
/// years : "years"
/// score : 5.0
/// sharedCount : 30
/// sharingPrice : 30000
/// cancelPolicyDate : 30
/// cancelPolicyPercent : 60
/// oilType : "oilType"
/// description : "description"

class Car {
  Car({
      num? uid, 
      bool? isExhibit, 
      String? carNumber, 
      String? carModel, 
      String? carType, 
      String? carDrivetrain, 
      String? maker, 
      num? seats, 
      num? carGasMil, 
      String? carLocation, 
      bool? fwd, 
      String? years, 
      num? score, 
      num? sharedCount, 
      num? sharingPrice, 
      num? cancelPolicyDate, 
      num? cancelPolicyPercent, 
      String? oilType, 
      String? description,}){
    _uid = uid;
    _isExhibit = isExhibit;
    _carNumber = carNumber;
    _carModel = carModel;
    _carType = carType;
    _carDrivetrain = carDrivetrain;
    _maker = maker;
    _seats = seats;
    _carGasMil = carGasMil;
    _carLocation = carLocation;
    _fwd = fwd;
    _years = years;
    _score = score;
    _sharedCount = sharedCount;
    _sharingPrice = sharingPrice;
    _cancelPolicyDate = cancelPolicyDate;
    _cancelPolicyPercent = cancelPolicyPercent;
    _oilType = oilType;
    _description = description;
}

  Car.fromJson(dynamic json) {
    _uid = json['uid'];
    _isExhibit = json['isExhibit'];
    _carNumber = json['carNumber'];
    _carModel = json['carModel'];
    _carType = json['carType'];
    _carDrivetrain = json['carDrivetrain'];
    _maker = json['maker'];
    _seats = json['seats'];
    _carGasMil = json['carGasMil'];
    _carLocation = json['carLocation'];
    _fwd = json['FWD'];
    _years = json['years'];
    _score = json['score'];
    _sharedCount = json['sharedCount'];
    _sharingPrice = json['sharingPrice'];
    _cancelPolicyDate = json['cancelPolicyDate'];
    _cancelPolicyPercent = json['cancelPolicyPercent'];
    _oilType = json['oilType'];
    _description = json['description'];
  }
  num? _uid;
  bool? _isExhibit;
  String? _carNumber;
  String? _carModel;
  String? _carType;
  String? _carDrivetrain;
  String? _maker;
  num? _seats;
  num? _carGasMil;
  String? _carLocation;
  bool? _fwd;
  String? _years;
  num? _score;
  num? _sharedCount;
  num? _sharingPrice;
  num? _cancelPolicyDate;
  num? _cancelPolicyPercent;
  String? _oilType;
  String? _description;
Car copyWith({  num? uid,
  bool? isExhibit,
  String? carNumber,
  String? carModel,
  String? carType,
  String? carDrivetrain,
  String? maker,
  num? seats,
  num? carGasMil,
  String? carLocation,
  bool? fwd,
  String? years,
  num? score,
  num? sharedCount,
  num? sharingPrice,
  num? cancelPolicyDate,
  num? cancelPolicyPercent,
  String? oilType,
  String? description,
}) => Car(  uid: uid ?? _uid,
  isExhibit: isExhibit ?? _isExhibit,
  carNumber: carNumber ?? _carNumber,
  carModel: carModel ?? _carModel,
  carType: carType ?? _carType,
  carDrivetrain: carDrivetrain ?? _carDrivetrain,
  maker: maker ?? _maker,
  seats: seats ?? _seats,
  carGasMil: carGasMil ?? _carGasMil,
  carLocation: carLocation ?? _carLocation,
  fwd: fwd ?? _fwd,
  years: years ?? _years,
  score: score ?? _score,
  sharedCount: sharedCount ?? _sharedCount,
  sharingPrice: sharingPrice ?? _sharingPrice,
  cancelPolicyDate: cancelPolicyDate ?? _cancelPolicyDate,
  cancelPolicyPercent: cancelPolicyPercent ?? _cancelPolicyPercent,
  oilType: oilType ?? _oilType,
  description: description ?? _description,
);
  num? get uid => _uid;
  bool? get isExhibit => _isExhibit;
  String? get carNumber => _carNumber;
  String? get carModel => _carModel;
  String? get carType => _carType;
  String? get carDrivetrain => _carDrivetrain;
  String? get maker => _maker;
  num? get seats => _seats;
  num? get carGasMil => _carGasMil;
  String? get carLocation => _carLocation;
  bool? get fwd => _fwd;
  String? get years => _years;
  num? get score => _score;
  num? get sharedCount => _sharedCount;
  num? get sharingPrice => _sharingPrice;
  num? get cancelPolicyDate => _cancelPolicyDate;
  num? get cancelPolicyPercent => _cancelPolicyPercent;
  String? get oilType => _oilType;
  String? get description => _description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uid'] = _uid;
    map['isExhibit'] = _isExhibit;
    map['carNumber'] = _carNumber;
    map['carModel'] = _carModel;
    map['carType'] = _carType;
    map['carDrivetrain'] = _carDrivetrain;
    map['maker'] = _maker;
    map['seats'] = _seats;
    map['carGasMil'] = _carGasMil;
    map['carLocation'] = _carLocation;
    map['FWD'] = _fwd;
    map['years'] = _years;
    map['score'] = _score;
    map['sharedCount'] = _sharedCount;
    map['sharingPrice'] = _sharingPrice;
    map['cancelPolicyDate'] = _cancelPolicyDate;
    map['cancelPolicyPercent'] = _cancelPolicyPercent;
    map['oilType'] = _oilType;
    map['description'] = _description;
    return map;
  }

}