import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_classcar/component/app_snackbar.dart';
import 'package:my_classcar/models/car_info_model.dart';

import '../../../models/rent.dart';
import 'datail_rental_page/detail_rental_page.dart';

class MyRental extends StatefulWidget {
  const MyRental({super.key});

  @override
  State<StatefulWidget> createState() => _MyRental();
}

class _MyRental extends State<MyRental> with AutomaticKeepAliveClientMixin {
  User? user = FirebaseAuth.instance.currentUser;
  List<Rent> rentData = [];
  List<CarInfoModel> carData = [];
  final db = FirebaseFirestore.instance;
  late String driverDocNum;
  DocumentSnapshot? lastSnapshot;
  final ScrollController _scrollController = ScrollController();
  bool isLoaded = false;

  Future<void> _initData() async {
    QuerySnapshot<Object> userSnapshot = await db
        .collection("userINFO")
        .where("email", isEqualTo: user?.email)
        .get();

    driverDocNum = userSnapshot.docs.first.id;

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
        .collection("Rent")
        // .orderBy("createdAt")
        .where("DriverUID", isEqualTo: driverDocNum)
        .orderBy("RequestDate", descending: true)
        .limit(10)
        .get();

    // rentData = snapshot.docs.map((e) => Rent.fromJson(e.data())).toList();

    if (snapshot.docs.isNotEmpty) {
      lastSnapshot = snapshot.docs.last;
      for (var rentDoc in snapshot.docs) {
        Rent rent = Rent.fromJson(rentDoc.data());
        rentData.add(rent);

        DocumentSnapshot carSnap =
            await firestore.collection('Car').doc(rent.carUid).get();
        CarInfoModel car = CarInfoModel.fromFirestore(
            carSnap as DocumentSnapshot<Map<String, dynamic>>,
            SnapshotOptions());
        carData.add(car);
      }
    }

    isLoaded = true;

    setState(() {});
  }

  Future<void> _infinityScroll() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
        .collection("Rent")
        // .orderBy("createdAt")
        .where("DriverUID", isEqualTo: driverDocNum)
        .orderBy("RequestDate", descending: true)
        .startAfterDocument(lastSnapshot!)
        .limit(10)
        .get();

    List<Rent> rentList = [];
    List<CarInfoModel> carList = [];

    if (snapshot.docs.isNotEmpty) {
      for (var rentDoc in snapshot.docs) {
        Rent rent = Rent.fromJson(rentDoc.data());
        rentList.add(rent);

        DocumentSnapshot carSnap =
            await firestore.collection('Car').doc(rent.carUid).get();
        CarInfoModel car = CarInfoModel.fromFirestore(
            carSnap as DocumentSnapshot<Map<String, dynamic>>,
            SnapshotOptions());
        carList.add(car);
      }
      lastSnapshot = snapshot.docs.last;
    }

    setState(() {
      if (rentList.isNotEmpty) {
        for (var car in carList) {
          carData.add(car);
        }
        for (var rent in rentList) {
          rentData.add(rent);
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(classcarSnackBar("대여 현황이 더 이상 없습니다.", context));
      }
    });
  }

  Future<CarInfoModel?> getCarInfo(String? carUid) async {
    DocumentSnapshot<CarInfoModel?> doc = await FirebaseFirestore.instance
        .collection('Car')
        .doc(carUid)
        .withConverter(
            fromFirestore: CarInfoModel.fromFirestore,
            toFirestore: (CarInfoModel car, _) => car.toFirestore())
        .get();
    return doc.data();
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

  Widget _listTile(Rent rent, CarInfoModel car) {
    final start = rent.rentalStartTime?.toDate();
    final end = rent.rentalEndTime?.toDate();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // 첫 번째 Column
            Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${rent.situation}"),
                    const SizedBox(
                      height: 10,
                    ),
                    Image.network(
                      "${car.carImgURL?[0]}",
                      width: 80,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("${car.carNumber} "),
                  ],
                )),
            const Expanded(
              flex: 1,
              child: VerticalDivider(
                width: 20,
                thickness: 1,
                indent: 20,
                endIndent: 0,
                color: Colors.grey,
              ),
            ),
            // 두 번째 Column
            Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(car.carModel),
                    const SizedBox(
                      height: 10,
                    ),
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
                    const SizedBox(
                      height: 10,
                    ),
                    Text(car.carLocation) // 차량 정보 불러와야 가능
                  ],
                ))
          ],
        ),
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
            : ((isLoaded) && (rentData.isEmpty))
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [Text("대여가 없습니다.")],
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    itemCount: rentData.length,
                    itemBuilder: (context, index) {
                      final car = carData[index];
                      final rent = rentData[index];
                      if (rentData.length - 1 == index) {
                        return Column(
                          children: [
                            ListTile(
                                title: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8.0),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: const Offset(0, 2))
                                      ]),
                                  padding: const EdgeInsets.all(16.0),
                                  margin: const EdgeInsets.fromLTRB(
                                      8.0, 16.0, 8.0, 0),
                                  child: _listTile(rent, car),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DetailRentalPage(
                                                rent: rentData[index],
                                                car: carData[index],
                                              )));
                                }),
                            SizedBox(
                              // height: 100,
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
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      return ListTile(
                          title: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
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
                            child: _listTile(rent, car),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailRentalPage(
                                          rent: rentData[index],
                                          car: carData[index],
                                        )));
                          });
                    },
                  ),
        // ListView.builder(
        //   key: const PageStorageKey('myListView'), // 이 페이지 스크롤 위치, 상태 유지
        //   // padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 0),
        //   itemCount: rentData.length,
        //   itemBuilder: (context, index) {
        //     if (rentData.length - 1 == index) {
        //       return SizedBox(
        //         // height: 100,
        //         child: Center(
        //           child: TextButton(
        //             onPressed: () async {
        //               await _infinityScroll();
        //             },
        //             child: const Text(
        //               "더 보기",
        //               style: TextStyle(fontSize: 14),
        //             ),
        //           ),
        //         ),
        //       );
        //     }
        //           return ListTile(
        //               title: Container(
        //                 decoration: BoxDecoration(
        //                     color: Colors.white,
        //                     borderRadius: BorderRadius.circular(8.0),
        //                     boxShadow: [
        //                       BoxShadow(
        //                           color: Colors.grey.withOpacity(0.5),
        //                           spreadRadius: 2,
        //                           blurRadius: 5,
        //                           offset: const Offset(0, 2))
        //                     ]),
        //                 padding: const EdgeInsets.all(16.0),
        //                 margin: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 0),
        //                 child: _listTile(index),
        //               ),
        //               onTap: () {
        //                 Navigator.push(
        //                     context,
        //                     MaterialPageRoute(
        //                         builder: (context) => DetailRentalPage(
        //                           rent: rentData[index],
        //                           car: carData[index],
        //                         )));
        //               });
        //   },
        //   // separator 쓸라면 Listview.builder -> Listview.separated
        //   // separatorBuilder: null,
        //   //     (BuildContext context, int index) {
        //   //   return
        //   //     Container(
        //   //     height: 12.0,
        //   //     width: MediaQueryData.fromView(
        //   //             WidgetsBinding.instance.platformDispatcher.views.single)
        //   //         .size
        //   //         .width,
        //   //     // color: const Color.fromRGBO(241, 241, 241, 1),
        //   //     color: Colors.white,
        //   //   );
        //   // },
        // ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  // bool get wantKeepAlive => throw UnimplementedError();
  bool get wantKeepAlive => true;
}
