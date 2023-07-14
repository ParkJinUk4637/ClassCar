import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:my_classcar/layouts/login/login_page.dart';
import 'package:my_classcar/layouts/main_page/app_bar.dart';
import 'package:my_classcar/layouts/main_page/my_page/setting_detail_pages/delete_user.dart';
import 'package:my_classcar/layouts/main_page/my_page/setting_detail_pages/password_reset.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  State<SettingPage> createState() => _SettingPage();
}

class _SettingPage extends State<SettingPage> {
  static const storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: settingAppBar("설정", context),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Text("계정관리"),
                SizedBox(height: 10),
                _button(const PasswordReset(), "비밀번호 재설정"),
                Text("휴대폰 번호 재설정"),
                Text("계정 연동 설정"),
                _button(const DeleteUser(), "회원탈퇴"),
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
                const SizedBox(height: 10,),
                _logoutButton(),
              ],
            )));
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

  Widget _logoutButton(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
            style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                minimumSize: const Size(370, 55),
              side: const BorderSide(
                color: Colors.redAccent,
              )
            ),

            onPressed: () async =>
            {
              _signOut(),
            },
            child: const Text("로그아웃", style: TextStyle(color: Colors.redAccent),)
        ),
      ],
    );
  }

  void _signOut() async{
    await FirebaseAuth.instance.signOut();
    storage.deleteAll();
    Get.offAll(() => const LoginPage());
  }

  Widget _button(Widget widget, String name){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => widget),
            );
          },
          child: Text(
            name,
            style: const TextStyle(color: Colors.black),
          ),
        )
      ],
    );
  }
}
