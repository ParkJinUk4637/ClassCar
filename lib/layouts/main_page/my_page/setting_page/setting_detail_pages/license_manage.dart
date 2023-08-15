import 'package:flutter/material.dart';
import 'package:my_classcar/layouts/main_page/app_bar.dart';

class LicenseManage extends StatefulWidget{
  const LicenseManage({super.key});

  @override
  State<LicenseManage> createState() => _LicenseManage();
}

class _LicenseManage extends State<LicenseManage>{
  final TextEditingController licenseController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: closeAppBar("면허 관리", context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _licenseTextField(),
            const SizedBox(height: 10),
            registButton(),
          ],
        )
      ),
    );
  }

  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /*Widget _licenseInfo(){

  }*/

  Widget _licenseTextField(){
    String id = '면허 변경';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(id),
        const SizedBox(height: 10),
        TextFormField(
          controller: licenseController,
          autovalidateMode: AutovalidateMode.always,
          keyboardType: TextInputType.emailAddress,
          validator: (String? value) {
            if (value!.isEmpty) {
              return '면허증 번호를 입력하세요';
            }
            return null;
          },
          decoration: InputDecoration(
              labelText: '면허증 번호',
              hintText: " 면허증 번호 입력",
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

  Widget registButton(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
            style: TextButton.styleFrom(
                backgroundColor: const Color(0xff1200B3),
                // disabledBackgroundColor: Colors.grey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30,)
                ),
                minimumSize: const Size(370, 55)),

            /// 버튼 스타일 설정
            onPressed: () {
            },
            child: const Text(
              "등록",
              style: TextStyle(color: Colors.white),
            )),
      ],
    );
  }
}