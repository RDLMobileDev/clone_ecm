// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:e_cm/auth/view/login.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void moveToLogin() {
    Timer(Duration(seconds: 3), () => Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LogIn())
    ));
  }

  @override
  void initState() {
    moveToLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    alignment: Alignment.center,
                    image: AssetImage("assets/images/splash_screen.png"),
                    fit: BoxFit.fitWidth)),
          ),
          Center(
            child: Container(
              width: 210,
              height: 110,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      alignment: Alignment.center,
                      image: AssetImage("assets/images/logo_sugity.png"),
                      fit: BoxFit.contain)),
            ),
          )
        ],
      ),
    );
  }
}
