//import 'package:e_cm/auth/view/splash_screen.dart';
// import 'package:e_cm/homepage/dashboard.dart';
// ignore_for_file: prefer_const_constructors

import 'package:e_cm/auth/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
