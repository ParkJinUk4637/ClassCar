// 메인 페이지 위젯 작업 예정

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

import '../../../models/car.dart';

/*TextButton(
              onPressed: () {
                db.collection("Car").limit(indexCount).get().then(
                    (querySnapshot) {
                      print("Successfully completed");
                      for (var docSnapshot in querySnapshot.docs) {
                        print('${docSnapshot.id} => ${docSnapshot.data()}');
                      }
                      (e) => print("Error completing: $e");
                    }
                );
              },
              child: const Text("테스트 호출"),
            ),*/

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  final CollectionReference<Map<String, dynamic>> _collectionReference =
      FirebaseFirestore.instance.collection("Car");
  final _suggestions = <Car>[];
  late var lastVisible;
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
                          child: ListView.builder(
                              controller: _controller,
                              itemCount: _suggestions.length,
                              itemBuilder: (context, index) => Card(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 10),
                                  child: ListTile(
                                    title: Text(
                                        "${_suggestions[index].description}"),
                                    subtitle: Text(
                                        "${_suggestions[index].createdAt}"),
                                  )))),
                      if (_isLoadMoreRunning == true)
                        Container(
                          padding: const EdgeInsets.all(30),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      if (_hasNextPage == false)
                        Container(
                            padding: const EdgeInsets.all(20),
                            child: const Center(
                              child: Text("검색된 차량이 없습니다."),
                            ))
                    ],
                  )));
  }

  @override
  void initState() {
    super.initState();
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
      QuerySnapshot<Car> querySnapshot = await _collectionReference
          .orderBy("createdAt")
          .limit(_limit)
          .withConverter(
              fromFirestore: Car.fromFirestore,
              toFirestore: (Car car, _) => car.toJson())
          .get();

      for (var snapshot in querySnapshot.docs) {
        _suggestions.add(snapshot.data());
      }
      lastVisible = querySnapshot.docs[querySnapshot.size-1].data().createdAt;
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
        QuerySnapshot<Car> querySnapshot = await _collectionReference
            .orderBy("createdAt")
            .startAfter([lastVisible])
            .limit(_limit)
            .withConverter(
                fromFirestore: Car.fromFirestore,
                toFirestore: (Car car, _) => car.toJson())
            .get();

        for (var snapshot in querySnapshot.docs) {
          _suggestions.add(snapshot.data());
        }
        lastVisible = querySnapshot.docs[querySnapshot.size-1].data().createdAt;
      } catch (e) {
        print(e.toString());
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }
}
