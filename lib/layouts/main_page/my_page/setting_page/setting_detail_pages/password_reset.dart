import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_classcar/layouts/main_page/app_bar.dart';

import '../../my_page.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({super.key});

  State<PasswordReset> createState() => _PasswordReset();
}

class _PasswordReset extends State<PasswordReset> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: closeAppBar("비밀번호 변경", context),
      resizeToAvoidBottomInset: true,
      body: Padding(
        key: _formKey,
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 20,),
            _text(),
            const SizedBox(height: 30,),
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
                  _updatePassword(passwordController.text),
                },
                child: const Text("확인", style: TextStyle(color: Colors.white),)
            ),
          ],
        ),
      ),
    );
  }

  Widget _text(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("새로운 비밀번호를 입력해주세요"),
        const SizedBox(height: 30,),
        TextFormField(
          controller: passwordController,
          autovalidateMode: AutovalidateMode.always,
          keyboardType: TextInputType.emailAddress,
          obscureText: true,
          validator: (String? value) {
            if(value!.isEmpty){
              return '비밀번호를 입력하세요';
            }
            return null;
          },
          decoration: InputDecoration(
              labelText: '비밀번호',
              hintText: "비밀번호 입력",
              enabledBorder: OutlineInputBorder(
                // 기본 모양
                borderRadius: BorderRadius.circular(20),
              ),
              focusedBorder: OutlineInputBorder(
                // 포커스 되었을 경우 모양
                borderRadius: BorderRadius.circular(20),
              ),
              errorBorder: OutlineInputBorder(
                // 에러 발생 시 모양
                  borderRadius: BorderRadius.circular(20)),
              focusedErrorBorder: OutlineInputBorder(
                // 에러 발생 후 포커스 되었을 경우 모양
                  borderRadius: BorderRadius.circular(20))),
        ),
      ],
    );
  }

  Future<void> _updatePassword(String newPassword) async {
    String password = newPassword;

    await FirebaseAuth.instance.currentUser?.updatePassword(newPassword);
    _dialog();
  }

  Future<void> _dialog() async {
    return showDialog<void>(
      //다이얼로그 위젯 소환
      context: context,
      barrierDismissible: false, // 다이얼로그 이외의 바탕 눌러도 안꺼지도록 설정
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('비밀번호 변경'),
          content: const SingleChildScrollView(
            child: ListBody(
              //List Body를 기준으로 Text 설정
              children: <Widget>[
                Text('비밀번호를 변경하시겠습니까?'),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('확인'),
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MyPage()),);
              },
            ),
            TextButton(
              child: const Text('취소'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
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