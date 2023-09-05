// 메인 페이지 위젯 작업 예정
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_classcar/component/logo.dart';
import 'package:my_classcar/layouts/main_page/main_page/detail_car_page/detail_car_page.dart';
import 'package:uuid/uuid.dart';

import '../../../models/car_info_model.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  final db = FirebaseFirestore.instance;
  final CollectionReference<Map<String, dynamic>> _collectionReference =
      FirebaseFirestore.instance.collection("Car");
  final _suggestions = <CarInfoModel>[];
  late Timestamp? lastVisible;
  final int _limit = 10;
  bool _hasNextPage = true;
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;
  late ScrollController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _isFirstLoadRunning
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Expanded(
                          child: SizedBox(
                              height: 200.0,
                              child: ListView.builder(
                                  controller: _controller,
                                  itemCount: _suggestions.length,
                                  itemBuilder: (context, index) => ListTile(
                                          title: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          backgroundColor: Colors.white10,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailCarPage(
                                                      car: _suggestions[index]),
                                            ),
                                          );
                                        },
                                        child: Column(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              child: FittedBox(
                                                fit: BoxFit.fitHeight,
                                                child: Image.network(
                                                  "${_suggestions[index].carImgURL?[0]}",
                                                  width: 500,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                                "차량 모델 : ${_suggestions[index].carModel}"),
                                            Text(
                                                "메이커 : ${_suggestions[index].maker}"),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        ),
                                      ))))),
                      if (_isLoadMoreRunning == true)
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      if (_hasNextPage == false && _suggestions.isEmpty)
                        Container(
                            padding: const EdgeInsets.all(16.0),
                            child: const Center(
                              child: Text("검색된 차량이 없습니다."),
                            ))
                    ],
                  )));
  }

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 10; i++) {
      db
          .collection('Car')
          .withConverter(
              fromFirestore: CarInfoModel.fromFirestore,
              toFirestore: (snapshot, options) => CarInfoModel().toFirestore())
          .add(CarInfoModel());
    }
    _initLoad();
    _controller = ScrollController()..addListener(_nextLoad);
  }

  @override
  void dispose() {
    _controller.removeListener(_nextLoad);
    super.dispose();
  }

  void _initLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });
    try {
      QuerySnapshot<CarInfoModel> querySnapshot = await _collectionReference
          .orderBy("createdAt")
          .limit(_limit)
          .withConverter(
              fromFirestore: CarInfoModel.fromFirestore,
              toFirestore: (CarInfoModel car, _) => car.toFirestore())
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        for (var snapshot in querySnapshot.docs) {
          _suggestions.add(snapshot.data());
        }
        lastVisible =
            querySnapshot.docs[querySnapshot.size - 1].data().createdAt;
      } else {
        setState(() {
          _hasNextPage = false;
        });
      }
    } catch (e) {
      print(e.toString());
    }
    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  void _nextLoad() async {
    if (_hasNextPage &&
        !_isFirstLoadRunning &&
        !_isLoadMoreRunning &&
        _controller.position.extentAfter < 100) {
      setState(() {
        _isLoadMoreRunning = true;
      });

      try {
        QuerySnapshot<CarInfoModel> querySnapshot = await _collectionReference
            .orderBy("createdAt")
            .startAfter([lastVisible])
            .limit(_limit)
            .withConverter(
                fromFirestore: CarInfoModel.fromFirestore,
                toFirestore: (CarInfoModel car, _) => car.toFirestore())
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          for (var snapshot in querySnapshot.docs) {
            _suggestions.add(snapshot.data());
          }
          lastVisible =
              querySnapshot.docs[querySnapshot.size - 1].data().createdAt;
        } else {
          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (e) {
        print(e.toString());
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }
}
