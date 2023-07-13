import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
                indent: 20,
                endIndent: 0,
                color: Colors.black,
              ),
              _myPage(),
              const Divider(
                height: 1,
                thickness: 1,
                indent: 1,
                endIndent: 0,
              ),
              _help(),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SettingPage()),
                  );
                },
                child: const Text("설정", style: TextStyle(color: Colors.black),),
              ),
            ],
          ),
        )
    );
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
        const Icon(Icons.person, size: 140,),
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

  Widget _myPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("이용내역(구현안됨)"),
        Text("쿠폰(구현안됨)"),
        Text("이벤트(구현안됨)"),
      ],
    );
  }

  Widget _help() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("문의 내역(구현안됨)"),
        Text("공지사항(구현안됨)"),
        Text("고객센터(구현안됨)")
      ],
    );
  }


}