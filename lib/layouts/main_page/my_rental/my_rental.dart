// 대여 현황 페이지 작업 예정\

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_classcar/models/rent.dart';

class MyRental extends StatefulWidget{
  const MyRental({super.key});


  @override
  State<StatefulWidget> createState() => _MyRental();
}

class _MyRental extends State<MyRental>{
  final db = FirebaseFirestore.instance;
  final CollectionReference<Map<String, dynamic>> _collectionReference =
  FirebaseFirestore.instance.collection("Rent");
  final _suggestions = <Rent>[];
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
                    child: ListView.builder(
                        controller: _controller,
                        itemCount: _suggestions.length,
                        itemBuilder: (context, index) => ListTile(
                            title: _suggestions[index].toListTile(),
                        ))
                ),
                if (_isLoadMoreRunning == true)
                  Container(
                    padding: const EdgeInsets.all(30),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                if (_hasNextPage == false && _suggestions.isEmpty)
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
      QuerySnapshot<Rent> querySnapshot = await _collectionReference
          .orderBy("createdAt")
          .limit(_limit)
          .withConverter(
          fromFirestore: Rent.fromFirestore,
          toFirestore: (Rent rent, _) => rent.toJson())
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
        QuerySnapshot<Rent> querySnapshot = await _collectionReference
            .orderBy("createdAt")
            .startAfter([lastVisible])
            .limit(_limit)
            .withConverter(
            fromFirestore: Rent.fromFirestore,
            toFirestore: (Rent rent, _) => rent.toJson())
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