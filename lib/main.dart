import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:logger/logger.dart';
import 'package:my_classcar/layouts/login/loding.dart';
import 'firebase_options.dart';

// Logger 세팅
var logger = Logger(
  printer: PrettyPrinter(),
);

// firebase initialize
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key : key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Class Car',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'SUITE'
      ),
      home: const LoadPage(),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  dispose() async{
    super.dispose();
  }
}