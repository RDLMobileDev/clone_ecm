// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';

class StepFillEnam extends StatefulWidget {
  const StepFillEnam({ Key? key }) : super(key: key);

  @override
  _StepFillEnamState createState() => _StepFillEnamState();
}

class _StepFillEnamState extends State<StepFillEnam> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: Center(child: Text("data 6"),),
    );
  }
}