import 'package:flutter/material.dart';

Widget titleText(String text) {
  return Container(
    margin: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
    child: Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
    ),
  );
}

Widget miniTitleText(String text) {
  return Container(
    margin: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
    child: Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    ),
  );
}

Widget contentsText(String text) {
  return Container(
    margin: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
    child: Text(
      text,
      style: const TextStyle(fontSize: 16),
    ),
  );
}