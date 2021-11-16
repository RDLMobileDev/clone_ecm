import 'dart:ui';

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
        padding: EdgeInsets.fromLTRB(24, 76, 24, 70),
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
                    keyboardType: TextInputType.visiblePassword,
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
                  ElevatedButton(
                    onPressed: null,
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.black54),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
