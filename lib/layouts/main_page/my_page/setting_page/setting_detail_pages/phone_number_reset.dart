import 'package:flutter/material.dart';
import 'package:my_classcar/layouts/main_page/app_bar.dart';

class PhoneNumberReset extends StatefulWidget{
  const PhoneNumberReset({super.key});

  State<PhoneNumberReset> createState() => _PhoneNumberReset();
}

class _PhoneNumberReset extends State<PhoneNumberReset>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: closeAppBar("휴대전화 번호 재설정", context),
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text("휴대전화 번호 재설정페이지")
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