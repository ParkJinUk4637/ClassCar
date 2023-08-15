import 'package:cloud_firestore/cloud_firestore.dart';

class CarInfoModel {
  // uuid로 차량 이미지를 불러올 것임
  late String uuid;
  late bool isExhibit;
  late double carGasMil;
  late String carLocation;
  late String carModel;
  late String carNumber;
  late String carType;
  late String maker;
  late String oilType;
  late int seats;
  late String years;
  late Timestamp createdAt;
  late String cancelPolicyDate;
  late String cancelPolicyPercent;
  late int? score;
  late int? sharedCount;
  late int sharingPrice;
  late String description;
  late Map<String, dynamic> insideOption;
  late Map<String, dynamic> safeOption;
  late Map<String, dynamic> usabilityOption;

  CarInfoModel.fromJson(Map<String, dynamic> json)
      : uuid = json['uuid'],
        isExhibit = json['isExhibit'],
        carGasMil = json['carGasMil'],
        carLocation = json['carLocation'],
        carModel = json['carModel'],
        carNumber = json['carNumber'],
        carType = json['carType'],
        maker = json['maker'],
        oilType = json['oilType'],
        seats = json['seats'],
        years = json['years'],
        createdAt = json['createdAt'],
        cancelPolicyDate = json['cancelPolicyDate'],
        cancelPolicyPercent = json['cancelPolicyPercent'],
        score = json['score'],
        sharedCount = json['sharedCount'],
        sharingPrice = json['sharingPrice'],
        description = json['description'],
        safeOption = json['safeOption'],
        insideOption = json['insideOption'],
        usabilityOption = json['usabilityOption'];
}
