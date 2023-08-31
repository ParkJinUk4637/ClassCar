import 'package:flutter/material.dart';
import 'package:my_classcar/component/logo.dart';

PreferredSizeWidget customAppBar(String appBarName, [BuildContext? context]) {
  return AppBar(
    elevation: 1,
    leading: const IconButton(icon: Logo('logo',40,40), onPressed: null),
    actions: const [
      IconButton(
        icon: Icon(Icons.menu),
        onPressed: null,
      )
    ],
    foregroundColor: Colors.black,
    backgroundColor: Colors.white,
    title: Text(appBarName),
  );
}

PreferredSizeWidget closeAppBar(String appBarName, BuildContext context) {
  return AppBar(
    elevation: 1,
    leading: const IconButton(icon: Logo('logo',40,40), onPressed: null),
    actions: [
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          Navigator.pop(context);
        },
      )
    ],
    foregroundColor: Colors.black,
    backgroundColor: Colors.white,
    title: Text(appBarName),
  );
}

PreferredSizeWidget backAppBar(String appBarName, BuildContext context){
  return AppBar(
    elevation: 1,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: (){
        // 뒤로가기
        Navigator.pop(context);
      },
    ),
    foregroundColor: Colors.black,
    backgroundColor: Colors.white,
    title: Text(appBarName),
  );
}