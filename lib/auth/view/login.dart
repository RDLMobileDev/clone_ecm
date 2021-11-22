// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';
import 'package:e_cm/homepage/dashboard.dart';
import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.fromLTRB(24, 76, 24, 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome Back.",
                      style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 32,
                          color: Color(0xFF00AEDB),
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "Log in to your account",
                      style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 36,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                          suffixStyle: TextStyle(color: Colors.green)),
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          suffixStyle: TextStyle(color: Colors.green)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Forgot Password",
                      style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 16,
                          color: Color(0xFF00AEDB),
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 48,
                    ),
                    Container(
                      color: Color(0xff979C9E),
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const Dashboard()));
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 200,
                    ),
                    Container(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.0,
                          ),
                          children: [
                            TextSpan(
                              text: "By continuing, you agree to our ",
                              style: TextStyle(
                                  fontFamily: 'Rubik',
                                  color: Color(0xff404446)),
                            ),
                            TextSpan(
                              text: "Terms of Service ",
                              style: TextStyle(
                                  fontFamily: 'Rubik',
                                  color: Color(0xff00AEDB)),
                            ),
                            TextSpan(
                              text: "\nand ",
                              style: TextStyle(
                                  fontFamily: 'Rubik',
                                  color: Color(0xff404446)),
                            ),
                            TextSpan(
                              text: "Privacy Policy",
                              style: TextStyle(
                                  fontFamily: 'Rubik',
                                  color: Color(0xff00AEDB)),
                            ),
                            TextSpan(
                              text: ".",
                              style: TextStyle(
                                  fontFamily: 'Rubik',
                                  color: Color(0xff404446)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
