import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_classcar/layouts/main_page/my_page/list_tile_button.dart';
import 'package:my_classcar/layouts/main_page/my_page/setting_page/setting_detail_pages/reauth_password_reset.dart';
import 'package:my_classcar/layouts/main_page/my_page/setting_page/setting_page.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<StatefulWidget> createState() => _MyPage();
}

class _MyPage extends State<MyPage> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              _profile(),
              const Divider(
                height: 2,
                thickness: 2,
                color: Colors.black,
              ),
              _part1(),
              const Divider(
                height: 2,
                thickness: 2,
                color: Colors.black,
              ),
              _part2(),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingPage()),
                  );
                },
                child: const Text(
                  "설정",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _profile() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Icon(
          Icons.person,
          size: 140,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('${user?.displayName}'),
            Text('${user?.email}'),
            const Text("Credit : (TestCredit)"),
          ],
        )
      ],
    );
  }

  Widget _part1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        listTileButton("이용 내역(아직 미구현)", const ReauthPasswordReset(), context),
        const Divider(
          height: 1,
          thickness: 1,
        ),
        listTileButton("쿠폰(아직 미구현)", const ReauthPasswordReset(), context),
        const Divider(
          height: 1,
          thickness: 1,
        ),
        listTileButton("이벤트/혜택(아직 미구현)", const ReauthPasswordReset(), context),
      ],
    );
  }

  Widget _part2() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        listTileButton("문의 내역(아직 미구현)", const  ReauthPasswordReset(), context),
        const Divider(
          height: 1,
          thickness: 1,
        ),
        listTileButton(
            "고객센터 (QnA, FAQ)(아직 미구현)", const  ReauthPasswordReset(), context),
        const Divider(
          height: 1,
          thickness: 1,
        ),
        listTileButton("공지사항(아직 미구현)", const  ReauthPasswordReset(), context),
      ],
    );
  }
}