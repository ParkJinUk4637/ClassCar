import 'package:cloud_firestore/cloud_firestore.dart';

import 'car.dart';

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
    String? location,
    String? uid,
  }) {
    _createdAt = createdAt;
    _startedAt = startedAt;
    _endedAt = endedAt;
    _totalPrice = totalPrice;
    _requestStatus = requestStatus;
    _car = car;
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
  String? _location;
  String? _uid;

  Rent copyWith({
    Timestamp? createdAt,
    Timestamp? startedAt,
    Timestamp? endedAt,
    String? totalPrice,
    String? requestStatus,
    Map<String,dynamic>? car,
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
        location: location ?? _location,
        uid: uid ?? _uid,
      );

  Timestamp? get createdAt => _createdAt;

  Timestamp? get startedAt => _startedAt;

  Timestamp? get endedAt => _endedAt;

  String? get totalPrice => _totalPrice;

  String? get requestStatus => _requestStatus;

  Map<String,dynamic>? get car => _car;

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
    map['location'] = _location;
    map['uid'] = _uid;
    return map;
  }

}
