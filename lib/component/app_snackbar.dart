import 'package:flutter/material.dart';

SnackBar classcarSnackBar(String content, BuildContext context){
  return SnackBar(
    backgroundColor: Theme.of(context).focusColor,
    content: Text(
      content,
      style: TextStyle(color: Colors.white, backgroundColor: Theme.of(context).focusColor),
    ),
    // backgroundColor: Color(0xff1200B3),
  );
}