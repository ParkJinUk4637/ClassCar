import 'package:flutter/material.dart';

Widget listTileButton(String name, Widget widget, BuildContext context) {
  return ListTile(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => widget),
      );
    },
    title: Text(name),
    trailing: const Icon(Icons.arrow_forward_ios),
  );
}
