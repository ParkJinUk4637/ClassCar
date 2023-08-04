import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

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
/// createdAt :

class Car {
  Car(
      {String? uuid,
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
      Timestamp? createdAt}) {
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
    _createdAt = createdAt;
  }

  Car.fromJson(dynamic json) {
    _uuid = json['uuid'];
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
    _createdAt = json['createdAt'];
  }

  factory Car.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Car(
      uuid: data?['uuid'],
      isExhibit: data?['isExhibit'],
      carNumber: data?['carNumber'],
      carModel: data?['carModel'],
      carType: data?['carType'],
      carDrivetrain: data?['carDrivetrain'],
      maker: data?['maker'],
      seats: data?['seats'],
      carGasMil: data?['carGasMil'],
      carLocation: data?['carLocation'],
      fwd: data?['FWD'],
      years: data?['years'],
      score: data?['score'],
      sharedCount: data?['sharedCount'],
      sharingPrice: data?['sharingPrice'],
      cancelPolicyDate: data?['cancelPolicyDate'],
      cancelPolicyPercent: data?['cancelPolicyPercent'],
      oilType: data?['oilType'],
      description: data?['description'],
      createdAt: data?['createdAt'],
    );
  }

  String? _uuid;
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
  Timestamp? _createdAt;

  Car copyWith({
    String? uuid,
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
    String? description,
    DateTime? createdAt,
  }) =>
      Car(
        uuid: uuid ?? _uuid,
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
        createdAt: _createdAt ?? _createdAt,
      );

  String? get uuid => _uuid;

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

  Timestamp? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uuid'] = _uuid;
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
    map['createdAt'] = _createdAt;
    return map;
  }
}
