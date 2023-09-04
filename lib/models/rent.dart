import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/// createdAt : "Timestamp"
/// startedAt : "Timestamp"
/// endedAt : "Timestamp"
/// totalPrice : "num"
/// requestStatus : "String"
/// car : "Car"
/// location : "String"

class Rent {
  Rent({
    Timestamp? createdAt,
    Timestamp? startedAt,
    Timestamp? endedAt,
    String? totalPrice,
    String? requestStatus,
    Map<String,dynamic>? car,
    String? ownerName,
    String? location,
    String? uid,
  }) {
    _createdAt = createdAt;
    _startedAt = startedAt;
    _endedAt = endedAt;
    _totalPrice = totalPrice;
    _requestStatus = requestStatus;
    _car = car;
    _ownerName = ownerName;
    _location = location;
    _uid = uid;
  }

  Rent.fromJson(dynamic json) {
    _createdAt = json['createdAt'];
    _startedAt = json['startedAt'];
    _endedAt = json['endedAt'];
    _totalPrice = json['totalPrice'];
    _requestStatus = json['requestStatus'];
    _car = json['car'];
    _ownerName = json['ownerName'];
    _location = json['location'];
    _uid = json['uid'];
  }

  factory Rent.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,){
    final data = snapshot.data();
    return Rent(
      createdAt: data?['createdAt'],
      startedAt: data?['startedAt'],
      endedAt: data?['endedAt'],
      totalPrice: data?['totalPrice'],
      requestStatus: data?['requestStatus'],
      car: data?['car'],
      ownerName: data?['ownerName'],
      location: data?['location'],
      uid: data?['uid'],
    );
  }

  Timestamp? _createdAt;
  Timestamp? _startedAt;
  Timestamp? _endedAt;
  String? _totalPrice;
  String? _requestStatus;
  Map<String,dynamic>? _car;
  String? _ownerName;
  String? _location;
  String? _uid;

  Rent copyWith({
    Timestamp? createdAt,
    Timestamp? startedAt,
    Timestamp? endedAt,
    String? totalPrice,
    String? requestStatus,
    Map<String,dynamic>? car,
    String? ownerName,
    String? location,
    String? uid,
  }) =>
      Rent(
        createdAt: createdAt ?? _createdAt,
        startedAt: startedAt ?? _startedAt,
        endedAt: endedAt ?? _endedAt,
        totalPrice: totalPrice ?? _totalPrice,
        requestStatus: requestStatus ?? _requestStatus,
        car: car ?? _car,
        ownerName: ownerName ?? _ownerName,
        location: location ?? _location,
        uid: uid ?? _uid,
      );

  Timestamp? get createdAt => _createdAt;

  Timestamp? get startedAt => _startedAt;

  Timestamp? get endedAt => _endedAt;

  String? get totalPrice => _totalPrice;

  String? get requestStatus => _requestStatus;

  Map<String,dynamic>? get car => _car;

  String? get ownerName => _ownerName;

  String? get location => _location;

  String? get uid => _uid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['createdAt'] = _createdAt;
    map['startedAt'] = _startedAt;
    map['endedAt'] = _endedAt;
    map['totalPrice'] = _totalPrice;
    map['requestStatus'] = _requestStatus;
    map['car'] = _car;
    map['ownerName'] = _ownerName;
    map['location'] = _location;
    map['uid'] = _uid;
    return map;
  }

  Container toListTile(){
    final start = startedAt?.toDate();
    final end = endedAt?.toDate();
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0,2)
          )
        ]
      ),
      child: Row(
        children: [
          // 첫 번째 Column
          Expanded(
              flex : 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("$requestStatus"),
                  const SizedBox(height: 10,),
                  Icon(Icons.car_rental),
                  const SizedBox(height: 10,),
                  Text("${car?['carNumber'] ?? 'Car Number'}"),
                ],
              )
          ),
          // 두 번째 Column
          Expanded(
              flex : 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('이동 거리'),
                  const SizedBox(height: 10,),
                  Text('${car?['carModel'] ?? 'Car Model'}'),
                  const SizedBox(height: 10,),
                  Text('대여 기간 ${start?.year ?? '0000'}년 '
                      '${start?.month ?? '00'}월 '
                      '${start?.day ?? '00'}일 '
                      '${start?.hour ?? '00'}시 '
                      '${start?.minute ?? '00'}분 '
                      '~ ${end?.year ?? '0000'}년 '
                      '${end?.month ?? '00'}월 '
                      '${end?.day ?? '00'}일 '
                      '${end?.hour ?? '00'}시 '
                      '${end?.minute ?? '00'}분 '),
                  const SizedBox(height: 10,),
                  Text('$location')
                ],
              )
          )
        ],
      ),
    );
  }

}
