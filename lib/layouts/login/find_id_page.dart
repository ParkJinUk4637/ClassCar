import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:my_classcar/layouts/main_page/app_bar.dart';

class find_id_page extends StatefulWidget {
  const find_id_page({super.key});

  @override
  State<StatefulWidget> createState() => _find_id();
}

class _find_id extends State<find_id_page> {
  final _formKey = GlobalKey<FormState>();

  bool authOk = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: closeAppBar("아이디 찾기", context),
      resizeToAvoidBottomInset: true,
      body: Padding(
        key: _formKey,
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 20,),
            _explain(),
            const SizedBox(height: 20,),
            _userPhoneNumber(),
            const SizedBox(height: 20,),
            _validNumberRequest(),
            const SizedBox(height: 20,),
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
        ),
      ),
    );
  }

  Widget _userPhoneNumber() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 7,
          child: TextFormField(
            controller: null,
            autovalidateMode: AutovalidateMode.always,
            keyboardType: TextInputType.phone,
            validator: (String? value) {
              if (value!.isEmpty) {
                return '휴대전화 번호를 입력하세요';
              } else if (!RegExp(r'^01?([0-9]{9})$').hasMatch(value)) {
                return '휴대전화 번호가 잘못되었습니다';
              }
              return null;
            },
            decoration: InputDecoration(
                labelText: '휴대전화 번호',
                hintText: "전화번호 입력",
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
        ),
        const SizedBox(width: 5),
        Expanded(
            flex: 3,
            child: authOk ? TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  minimumSize: const Size(370, 55)),
              onPressed: () {},
              child: const Text("인증완료",style: TextStyle(color: Colors.white)),) :
            TextButton(
                style: TextButton.styleFrom(
                    backgroundColor:  const Color(0xff1200B3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: const Size(370, 55)),
                onPressed: () async {
                  setState(() {
                    // showLoading = true;
                  });
                  // await _auth.verifyPhoneNumber(
                  //   timeout: const Duration(seconds: 60),
                  //   codeAutoRetrievalTimeout: (String verificationId) {
                  //   },
                  //   phoneNumber: "+82${phoneNumberController.text.trim().substring(1)}",
                  //   verificationCompleted: (phoneAuthCredential) async {
                  //     print("OTP 문자 옴");
                  //   },
                  //   verificationFailed: (verificationFailed) async {
                  //     print(verificationFailed.code);
                  //
                  //     print("코드 발송 실패");
                  //     setState(() {
                  //       showLoading = false;
                  //     });
                  //   },
                  //   codeSent: (verificationId, resendingToken) async {
                  //     print("코드 보냄");
                  //     setState(() {
                  //       requestedAuth = true;
                  //       showLoading = false;
                  //       this.verificationId = verificationId;
                  //     });
                  //   },
                  // );
                },
                child: const Text("인증요청",
                    style: TextStyle(color: Colors.white)))
          // : TextButton(
          //     style: TextButton.styleFrom(
          //     backgroundColor: Colors.grey,
          //     shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(30),
          //       ),
          //     minimumSize: const Size(370, 55)),
          //   onPressed: () {},
          //   child: const Text(
          //       "인증요청",
          //     style: TextStyle(color: Colors.white)),)
        ),
      ],
    );
  }

  Widget _validNumberRequest() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            flex: 7,
            child: TextFormField(
              controller: null,
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
            )),
        const SizedBox(width: 5),
        Expanded(
          flex: 3,
          child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: const Color(0xff1200B3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  minimumSize: const Size(370, 55)),
              onPressed: () async {
                // PhoneAuthCredential phoneAuthCredential =
                // PhoneAuthProvider.credential(verificationId: verificationId, smsCode: OTPController.text);
                // signInWithPhoneAuthCredential(phoneAuthCredential);
              },
              child: const Text(
                "확인",
                style: TextStyle(color: Colors.white),
              )),
        ),
        const SizedBox(height: 20,),
      ],
    );
  }



  Widget _explain() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("아이디를 잃어버리셨나요?"),
        const Text("회원정보에 등록한 휴대전화 번호로 인증번호를 받을 수 있습니다"),
        const SizedBox(height: 30,),
        TextFormField(
          controller: null,
          autovalidateMode: AutovalidateMode.always,
          validator: (String? value) {
            if (value!.isEmpty) {
              return '이름을 입력하세요';
            }
            // else if (!RegExp(r'^[가-힣]{2,4}$').hasMatch(value)) {
            //   return '이름은 2글자 이상, 4글자 이하의 한글로 입력하세요';
            // }
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
        )
      ],
    );
  }
}