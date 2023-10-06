import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

import '../../../component/app_snackbar.dart';
import '../../../models/car_info_model.dart';
import 'detail_car_page/detail_car_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainPage();
}

class _MainPage extends State<MainPage> with AutomaticKeepAliveClientMixin {
  final db = FirebaseFirestore.instance;
  List<CarInfoModel> carData = [];
  DocumentSnapshot? lastSnapshot;
  final ScrollController _scrollController = ScrollController();
  bool isLoaded = false;
  late String driverDocNum;

  Future<void> _initData() async {
    QuerySnapshot<CarInfoModel> snapshot = await db
        .collection("Car")
        .where('isExhibit',isEqualTo: true)
        .orderBy("createdAt")
        .limit(10)
        .withConverter(
            fromFirestore: CarInfoModel.fromFirestore,
            toFirestore: (CarInfoModel car, _) => car.toFirestore())
        .get();

    lastSnapshot = snapshot.docs.last;

    final User? user = FirebaseAuth.instance.currentUser;

    QuerySnapshot<Object> userSnapshot = await db
        .collection("userINFO")
        .where("email", isEqualTo: user?.email)
        .get();

    driverDocNum = userSnapshot.docs.first.id;

    for (var car in snapshot.docs) {
      carData.add(car.data());
    }

    isLoaded = true;

    setState(() {});
  }

  Future<void> _infinityScroll() async {
    QuerySnapshot<CarInfoModel> snapshot = await db
        .collection("Car")
        .where('isExhibit',isEqualTo: true)
        .orderBy("createdAt")
        .startAfterDocument(lastSnapshot!)
        .limit(10)
        .withConverter(
            fromFirestore: CarInfoModel.fromFirestore,
            toFirestore: (CarInfoModel car, _) => car.toFirestore())
        .get();

    List<CarInfoModel> carList = [];

    if (snapshot.docs.isNotEmpty) {
      for (var car in snapshot.docs) {
        carList.add(car.data());
      }

      lastSnapshot = snapshot.docs.last;
    }

    setState(() {
      if (carList.isNotEmpty) {
        for (var car in carList) {
          carData.add(car);
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(classcarSnackBar("차량이 더 이상 없습니다.", context));
      }
    });
  }

  Widget _listTile(CarInfoModel car) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Image.network(
            "${car.carImgURL?[0]}",
            width: 320,
          ),
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 6,
                  ),
                  Text(car.carModel),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: RatingBar(
                            itemSize: 20,
                            initialRating: car.score!.toDouble(),
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemCount: 5,
                            ratingWidget: RatingWidget(
                                full: const Icon(
                                  Icons.star,
                                  color: Colors.orange,
                                ),
                                half: const Icon(Icons.star_half),
                                empty: const Icon(Icons.star_border)),
                            onRatingUpdate: (rating) {}),
                      ),
                      Expanded(flex: 1, child: Text("(${car.sharedCount})"))
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(children: [
                Text("가격/일 : ${NumberFormat('###,###,###,###').format(car.sharingPrice).replaceAll(' ', '')}원"),
              ]),
            )
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
            child: !isLoaded
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ((isLoaded) && (carData.isEmpty))
                    ? const Text("없음")
                    : ListView.builder(
                        controller: _scrollController,
                        itemCount: carData.length,
                        itemBuilder: (context, index) {
                          final car = carData[index];
                          if (carData.length -1 == index) {
                            return Column(
                              children: [
                                ListTile(
                                  title: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 2,
                                              blurRadius: 5,
                                              offset: const Offset(0, 2))
                                        ]),
                                    padding: const EdgeInsets.all(16.0),
                                    margin: const EdgeInsets.fromLTRB(
                                        8.0, 16.0, 8.0, 0),
                                    child: _listTile(car),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailCarPage(
                                                  car: car,
                                                  driverUid: driverDocNum,
                                                )));
                                  },
                                ),
                                SizedBox(
                                  child: Center(
                                      child: TextButton(
                                    onPressed: () async {
                                      await _infinityScroll();
                                    },
                                    child: const Text(
                                      "더 보기",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xff1200b3),
                                      ),
                                    ),
                                  )),
                                ),
                              ],
                            );
                          }

                          return ListTile(
                            title: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(0, 2))
                                  ]),
                              padding: const EdgeInsets.all(16.0),
                              margin:
                                  const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 0),
                              child: _listTile(car),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailCarPage(
                                            car: car,
                                            driverUid: driverDocNum,
                                          )));
                            },
                          );
                        },
                      )));
  }

  @override
  void initState() {
    _initData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  // TODO: implement wantKeepAlive
  // bool get wantKeepAlive => throw UnimplementedError();
  bool get wantKeepAlive => true;
}
