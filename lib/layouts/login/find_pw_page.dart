import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:my_classcar/layouts/main_page/app_bar.dart';

class find_pw_page extends StatefulWidget {
  const find_pw_page({super.key});

  @override
  State<StatefulWidget> createState() => _find_pw();
}

class _find_pw extends State<find_pw_page> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: closeAppBar("비밀번호 찾기", context),
      resizeToAvoidBottomInset: true,
      body: Padding(
        key: _formKey,
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 20,),
            _explain(),
          ],
        ),
      ),
    );
  }

  Widget _explain() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("비밀번호를 잃어버리셨나요?"),
        const Text("회원정보에 등록한 이메일로 비밀번호를 찾으세요"),
        const SizedBox(height: 30,),
        TextFormField(
          autovalidateMode: AutovalidateMode.always,
          keyboardType: TextInputType.emailAddress,
          validator: (String? value) {
            if(value!.isEmpty){
              return '아이디(이메일)을 입력하세요';
            }
            return null;
          },
          decoration: InputDecoration(
              labelText: '아이디',
              hintText: "이메일 입력",
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
        const SizedBox(height: 30,),
        TextButton(
            style: TextButton.styleFrom(
                backgroundColor: const Color(0xff1200B3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                minimumSize: const Size(385, 55)
            ),

            /// 버튼 스타일 설정
            onPressed: () =>
            {

            },
            child: const Text("조회하기", style: TextStyle(color: Colors.white),)
        ),
      ],
    );
  }
}