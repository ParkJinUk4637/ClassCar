import 'package:flutter/material.dart';

SnackBar classcarSnackBar(String content){
  return SnackBar(
    backgroundColor: Color(0xff1200B3),
    content: Text(
      content,
      style: TextStyle(color: Colors.white, backgroundColor: Color(0xff1200B3)),
    ),
    // backgroundColor: Color(0xff1200B3),
  );
}