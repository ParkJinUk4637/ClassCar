import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../models/rent.dart';

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
    print("@@@@${user?.email}@@@@@@@@");
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> _snapshot = await _firestore
        .collection("Rent")
    // .orderBy("createdAt")
        .limit(10)
        .where("ownerMail", isEqualTo: user?.email)
        .get();

    setState(() {
      lastSnapshot = _snapshot.docs.last;
      rentData = _snapshot.docs.map((e) => Rent.fromJson(e.data())).toList();
    });
  }

  Future<void> _infinityScroll() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> _snapshot = await _firestore
        .collection("Rent")
    // .orderBy("createdAt")
        .startAfterDocument(lastSnapshot!)
        .limit(10)
        .where("ownerMail", isEqualTo: user?.email)
        .get();

    setState(() {
      lastSnapshot = _snapshot.docs.last;
      rentData
          .addAll(_snapshot.docs.map((e) => Rent.fromJson(e.data())).toList());
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

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: ListView.separated(
        itemCount: rentData.length,
        itemBuilder: (context, index) {
          return DefaultTextStyle(
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.accents[index % 15]),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${rentData[index].carUuid}"),
                    Text("${rentData[index].location}"),
                    Text("${rentData[index].createdAt}"),
                    if (rentData.length - 1 == index) ...[
                      SizedBox(
                        height: 100,
                        child: Center(
                            child: IconButton(
                              onPressed: () async {
                                await _infinityScroll();
                              },
                              icon: const Icon(
                                Icons.add_circle_outline,
                                size: 30,
                              ),
                            ),
                        ),
                      ),
                    ],
                  ],
                ),
              ));
        },
        separatorBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Container(
              height: 1,
              width: MediaQueryData
                  .fromView(
                  WidgetsBinding.instance.platformDispatcher.views.single
              )
                  .size
                  .width,
              color: const Color.fromRGBO(91, 91, 91, 1),
            ),
          );
        },
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  // bool get wantKeepAlive => throw UnimplementedError();
  bool get wantKeepAlive => true;
}
