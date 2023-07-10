import 'package:flutter/material.dart';

class AutoLogin extends StatefulWidget {
  const AutoLogin({super.key});

  @override
  State<AutoLogin> createState() => _AutoLogin();
}

class _AutoLogin extends State<AutoLogin> {
  bool? _idSave = false;
  bool? _auto = false;

  @override
  Widget build(BuildContext context){
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
}