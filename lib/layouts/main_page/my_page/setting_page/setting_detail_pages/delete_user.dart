import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_classcar/layouts/main_page/app_bar.dart';

import '../../../../login/login_page.dart';

class DeleteUser extends StatefulWidget{
  const DeleteUser({super.key});

  @override
  State<DeleteUser> createState() => _DeleteUser();
}

class _DeleteUser extends State<DeleteUser>{

  Future<void> _dialog() async {
    return showDialog<void>(
      //다이얼로그 위젯 소환
      context: context,
      barrierDismissible: false, // 다이얼로그 이외의 바탕 눌러도 안꺼지도록 설정
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('알림'),
          content: const SingleChildScrollView(
            child: ListBody(
              //List Body를 기준으로 Text 설정
              children: <Widget>[
                Text('회원탈퇴가 정상적으로 완료되었습니다'),
                Text('이용해주셔서 감사합니다'),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('확인'),
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: closeAppBar("회원 탈퇴", context),
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 10,),
            const Text('정말 회원탈퇴를 진행하겠습니까?'),
            const Text('계정탈퇴 시, 삭제된 회원정보는 복구할 수 없습니다'),
            const Text('계정탈퇴를 하려면 확인 버튼을 눌러주세요'),
            const SizedBox(height: 40,),
            TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: const Color(0xff1200B3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: const Size(370, 55)
                ),

                /// 버튼 스타일 설정
                onPressed: () =>
                {
                  _delete_user(),
                },
                child: const Text("확인", style: TextStyle(color: Colors.white),)
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _delete_user() async {
    final User? _user = FirebaseAuth.instance?.currentUser;
    await _user?.delete();
    _dialog();
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