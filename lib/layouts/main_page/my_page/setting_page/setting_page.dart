import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:my_classcar/layouts/login/login_page.dart';
import 'package:my_classcar/layouts/main_page/app_bar.dart';
import 'package:my_classcar/layouts/main_page/my_page/list_tile_button.dart';
import 'package:my_classcar/layouts/main_page/my_page/middle_title.dart';
import 'package:my_classcar/layouts/main_page/my_page/setting_page/setting_detail_pages/delete_user.dart';
import 'package:my_classcar/layouts/main_page/my_page/setting_page/setting_detail_pages/license_manage.dart';
import 'package:my_classcar/layouts/main_page/my_page/setting_page/setting_detail_pages/password_reset.dart';
import 'package:my_classcar/layouts/main_page/my_page/setting_page/setting_detail_pages/phone_number_reset.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPage();
}

class _SettingPage extends State<SettingPage> {
  static const storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: closeAppBar("설정", context),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                middleTitle("계정 관리"),
                const SizedBox(
                  height: 10,
                ),
                _part1(),
                const SizedBox(
                  height: 10,
                ),
                middleTitle("결제 및 할인"),
                const SizedBox(
                  height: 10,
                ),
                _part2(),
                const SizedBox(
                  height: 10,
                ),
                middleTitle("이용 정보"),
                const SizedBox(
                  height: 10,
                ),
                _part3(),
                const SizedBox(
                  height: 10,
                ),
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

  Widget _part1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        listTileButton("비밀번호 재설정", const PasswordReset(), context),
        const Divider(
          height: 1,
          thickness: 1,
        ),
        listTileButton("휴대전화 번호 재설정", const PhoneNumberReset(), context),
        const Divider(
          height: 1,
          thickness: 1,
        ),
        listTileButton("면허 관리", const LicenseManage(), context),
      ],
    );
  }

  Widget _part2() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        listTileButton("결제 및 할인(아직 미구현)", const PasswordReset(), context),
        const Divider(
          height: 1,
          thickness: 1,
        ),
        listTileButton("면허 등록(아직 미구현)", const PasswordReset(), context),
      ],
    );
  }

  Widget _part3() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        listTileButton("약관 및 정책(아직 미구현)", const PasswordReset(), context),
        const Divider(
          height: 1,
          thickness: 1,
        ),
        listTileButton("사용 메뉴얼(아직 미구현)", const PasswordReset(), context),
        const Divider(
          height: 1,
          thickness: 1,
        ),
        listTileButton("앱 버전(아직 미구현)", const PasswordReset(), context),
        const Divider(
          height: 1,
          thickness: 1,
        ),
        listTileButton("회원 탈퇴", const DeleteUser(), context),
      ],
    );
  }

  Widget _logoutButton() {
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
                )),
            onPressed: () async => {
                  _signOut(),
                },
            child: const Text(
              "로그아웃",
              style: TextStyle(color: Colors.redAccent),
            )),
      ],
    );
  }

  void _signOut() async {
    await FirebaseAuth.instance.signOut();
    storage.deleteAll();
    Get.offAll(() => const LoginPage());
  }
}
