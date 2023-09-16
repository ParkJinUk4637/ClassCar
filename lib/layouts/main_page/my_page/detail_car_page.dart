import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_classcar/layouts/main_page/app_bar.dart';
import 'package:my_classcar/layouts/main_page/main_page/detail_car_page/car_rent_page/car_rent_page.dart';
import 'package:my_classcar/layouts/main_page/main_page/detail_car_page/car_rent_page/payment_page.dart';
import 'package:uuid/uuid.dart';

import '../../../models/car_info_model.dart';
import '../../../models/rent.dart';
import '../main_layout.dart';

class DetailCarPage extends StatefulWidget {
  const DetailCarPage({Key? key, required this.car, required this.driverUid})
      : super(key: key);

  final CarInfoModel car;
  final String driverUid;

  @override
  State<StatefulWidget> createState() => _DetailCarPage();
}

class _DetailCarPage extends State<DetailCarPage> {
  final User? user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  late CarInfoModel car = widget.car;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: backAppBar(car.carModel, context),
      body: ListView(
        controller: null,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Image.network("${car.carImgURL?[0]}"),
                ),
              ),
              _info()
            ],
          ),
        ],
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _bottomNavigationBar() {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
              top: BorderSide(
        color: Color(0xffc9c9c9),
      ))),
      padding: const EdgeInsets.all(12.0),
      height: 80,
      //margin: const EdgeInsets.symmetric(vertical: 24,horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(textAlign: TextAlign.left, "${car.sharingPrice}원/일"),
              const Text(textAlign: TextAlign.left, "합계요금"),
            ],
          ),
          SizedBox(width: MediaQuery.of(context).size.width / 360 * 200),
          // TextButton(
          //   style: TextButton.styleFrom(
          //     padding: const EdgeInsets.all(12.0),
          //     foregroundColor: Colors.white,
          //     backgroundColor: const Color(0xff1200b3),
          //     textStyle: const TextStyle(fontSize: 16),
          //   ),
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => CarRentPage(car: car),
          //       ),
          //     );
          //   },
          //   child: const Text("대여하기"),
          // )
          TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(12.0),
              foregroundColor: Colors.white,
              backgroundColor: Theme.of(context).focusColor,
              textStyle: const TextStyle(fontSize: 16),
            ),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => SecondRoute()),
              // );


              // showDialog(
              //     context: context,
              //     builder: (BuildContext context){
              //       return AlertDialog(
              //         title: const Text("대여"),
              //         content: const Text("대여 하시겠습니까?"),
              //         actions: [
              //           TextButton(
              //             onPressed: (){
              //               Navigator.of(context).pop();
              //             }, child: const Text("취소"),
              //           ),
              //           TextButton(
              //             onPressed: () async {
              //               final Rent rent = Rent(
              //                 carUid: car.docID,
              //                 driverUid: widget.driverUid,
              //                 rentalCost: 100000, // 작업필요
              //                 rentalEndTime: Timestamp.now(), // 작업필요
              //                 rentalStartTime: Timestamp.now(), // 작업필요
              //                 requestDate: Timestamp.now(),
              //                 situation: "수락대기",
              //                 ownerUid: car.uuid
              //               );
              //               await db.collection('Rent').add(rent.toJson());
              //               if(!mounted) return;
              //               Navigator.of(context).pop();
              //               Navigator.of(context).push(
              //                 MaterialPageRoute(
              //                   builder: (context) => const MainLayout(index: 0,),
              //                 ),
              //               );
              //               },
              //             child: const Text("확인"),
              //           )
              //         ],
              //       );
              //     }
              // );
            },
            child: const Text("대여하기"),
          ),
        ],
      ),
    );
  }

  Widget _info() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${car.carModel}",
            textAlign: TextAlign.start,
          ),
          Text(
            "${car.score} (${car.sharedCount}회 대여)",
          ),
          const SizedBox(height: 16.0),
          const Text("대여 날짜"),
          const Text("날짜 설정"),
          const SizedBox(height: 16.0),
          const Text("대여&반납 위치"),
          Text("${car.carLocation}"),
          const SizedBox(height: 16.0),
          const Text("환불 정책"),
          const Text("환불 정책 내용"),
          const SizedBox(
            height: 16.0,
          ),
          const Text("차량 추가 정보"),
          Text("좌석 : ${car.seats}인석"),
          Text("기름 종류 : ${car.oilType}"),
          Text("연식 : ${car.years}"),
        ],
      ),
    );
  }
}
