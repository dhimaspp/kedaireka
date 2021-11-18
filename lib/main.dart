import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kedaireka/screen/auth/login.dart';
import 'package:kedaireka/theme/constant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: themePP,
      home: const LoginScreen(),
    );
  }
}
