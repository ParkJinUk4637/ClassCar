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
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final int indexCount = 10;
  int startIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextButton(
              onPressed: () {
                db.collection("Car").limit(startIndex).get().then(
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
            ),
          ],
        ),
      )
    );
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
