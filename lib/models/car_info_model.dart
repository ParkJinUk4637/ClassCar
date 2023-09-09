import 'package:cloud_firestore/cloud_firestore.dart';

class CarInfoModel {
  late String docID; // 문서번호 (DB상에는 없고 앱 속에서만 보여짐)
  late String uuid; // 차주의 문서번호
  late bool isExhibit;
  late bool carState;
  late double carGasMil;
  late String carLocation;
  late String carModel;
  late String carNumber;
  late String carType;
  late String maker;
  late String oilType;
  late int seats;
  late String years;
  late Timestamp? createdAt;
  late String? cancelPolicyDate;
  late String? cancelPolicyPercent;
  late int? score;
  late int? sharedCount;
  late int? sharingPrice;
  late String description;
  late Map<String, dynamic> insideOption;
  late Map<String, dynamic> safeOption;
  late Map<String, dynamic> usabilityOption;
  late List<dynamic>? carImgURL;

  CarInfoModel();

  // fromFirestore
  factory CarInfoModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc,
      SnapshotOptions? options,
      ) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    CarInfoModel car = CarInfoModel();
    car.docID = doc.id;
    car.uuid = data['uuid'];
    car.isExhibit = data['isExhibit'];
    car.carState = data['carState'];
    car.carGasMil = data['carGasMil'].toDouble();
    car.carLocation = data['carLocation'];
    car.carModel = data['carModel'];
    car.carNumber = data['carNumber'];
    car.carType = data['carType'];
    car.maker = data['maker'];
    car.oilType = data['oilType'];
    car.seats = data['seats'];
    car.years = data['years'];
    car.createdAt = data['createdAt'];
    car.cancelPolicyDate = data['cancelPolicyDate'];
    car.cancelPolicyPercent = data['cancelPolicyPercent'];
    car.score = data['score'];
    car.sharedCount = data['sharedCount'];
    car.sharingPrice = data['sharingPrice'];
    car.description = data['description'];
    car.insideOption = data['insideOption'];
    car.safeOption = data['safeOption'];
    car.usabilityOption = data['usabilityOption'];
    car.carImgURL = data['carImgURL'];
    return car;
  }

  // toFirestore
  Map<String, dynamic> toFirestore() => {
    'uuid': uuid,
    'isExhibit': isExhibit,
    'carState': carState,
    'carGasMil': carGasMil,
    'carLocation': carLocation,
    'carModel': carModel,
    'carNumber': carNumber,
    'carType': carType,
    'maker': maker,
    'oilType': oilType,
    'seats': seats,
    'years': years,
    'createdAt': createdAt,
    'cancelPolicyDate': cancelPolicyDate,
    'cancelPolicyPercent': cancelPolicyPercent,
    'score': score,
    'sharedCount': sharedCount,
    'sharingPrice': sharingPrice,
    'description': description,
    'insideOption': insideOption,
    'safeOption': safeOption,
    'usabilityOption': usabilityOption,
    'carImgURL': carImgURL,
  };
}
