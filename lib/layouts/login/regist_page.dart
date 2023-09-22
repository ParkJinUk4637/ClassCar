import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:my_classcar/layouts/main_page/app_bar.dart';
import 'login_page.dart';
import 'package:my_classcar/models/user_model.dart';
import 'package:remedi_kopo/remedi_kopo.dart';


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

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfigController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController OTPController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _addressDetailController = TextEditingController();
  String telcom = "";
  Map<String, String> formData = {};

  bool authOk = false;
  bool requestedAuth=false;
  bool showLoading = false;
  bool allCheck = false; // 전체확인
  bool otpCheck = false; //인증번호
  int blank_check = 0;

  late String verificationId;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void setup() async {
    blank_check = 0;
  } //빈칸 채크 초기화

  void check()  {
    if (blank_check == 7) {
      allCheck = true;
    } else {
      allCheck = false;
    }
  }

  void signInWithPhoneAuthCredential(phoneAuthCredential) async {
    check();
    setState(() {
      showLoading = true;
    });
    try {
      final authCredential = await _auth.signInWithCredential(
          phoneAuthCredential);
      setState(() {
        showLoading = false;
      });
      if (authCredential?.user != null) {
        setState(() {
          print("인증완료 및 가입성공");
          authOk = true;
          requestedAuth = false;
          otpCheck = true; //인증번호 일치 유무 확인
        });
        await _auth.currentUser?.delete();
        print("인증정보 삭제");
        _auth.signOut();
        print("로그아웃");
        print(blank_check);
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        print("인증실패");
        blank_check += 0;
        showLoading = false;
      });
    }
  }

  UserModel userInfo = UserModel(
      address: "",
      backNum: "",
      birthday: "",
      detailAddress: "",
      email: "",
      isCheckedAgreement: true,
      isCheckedAgreement2: true,
      isCheckedAgreementAD: true,
      name: "",
      password: "",
      phoneNumber: "",
      telecom: "",
      userID: "",
      profilePicLink: "",
      credit: 10000
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: closeAppBar("회원가입", context),
        resizeToAvoidBottomInset: true,
        body: Padding(
            key: _formKey,
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                _userId(),
                const SizedBox(height: 10),
                _userPw(),
                const SizedBox(height: 10),
                _userPwConfig(),
                const SizedBox(height: 10),
                _userName(),
                const SizedBox(height: 10),
                _userAddress(),
                const SizedBox(height: 10),
                _userDetailaddress(),
                const SizedBox(height: 10),
                _userTelecom(),
                const SizedBox(height: 20),
                _userPhoneNumber(),
                const SizedBox(height: 10),
                _validNumberRequest(),
                const SizedBox(height: 10),
                _registRequest(),
              ],
            )));
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
    OTPController.dispose();
    super.dispose();
    setup();
    check();
  }

  Widget _userId() {
    setup();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: emailController,
          autovalidateMode: AutovalidateMode.always,
          keyboardType: TextInputType.emailAddress,
          validator: (String? value) {
            if (value!.isEmpty) {
              blank_check += 0;
              return '이메일을 입력하세요';
            } else if (!RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(value)) {
              blank_check += 0;
              return '이메일을 올바르게 입력하세요';
            }
            userInfo.email = emailController.text;
            blank_check += 1;
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
              blank_check += 0;
              return '비밀번호를 입력하세요';
            }
            userInfo.password = passwordConfigController.text;
            blank_check += 1;
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
              blank_check += 0;
              return '비밀번호 확인을 입력하세요';
            }
            blank_check += 1;
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
              blank_check += 0;
              return '이름을 입력하세요';
            }
            // else if (!RegExp(r'^[가-힣]{2,4}$').hasMatch(value)) {
            //   return '이름은 2글자 이상, 4글자 이하의 한글로 입력하세요';
            // }
            userInfo.name = nameController.text;
            blank_check += 1;
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

  Widget _userAddress(){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            flex: 7,
            child: TextFormField(
              controller: _addressController,
              autovalidateMode: AutovalidateMode.always,
              keyboardType: TextInputType.phone,
              validator: (String? value) {
                if (value!.isEmpty) {
                  blank_check += 0;
                  return '주소를 입력하세요';
                }
                userInfo.address = _addressController.text;
                blank_check += 1;
                return null;
              },
              decoration: InputDecoration(
                  labelText: '주소 입력',
                  hintText: "주소 입력",
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
                  backgroundColor: Theme.of(context).focusColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  minimumSize: const Size(370, 55)),
              onPressed: () {
               _searchAddress();
              },
              child: const Text(
                "주소찾기",
                style: TextStyle(color: Colors.white),
              )),
        )
      ],
    );
  }

  Widget _userDetailaddress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _addressDetailController,
          autovalidateMode: AutovalidateMode.always,
          validator: (String? value) {
            if (value!.isEmpty) {
              blank_check += 0;
              return '상세주소를 입력하세요';
            }
            // else if (!RegExp(r'^[가-힣]{2,4}$').hasMatch(value)) {
            //   return '이름은 2글자 이상, 4글자 이하의 한글로 입력하세요';
            // }
            userInfo.detailAddress = _addressDetailController.text;
            blank_check += 1;
            return null;
          },
          decoration: InputDecoration(
              labelText: '상세주소',
              hintText: "상세주소 입력",
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

  Widget _userTelecom() {
    return Column(
      children: [
        DropdownButtonFormField<String?>(
          decoration: InputDecoration(
              labelText: '통신사',
              hintText: "통신사 선택",
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
          // underline: Container(height: 1.4, color: Color(0xffc0c0c0)),
          onChanged: (String? newValue) {
            telcom = newValue!;
            userInfo.telecom = telcom;
          },
          items:
          ['SKT', 'KT', 'LG U+'].map<DropdownMenuItem<String?>>((String? i) {
            return DropdownMenuItem<String?>(
              value: i,
              child: Text({'SKT': 'SKT', 'KT': 'KT', 'LG U+' : 'LG U+'}[i] ?? '통신사'),
            );
          }).toList(),
        )
      ],
    );
  }

  Widget _userPhoneNumber() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 7,
          child: TextFormField(
            controller: phoneNumberController,
            // autovalidateMode: AutovalidateMode.always,
            keyboardType: TextInputType.phone,
            validator: (String? value) {
              if (value!.isEmpty) {
                blank_check += 0;
                 return '휴대전화 번호를 입력하세요';
              } else if (!RegExp(r'^01?([0-9]{9})$').hasMatch(value)) {
                blank_check += 0;
                 return '휴대전화 번호가 잘못되었습니다';
              }
              blank_check += 1;
              userInfo.phoneNumber = phoneNumberController.text;
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
                  backgroundColor:  Theme.of(context).focusColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  minimumSize: const Size(370, 55)),
              onPressed: () async {
                setState(() {
                  showLoading = true;
                });
                await _auth.verifyPhoneNumber(
                  timeout: const Duration(seconds: 60),
                  codeAutoRetrievalTimeout: (String verificationId) {
                  },
                  phoneNumber: "+82${phoneNumberController.text.trim().substring(1)}",
                  verificationCompleted: (phoneAuthCredential) async {
                    print("OTP 문자 옴");
                  },
                  verificationFailed: (verificationFailed) async {
                    print(verificationFailed.code);

                    print("코드 발송 실패");
                    setState(() {
                      showLoading = false;
                    });
                  },
                  codeSent: (verificationId, resendingToken) async {
                    print("코드 보냄");
                    setState(() {
                      requestedAuth = true;
                      showLoading = false;
                      this.verificationId = verificationId;
                    });
                  },
                );
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
              controller: OTPController,
              autovalidateMode: AutovalidateMode.always,
              keyboardType: TextInputType.phone,
              validator: (String? value) {
                if (value!.isEmpty) {
                  blank_check += 0;
                  return '인증번호를 입력하세요';
                }
                blank_check += 1;
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
                  backgroundColor: Theme.of(context).focusColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  minimumSize: const Size(370, 55)),
              onPressed: () async {
                PhoneAuthCredential phoneAuthCredential =
                    PhoneAuthProvider.credential(verificationId: verificationId, smsCode: OTPController.text);
                signInWithPhoneAuthCredential(phoneAuthCredential);
              },
              child: const Text(
                "확인",
                style: TextStyle(color: Colors.white),
              )),
        )
      ],
    );
  }

  Widget _registRequest() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          allCheck ? TextButton(
              style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).focusColor,
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30,)
              ),
              minimumSize: const Size(370, 55)),
              onPressed: () {
                check();
              try{
                createUser(emailController.text,passwordController.text,nameController.text,phoneNumberController.text);
                print("Login Success!");
                Get.offAll(() => const LoginPage());
              } on FirebaseAuthException catch (e) {
                print('Error $e');
                }
              },
              child: const Text("회원가입",  style: TextStyle(color: Colors.white),)) :
          TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.grey,
                  // disabledBackgroundColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30,)
                  ),
                  minimumSize: const Size(370, 55)),
                  /// 버튼 스타일 설정
                onPressed: () {},
                child: const Text(
                 "회원가입",
                  style: TextStyle(color: Colors.white),
                )),
        ],
    );
  }

  Future<bool> createUser(String email, String password, String name, String phoneNumber) async {
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

  _searchAddress() async {
    KopoModel model = await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => RemediKopo(),
      ),
    );

    if (model != null) {
      final address = model.address ?? '';
      _addressController.value = TextEditingValue(
        text: address,
      );
      formData['address'] = address;

      final buildingName = model.buildingName ?? '';
      _addressDetailController.value = TextEditingValue(
        text: buildingName,
      );
      formData['address_detail'] = buildingName;
    }
  }

  // Future<bool> blankCheck() async {
  //   if(emailController.text != null && passwordConfigController.text != null && passwordController.text != null && nameController.text != null && phoneNumberController.text.length == 11) {
  //     allCheck = true;
  //     return true;
  //   }
  //   else {
  //     allCheck = false;
  //     return false;
  //   }
  // }
}
