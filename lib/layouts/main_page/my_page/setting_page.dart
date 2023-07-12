import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget{
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            Text("계정관리"),
            SizedBox(height: 10),
            Text("비밀번호 설정"),
            Text("휴대폰 번호 재설정"),
            Text("계정 연동 설정"),
            SizedBox(height: 20),
            Text("결제 및 할인"),
            SizedBox(height: 10),
            Text("결제 (카드 등록)"),
            Text("면허 등록"),
            SizedBox(height: 20),
            Text("이용 정보"),
            SizedBox(height: 10),
            Text("약관 및 정책"),
            Text("사용 메뉴얼"),
            Text("앱 버전"),
            Text("회원 탈퇴"),
          ],
        )
      )
    );
  }
}