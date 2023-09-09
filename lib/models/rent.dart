import 'package:cloud_firestore/cloud_firestore.dart';

class Rent {

  final String? carUid;
  final String? driverUid;
  final String? ownerUid;
  final int? rentalCost;
  final Timestamp? rentalEndTime;
  final Timestamp? rentalStartTime;
  final Timestamp? requestDate;
  final String? situation;



  Rent(
      {required this.carUid,
      required this.driverUid,
      required this.ownerUid,
      required this.rentalCost,
      required this.rentalEndTime,
      required this.rentalStartTime,
      required this.requestDate,
      required this.situation,});

  factory Rent.fromJson(Map<String, dynamic> json) {
    return Rent(
      carUid: json["CarUID"],
      driverUid: json["DriverUID"],
      rentalCost: json["RentalCost"],
      rentalEndTime: json["RentalEndTime"],
      rentalStartTime: json["RentalStartTime"],
      requestDate: json["RequestDate"],
      situation: json["Situation"],
      ownerUid: json["OwnerUID"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "CarUID" : carUid,
      "DriverUID" : driverUid,
      "RentalCost" : rentalCost,
      "RentalEndTime" : rentalEndTime,
      "RentalStartTime" : rentalStartTime,
      "RequestDate" : requestDate,
      "Situation" : situation,
      "OwnerUID" : ownerUid
     };
  }
}
