import 'package:flutter/material.dart';

class PasswordReset extends StatefulWidget{
  const PasswordReset({super.key});

  State<PasswordReset> createState() => _PasswordReset();
}

class _PasswordReset extends State<PasswordReset>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text("비밀번호재설정페이지")
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