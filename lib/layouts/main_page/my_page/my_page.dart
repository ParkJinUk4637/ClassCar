import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_classcar/layouts/main_page/my_page/setting_detail_pages/password_reset.dart';
import 'package:my_classcar/layouts/main_page/my_page/setting_page.dart';

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
          ],
        )
      ],
    );
  }

  Widget _part1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _myPageButton("이용 내역", const PasswordReset()),
        const Divider(
          height: 1,
          thickness: 1,
        ),
        _myPageButton("쿠폰", const PasswordReset()),
        const Divider(
          height: 1,
          thickness: 1,
        ),
        _myPageButton("이벤트/혜택", const PasswordReset()),
      ],
    );
  }

  Widget _part2() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _myPageButton("문의 내역", const PasswordReset()),
        const Divider(
          height: 1,
          thickness: 1,
        ),
        _myPageButton("고객센터 (QnA, FAQ)", const PasswordReset()),
        const Divider(
          height: 1,
          thickness: 1,
        ),
        _myPageButton("공지사항", const PasswordReset()),
      ],
    );
  }

  Widget _myPageButton(String name, Widget widget) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => widget),
        );
      },
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        title: Text(name),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }


}
