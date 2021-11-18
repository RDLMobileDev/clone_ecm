// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';

class StepFillTujuh extends StatefulWidget {
  const StepFillTujuh({ Key? key }) : super(key: key);

  @override
  _StepFillTujuhState createState() => _StepFillTujuhState();
}

class _StepFillTujuhState extends State<StepFillTujuh> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: Center(child: Text("data 7"),),
    );
  }
}