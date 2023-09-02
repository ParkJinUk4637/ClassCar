import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:my_classcar/layouts/main_page/app_bar.dart';

import '../../main.dart';

class find_pw_page extends StatefulWidget {
  const find_pw_page({super.key});

  @override
  State<StatefulWidget> createState() => _find_pw();
}

class _find_pw extends State<find_pw_page> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController emailController = TextEditingController();


  Future<void> send_mail(String email)  async {
    String emailAddress = email;
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: emailAddress);
  }

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
        const Text("회원정보에 등록한 이메일로 비밀번호를 재설정하세요"),
        const Text("재설정을 완료했으면, 창을 닫고 다시 로그인 해주세요"),
        const SizedBox(height: 30,),
        TextFormField(
          controller: emailController,
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
             send_mail(emailController.text)
            },
            child: const Text("비밀번호 재발급", style: TextStyle(color: Colors.white),)
        ),
      ],
    );
  }

  Future<bool> find_login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      // Get.offAll(() => const MainLayout());
    } on FirebaseAuthException catch (e) {
      String m = '';
      if (e.code == 'user-not-found') {
        logger.w('No user found for that email.');
        m = '*이메일을 확인해주세요*';
      } else if (e.code == 'wrong-password') {
        logger.w('Wrong password provided for that user.');
        m = '*비밀번호를 확인해주세요*';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(m),
          backgroundColor: const Color(0xff1200B3),
        ),
      );
    } catch (e) {
      logger.e(e);
      return false;
    }
    return true;
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