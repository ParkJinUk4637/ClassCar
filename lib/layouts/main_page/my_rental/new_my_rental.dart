import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_classcar/component/app_snackbar.dart';

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
  DocumentSnapshot? lastSnapshot;

  Future<void> _initData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
        .collection("Rent")
        // .orderBy("createdAt")
        .limit(10)
        .where("ownerMail", isEqualTo: user?.email)
        .get();

    setState(() {
      lastSnapshot = snapshot.docs.last;
      rentData = snapshot.docs.map((e) => Rent.fromJson(e.data())).toList();

      if (snapshot.docs.isEmpty) {
        const SnackBar(
          content: Text(
            "대여 현황이 없습니다.",
            style: TextStyle(color: Color(0xff1200B3)),
          ),
          // backgroundColor: Color(0xff1200B3),
        );
      }
    });
  }

  Future<void> _infinityScroll() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
        .collection("Rent")
        // .orderBy("createdAt")
        .startAfterDocument(lastSnapshot!)
        .limit(10)
        .where("ownerMail", isEqualTo: user?.email)
        .get();

    setState(() {
      if(snapshot.docs.isEmpty){
        if (!mounted) return;
        ScaffoldMessenger.of(context)
            .showSnackBar(classcarSnackBar("대여 현황이 더 이상 없습니다."));
      }
      lastSnapshot = snapshot.docs.last;
      rentData
          .addAll(snapshot.docs.map((e) => Rent.fromJson(e.data())).toList());
    });
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

  Widget _listTile(int index) {
    final rent = rentData[index];
    final start = rent.startedAt?.toDate();
    final end = rent.endedAt?.toDate();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // 첫 번째 Column
            Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${rent.requestStatus}"),
                    const SizedBox(
                      height: 10,
                    ),
                    // Image.network(
                    //   "${car?.carImgURL?[0]}",
                    //   width: 80,
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                    // Text(car!.carNumber),
                  ],
                )),
            // 두 번째 Column
            Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('이동 거리'),
                    const SizedBox(
                      height: 10,
                    ),
                    // Text(car.carModel ?? 'Car Model'),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('대여 기간 ${rent.startedAt?.toDate().year ?? '0000'}년 '
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
                    Text('${rent.location}')
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
        child: ListView.builder(
          key: const PageStorageKey('myListView'), // 이 페이지 스크롤 위치, 상태 유지
          // padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 0),
          itemCount: rentData.length,
          itemBuilder: (context, index) {
            if (rentData.length - 1 == index) {
              return SizedBox(
                // height: 100,
                child: Center(
                  child: TextButton(
                    onPressed: () async {
                      await _infinityScroll();
                    },
                    child: const Text(
                      "더 보기",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
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
                  margin: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 0),
                  child: _listTile(index),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DetailRentalPage(rent: rentData[index])));
                });
          },
          // separator 쓸라면 Listview.builder -> Listview.separated
          // separatorBuilder: null,
          //     (BuildContext context, int index) {
          //   return
          //     Container(
          //     height: 12.0,
          //     width: MediaQueryData.fromView(
          //             WidgetsBinding.instance.platformDispatcher.views.single)
          //         .size
          //         .width,
          //     // color: const Color.fromRGBO(241, 241, 241, 1),
          //     color: Colors.white,
          //   );
          // },
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  // bool get wantKeepAlive => throw UnimplementedError();
  bool get wantKeepAlive => true;
}
