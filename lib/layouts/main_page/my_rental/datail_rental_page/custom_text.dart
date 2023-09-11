import 'package:flutter/material.dart';

EdgeInsets _textEdge = const EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 2.0);

Widget titleText(String text) {
  return Container(
    margin: _textEdge,
    child: Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
    ),
  );
}

Widget miniTitleText(String text) {
  return Container(
    margin: _textEdge,
    child: Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    ),
  );
}

Widget contentsText(String text) {
  return Container(
    margin: _textEdge,
    child: Text(
      text,
      style: const TextStyle(fontSize: 16),
    ),
  );
}