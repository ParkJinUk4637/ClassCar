import 'package:flutter/material.dart';
import 'package:my_classcar/layouts/main_page/app_bar.dart';

class DeleteUser extends StatefulWidget{
  const DeleteUser({super.key});

  @override
  State<DeleteUser> createState() => _DeleteUser();
}

class _DeleteUser extends State<DeleteUser>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: closeAppBar("회원 탈퇴", context),
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text("회원탈퇴페이지")
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  // 해당 클래스 사라질 때
  @override
  void dispose() {
    super.dispose();
  }

}