import 'package:flutter/material.dart';

class Auto_Login extends StatefulWidget {
  const Auto_Login({super.key});

  @override
  State<Auto_Login> createState() => _autoLogin();
}

class _autoLogin extends State<Auto_Login> {
  bool? _IDsave = false;
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
            value: _IDsave,
            onChanged: (value) {
              setState(() {
                _IDsave = value;
              });
            }
        ),
        const Text("아이디 저장"),
      ],
    );
  }
}