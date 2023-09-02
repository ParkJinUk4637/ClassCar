import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_classcar/layouts/main_page/app_bar.dart';
import 'package:my_classcar/layouts/main_page/my_page/setting_page/setting_detail_pages/password_reset.dart';
import '../../../../../main.dart';

class ReauthPasswordReset extends StatefulWidget{
  const ReauthPasswordReset({super.key});

  State<ReauthPasswordReset> createState() => _ReauthPasswordReset();
}

class _ReauthPasswordReset extends State<ReauthPasswordReset>{
  final _formKey1  = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> _dialog() async {
    return showDialog<void>(
      //다이얼로그 위젯 소환
      context: context,
      barrierDismissible: false, // 다이얼로그 이외의 바탕 눌러도 안꺼지도록 설정
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('오류'),
          content: const SingleChildScrollView(
            child: ListBody(
              //List Body를 기준으로 Text 설정
              children: <Widget>[
                Text('회원 정보가 일치하지 않습니다'),
                Text('다시 로그인 해주세요'),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
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

   Future<void>reauth(String useremail, String userpassword) async {
    String email = useremail;
    String password = userpassword;

    AuthCredential credential = EmailAuthProvider.credential(email: useremail, password: userpassword);

    try{
      await FirebaseAuth.instance.currentUser?.reauthenticateWithCredential(credential);
      Navigator.push(context,
        MaterialPageRoute(builder: (context) => PasswordReset()),);
    } on FirebaseAuthException catch(e) {
      _dialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: closeAppBar("비밀번호 변경", context),
      resizeToAvoidBottomInset: true,
      body: Padding(
        key: _formKey1,
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 20,),
            _explain(),
            const SizedBox(height: 20,),
            _reAuth_Pw(),
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
                  reauth(emailController.text, passwordController.text),
                },
                child: const Text("확인", style: TextStyle(color: Colors.white),)
            ),
          ],
        ),
      ),
    );
  }

  Widget _explain() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("사용자 인증을 위해 다시 로그인 합니다."),
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
      ],
    );
  }

  Widget _reAuth_Pw() {
    String pw = '비밀번호';
    return Column(
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
  void initState() {
    super.initState();
  }

  // 해당 클래스 사라질 때
  @override
  void dispose() {
    super.dispose();
  }
}