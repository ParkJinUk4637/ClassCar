import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_classcar/layouts/login/login_page.dart';

class MyPage extends StatefulWidget{
  const MyPage({super.key});

  @override
  State<StatefulWidget> createState() => _MyPage();
}

class _MyPage extends State<MyPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body : Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [

          ],
        ),
      )
    );
  }

  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }

  _logout() async{
    await FirebaseAuth.instance.signOut();
    Get.offAll(() => const LoginPage());
  }
}