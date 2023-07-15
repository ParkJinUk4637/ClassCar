import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:my_classcar/component/logo.dart';
import 'package:my_classcar/layouts/login/regist_page.dart';
import 'package:my_classcar/layouts/main_page/main_layout.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  var logger = Logger(printer: PrettyPrinter(),);

  //final _firebaseAuth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  static const storage = FlutterSecureStorage();
  bool? _idSave = false;
  bool? _auto = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
            _autoLogin(),
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
                  _login(emailController.text, passwordController.text),
                  _autoLoginSave(),
                },
                child: const Text("로그인", style: TextStyle(color: Colors.white),)
            ),
          ],
        ),)
      ,
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  // 해당 클래스 사라질 때
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget _find() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, "/find_pw_page");
          },
          child: const Text(
            "아이디 찾기 |  ", style: TextStyle(color: Colors.black),),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, "/find_pw_page");
          },
          child: const Text(
            "비밀번호 찾기 |  ", style: TextStyle(color: Colors.black),),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RegistPage()),
            );
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

  // 로그인
  Future<bool> _login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      Get.offAll(() => const MainLayout());
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

  Widget _autoLogin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Checkbox(
            value: _auto,
            onChanged: (bool? value) {
              setState(() {
                _auto = value;
              });
            }),
        const Text("자동 로그인"),
        const SizedBox(width: 20.0,),
        Checkbox(
            value: _idSave,
            onChanged: (value) {
              setState(() {
                _idSave = value;
              });
            }
        ),
        const Text("아이디 저장"),
      ],
    );
  }

  _autoLoginSave() async {
    if (_auto == true) {
      storage.write(key: "email", value: emailController.text);
      storage.write(key: "password", value: passwordController.text);
    }
  }

  _asyncMethod() async {
    final String? email = await storage.read(key: 'email');
    final String? password = await storage.read(key: 'password');
    if (email != null && password != null) {
      _login(email, password);
    }
  }
}
