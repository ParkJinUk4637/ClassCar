import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_classcar/layouts/main_page/app_bar.dart';
import 'package:uuid/uuid.dart';

import '../../../../../models/car_info_model.dart';
import '../../../../../models/rent.dart';

class CarRentPage extends StatefulWidget {
  const CarRentPage({Key? key, required this.car}) : super(key: key);

  final CarInfoModel car;

  @override
  State<StatefulWidget> createState() => _CarRentPage();
}

class _CarRentPage extends State<CarRentPage> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>(); // 맵 이동 컨트롤러
  final CameraPosition _initialPosition = const CameraPosition(
      target: LatLng(35.163339, 129.158061), zoom: 20); // 초기 위치
  late CarInfoModel car = widget.car;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: backAppBar("대여", context),
        body: ListView(
          controller: null,
          children: [
            SizedBox(
              height: 300,
              child: GoogleMap(
                initialCameraPosition: _initialPosition,
                onMapCreated: (GoogleMapController controller) {
                  _mapController.complete(controller);
                },
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(12.0),
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xff1200b3),
                textStyle: const TextStyle(fontSize: 16),
              ),
              onPressed: () async {
                final Rent rent = Rent(
                  createdAt: Timestamp.now(),
                  startedAt: Timestamp.now(),
                  endedAt: Timestamp.now(),
                  totalPrice: "가격",
                  requestStatus: "대여상태",
                  car: car.toFirestore(),
                  location: "장소",
                  uid: const Uuid().v4()
                );
                print('${rent.toJson()}');
                await db.collection('Rent').add(rent.toJson());
              },
              child: const Text("대여하기"),
            ),
          ],
        )
    );
  }
}
