import 'package:flutter/material.dart';
import 'package:my_classcar/layouts/main_page/app_bar.dart';
import 'package:my_classcar/layouts/main_page/my_page/payment_page.dart';
import 'package:my_classcar/layouts/main_page/my_page/custom_payment.dart';

class ChargePage extends StatefulWidget {
  const ChargePage({Key? key, required this.userDocNum}) : super(key:key);

  final String userDocNum;
  @override
  State<ChargePage> createState() => _ChargePage();
}

class _ChargePage extends State<ChargePage> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: closeAppBar("크레딧 충전", context),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                _chargeTextField(),
                const SizedBox(height: 10),
                chargeButton(),
              ],
            )));
  }

  Widget _chargeTextField() {
    String id = "크레딧 충전";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(id),
        const SizedBox(height: 10),
        TextFormField(
          controller: textEditingController,
          autovalidateMode: AutovalidateMode.always,
          keyboardType: TextInputType.emailAddress,
          validator: (String? value) {
            if (value!.isEmpty) {
              return '충전 금액을 입력하세요';
            }
            return null;
          },
          decoration: InputDecoration(
              labelText: '충전 금액',
              hintText: " 충전 금액 입력",
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

  Widget chargeButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
            style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).focusColor,
                // disabledBackgroundColor: Colors.grey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                  30,
                )),
                minimumSize: const Size(370, 55)),

            /// 버튼 스타일 설정
            onPressed: () {
              CustomPayment pay = CustomPayment();
              pay.bootpayTest(context,widget.userDocNum,double.parse(textEditingController.text));
            },
            child: const Text(
              "충전",
              style: TextStyle(color: Colors.white),
            )),
      ],
    );
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
