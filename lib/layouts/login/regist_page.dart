import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

/// *
/// memo
/// - 주소는 아직 넣지말기
///
/// todo
/// - 비밀번호 validation (8자 이상, 20자이하)
/// - 휴대전화 인증
/// - Firebase Auth에 회원 등록 +

class RegistPage extends StatefulWidget {
  const RegistPage({super.key});

  @override
  State<StatefulWidget> createState() => _RegistPage();
}

class _RegistPage extends State<RegistPage> {
  final _formKey = GlobalKey<FormState>();
  var logger = Logger(
    printer: PrettyPrinter(),
  );
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfigController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController validNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Form(
            key: _formKey,
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    const Text("회원가입"),
                    const SizedBox(height: 10),
                    _userId(),
                    const SizedBox(height: 10),
                    _userPw(),
                    const SizedBox(height: 10),
                    _userPwConfig(),
                    const SizedBox(height: 10),
                    _userName(),
                    const SizedBox(height: 10),
                    _userPhoneNumber(),
                    const SizedBox(height: 10),
                    _validNumberRequest(),
                    const SizedBox(height: 10),
                    _registRequest(),
                  ],
                ))));
  }

  @override
  void initState() {
    super.initState();
  }

  // 해당 클래스 사라질 때
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    passwordConfigController.dispose();
    nameController.dispose();
    phoneNumberController.dispose();
    validNumberController.dispose();
    super.dispose();
  }

  Widget _userId() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: emailController,
          autovalidateMode: AutovalidateMode.always,
          keyboardType: TextInputType.emailAddress,
          validator: (String? value) {
            if (value!.isEmpty) {
              return '이메일을 입력하세요';
            } else if (!RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(value)) {
              return '이메일을 올바르게 입력하세요';
            }
            return null;
          },
          decoration: InputDecoration(
              labelText: '이메일',
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

  Widget _userPw() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: passwordConfigController,
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

  Widget _userPwConfig() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: passwordController,
          autovalidateMode: AutovalidateMode.always,
          obscureText: true,
          validator: (String? value) {
            if (value!.isEmpty) {
              return '비밀번호 확인을 입력하세요';
            }
            return null;
          },
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              labelText: '비밀번호 확인',
              hintText: "비밀번호 확인 입력",
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

  Widget _userName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: nameController,
          autovalidateMode: AutovalidateMode.always,
          validator: (String? value) {
            if (value!.isEmpty) {
              return '이름을 입력하세요';
            } else if (!RegExp(r'^[가-힣]{2,4}$').hasMatch(value)) {
              return '이름은 2글자 이상, 4글자 이하의 한글로 입력하세요';
            }
            return null;
          },
          decoration: InputDecoration(
              labelText: '이름',
              hintText: "이름 입력",
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

  Widget _userPhoneNumber() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: phoneNumberController,
          autovalidateMode: AutovalidateMode.always,
          keyboardType: TextInputType.phone,
          validator: (String? value) {
            if (value!.isEmpty) {
              return '휴대전화 번호를 입력하세요';
            } else if (!RegExp(r'^01?([0-9]{9})$')
                .hasMatch(value)) {
              return '휴대전화 번호가 잘못되었습니다';
            }
            return null;
          },
          decoration: InputDecoration(
              labelText: '휴대전화 번호',
              hintText: "휴대전화 번호 입력",
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

  Widget _validNumberRequest() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: validNumberController,
          autovalidateMode: AutovalidateMode.always,
          keyboardType: TextInputType.phone,
          validator: (String? value) {
            if (value!.isEmpty) {
              return '인증번호를 입력하세요';
            }
            return null;
          },
          decoration: InputDecoration(
              labelText: '인증번호',
              hintText: "인증번호 입력",
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

        TextButton(
            style: TextButton.styleFrom(
                backgroundColor: const Color(0xff1200B3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                minimumSize: const Size(370, 55)),
            onPressed: () async {
              FirebaseAuth auth = FirebaseAuth.instance;
              await auth.verifyPhoneNumber(
                phoneNumber: '+82${phoneNumberController.text.substring(1)}',
                timeout: const Duration(seconds: 120),
                verificationCompleted: (PhoneAuthCredential credential) async {
                  // ANDROID ONLY!

                  // Sign the user in (or link) with the auto-generated credential
                  await auth.signInWithCredential(credential);
                },
                verificationFailed: (FirebaseAuthException e) {
                  if (e.code == 'invalid-phone-number') {
                    print('The provided phone number is not valid.');
                  }

                  // Handle other errors
                },
                codeSent: (String verificationId, int? resendToken) async {
                  // Update the UI - wait for the user to enter the SMS code
                  String smsCode = 'xxxx';

                  // Create a PhoneAuthCredential with the code
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(
                      verificationId: verificationId, smsCode: smsCode);

                  // Sign the user in (or link) with the credential
                  await auth.signInWithCredential(credential);
                },
                codeAutoRetrievalTimeout: (String verificationId) {
                  // Auto-resolution timed out...
                },
              );
            },
            child: const Text(
              "인증번호 받기",
              style: TextStyle(color: Colors.white),
            )),
      ],
    );
  }

  Widget _registRequest() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
            style: TextButton.styleFrom(
                backgroundColor: const Color(0xff1200B3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                minimumSize: const Size(370, 55)),

            /// 버튼 스타일 설정
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                          '${emailController.text}/${passwordController.text}')),
                );

                createUser(emailController.text, passwordController.text,
                    nameController.text);
              }
            },
            child: const Text(
              "회원가입",
              style: TextStyle(color: Colors.white),
            )),
      ],
    );
  }

  Future<bool> createUser(
      String email, String password, String name) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final initialUserInfo = FirebaseAuth.instance.currentUser;
      initialUserInfo!.updateDisplayName(name);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        logger.w('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('이미 존재하는 이메일 회원입니다.')),
        );
        logger.w('The account already exists for that email.');
      }
    } catch (e) {
      logger.e(e);
      return false;
    }
    // authPersistence(); // 인증 영속
    return true;
  }
}
