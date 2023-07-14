// 메인 페이지 위젯 작업 예정

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_classcar/models/car.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  //final FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: null);
  }

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }

  /*CollectionReference<Car> car() {
    return db.collection("car").withConverter(
          fromFirestore: (snapshot, options) => Car.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
  }*/
}
