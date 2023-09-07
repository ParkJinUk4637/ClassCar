import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'car_info_model.dart';
//
//
// /// createdAt : "Timestamp"
// /// startedAt : "Timestamp"
// /// endedAt : "Timestamp"
// /// totalPrice : "num"
// /// requestStatus : "String"
// /// car : "Car"
// /// location : "String"
//
// class Rent {
//   Rent({
//     Timestamp? createdAt,
//     Timestamp? startedAt,
//     Timestamp? endedAt,
//     int? totalPrice,
//     String? requestStatus,
//     String? carUuid,
//     String? ownerMail,
//     String? location,
//     String? uid,
//   }) {
//     _createdAt = createdAt;
//     _startedAt = startedAt;
//     _endedAt = endedAt;
//     _totalPrice = totalPrice;
//     _requestStatus = requestStatus;
//     _carUuid = carUuid;
//     _ownerMail = ownerMail;
//     _location = location;
//     _uid = uid;
//   }
//
//   Rent.fromJson(dynamic json) {
//     _createdAt = json['createdAt'];
//     _startedAt = json['startedAt'];
//     _endedAt = json['endedAt'];
//     _totalPrice = json['totalPrice'];
//     _requestStatus = json['requestStatus'];
//     _carUuid = json['carUuid'];
//     _ownerMail = json['ownerMail'];
//     _location = json['location'];
//     _uid = json['uid'];
//   }
//
//   factory Rent.fromFirestore(
//     DocumentSnapshot<Map<String, dynamic>> snapshot,
//     SnapshotOptions? options,
//   ) {
//     final data = snapshot.data();
//     return Rent(
//       createdAt: data?['createdAt'],
//       startedAt: data?['startedAt'],
//       endedAt: data?['endedAt'],
//       totalPrice: data?['totalPrice'],
//       requestStatus: data?['requestStatus'],
//       carUuid: data?['carUuid'],
//       ownerMail: data?['ownerMail'],
//       location: data?['location'],
//       uid: data?['uid'],
//     );
//   }
//
//   Timestamp? _createdAt;
//   Timestamp? _startedAt;
//   Timestamp? _endedAt;
//   int? _totalPrice;
//   String? _requestStatus;
//   String? _carUuid;
//   String? _ownerMail;
//   String? _location;
//   String? _uid;
//
//   // Rent copyWith({
//   //   Timestamp? createdAt,
//   //   Timestamp? startedAt,
//   //   Timestamp? endedAt,
//   //   String? totalPrice,
//   //   String? requestStatus,
//   //   Map<String,dynamic>? car,
//   //   String? ownerMail,
//   //   String? location,
//   //   String? uid,
//   // }) =>
//   //     Rent(
//   //       createdAt: createdAt ?? _createdAt,
//   //       startedAt: startedAt ?? _startedAt,
//   //       endedAt: endedAt ?? _endedAt,
//   //       totalPrice: totalPrice ?? _totalPrice,
//   //       requestStatus: requestStatus ?? _requestStatus,
//   //       car: car ?? _car,
//   //       ownerMail: ownerMail ?? _ownerMail,
//   //       location: location ?? _location,
//   //       uid: uid ?? _uid,
//   //     );
//
//   Timestamp? get createdAt => _createdAt;
//
//   Timestamp? get startedAt => _startedAt;
//
//   Timestamp? get endedAt => _endedAt;
//
//   int? get totalPrice => _totalPrice;
//
//   String? get requestStatus => _requestStatus;
//
//   String? get carUuid => _carUuid;
//
//   String? get ownerMail => _ownerMail;
//
//   String? get location => _location;
//
//   String? get uid => _uid;
//
//   Map<String, dynamic> toFirestore() {
//     final map = <String, dynamic>{};
//     map['createdAt'] = _createdAt;
//     map['startedAt'] = _startedAt;
//     map['endedAt'] = _endedAt;
//     map['totalPrice'] = _totalPrice;
//     map['requestStatus'] = _requestStatus;
//     map['carUuid'] = _carUuid;
//     map['ownerMail'] = _ownerMail;
//     map['location'] = _location;
//     map['uid'] = _uid;
//     return map;
//   }
//
//   Future<QuerySnapshot<CarInfoModel>> loadCar(String? carUuid) async {
//     QuerySnapshot<CarInfoModel> querySnapshot = await FirebaseFirestore.instance
//         .collection("Car")
//     .where("uuid",isEqualTo: carUuid)
//         .withConverter(
//             fromFirestore: CarInfoModel.fromFirestore,
//             toFirestore: (CarInfoModel car, _) => car.toFirestore())
//         .get();
//     return querySnapshot;
//   }
//
//   Container toListTile(String? carUuid) {
//     final start = startedAt?.toDate();
//     final end = endedAt?.toDate();
//     return Container(
//       height: 170,
//         padding: const EdgeInsets.all(16.0),
//         decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(8.0),
//             boxShadow: [
//               BoxShadow(
//                   color: Colors.grey.withOpacity(0.5),
//                   spreadRadius: 2,
//                   blurRadius: 5,
//                   offset: const Offset(0, 2))
//             ]),
//         child: FutureBuilder(
//           future: loadCar(carUuid),
//           builder: (context, snapshot) {
//             final data = snapshot.data?.docs.first.data();
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const CircularProgressIndicator();
//             } else if (snapshot.hasError || snapshot.data == null) {
//               return SizedBox(height: 100,);
//             } else {
//               return Row(
//                 children: [
//                   // 첫 번째 Column
//                   Expanded(
//                       flex: 3,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text("$requestStatus"),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                             Image.network(
//                               "${data?.carImgURL?[0]}",
//                               width: 80,
//                             ),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           Text(data!.carNumber),
//                         ],
//                       )),
//                   // 두 번째 Column
//                   Expanded(
//                       flex: 7,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text('이동 거리'),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           Text(data.carModel ?? 'Car Model'),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           Text('대여 기간 ${start?.year ?? '0000'}년 '
//                               '${start?.month ?? '00'}월 '
//                               '${start?.day ?? '00'}일 '
//                               '${start?.hour ?? '00'}시 '
//                               '${start?.minute ?? '00'}분 '
//                               '~ ${end?.year ?? '0000'}년 '
//                               '${end?.month ?? '00'}월 '
//                               '${end?.day ?? '00'}일 '
//                               '${end?.hour ?? '00'}시 '
//                               '${end?.minute ?? '00'}분 '),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           Text('$location')
//                         ],
//                       ))
//                 ],
//               );
//             }
//           },
//         ));
//   }
// }

class Rent {
  final Timestamp? createdAt;
  final Timestamp? startedAt;
  final Timestamp? endedAt;
  final int? totalPrice;
  final String? requestStatus;
  final String? carUuid;
  final String? ownerMail;
  final String? location;
  final String? uid;

  Rent(
      {required this.createdAt,
      required this.startedAt,
      required this.endedAt,
      required this.totalPrice,
      required this.requestStatus,
      required this.carUuid,
      required this.ownerMail,
      required this.location,
      required this.uid});

  factory Rent.fromJson(Map<String, dynamic> json) {
    return Rent(
      createdAt: json["createdAt"],
      startedAt: json['startedAt'],
      endedAt: json['endedAt'],
      totalPrice: json['totalPrice'],
      requestStatus: json['requestStatus'],
      carUuid: json['carUuid'],
      ownerMail: json['ownerMail'],
      location: json['location'],
      uid: json['uid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "createdAt": createdAt,
      "startedAt": startedAt,
      "endedAt": endedAt,
      "totalPrice": totalPrice,
      "requestStatus": requestStatus,
      "carUuid": carUuid,
      "ownerMail": ownerMail,
      "location": location,
      "uid": uid,
    };
  }
}
