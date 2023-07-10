import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:my_classcar/component/login/auto_login.dart';
import 'package:my_classcar/component/logo.dart';
import 'package:my_classcar/layouts/main_page/main_layout.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final  _formKey = GlobalKey<FormState>();
  var logger = Logger( printer: PrettyPrinter(),);
  //final _firebaseAuth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Widget _find() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, "/find_ID_page");
          },
          child: const Text(
            "아이디 찾기 |  ", style: TextStyle(color: Colors.black),),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, "/find_PW_page");
          },
          child: const Text(
            "비밀번호 찾기 |  ", style: TextStyle(color: Colors.black),),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, "/join_page");
          },
          child: const Text("회원가입", style: TextStyle(color: Colors.black),),
        ),
      ],
    );
  }

  Widget _userId() {
    String id = '아이디';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(id),
        const SizedBox(height: 10),
        TextFormField(
          controller: emailController,
          autovalidateMode: AutovalidateMode.always,
          keyboardType: TextInputType.emailAddress,
          validator: (String? value) {
            if (value!.isEmpty) {
              return '이메일을 입력하세요';
            }
            return null;
          },
          decoration: InputDecoration(
              labelText: '이메일',
              hintText: " 이메일 입력",
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
                  borderRadius: BorderRadius.circular(20)
              ),
              focusedErrorBorder: OutlineInputBorder(
                // 에러 발생 후 포커스 되었을 경우 모양
                  borderRadius: BorderRadius.circular(20)
              )
          ),
        ),
      ],
    );
  }

  Widget _userPw() {
    String pw = '비밀번호';
    return Column(
      key: _formKey,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(pw),
        const SizedBox(height: 10),
        TextFormField(
          controller: passwordController,
          autovalidateMode: AutovalidateMode.always,
          obscureText: true,
          validator: (String? value) {
            if (value!.isEmpty) {
              return '비밀번호를 입력하세요';
            }
            return null;
          },
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
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
                  borderRadius: BorderRadius.circular(20)
              ),
              focusedErrorBorder: OutlineInputBorder(
                // 에러 발생 후 포커스 되었을 경우 모양
                  borderRadius: BorderRadius.circular(20)
              )
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        // key: _formKey,
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 30),
            const Logo('Login'),
            const SizedBox(height: 20),
            _userId(),
            const SizedBox(height: 20),
            _userPw(),
            _find(),
            const AutoLogin(),
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
                    _login(emailController.text, passwordController.text),
                child: const Text("로그인", style: TextStyle(color: Colors.white),)
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    //해당 클래스가 호출되었을떄
    super.initState();
  }

  @override
  void dispose() {
    // 해당 클래스가 사라질떄
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<bool> _login(String email, String password) async {
    try {
      /*final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );*/
      Get.offAll(() => const MainPage());
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
    // authPersistence(); // 인증 영속
    return true;
  }
}
