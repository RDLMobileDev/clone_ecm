// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';

class StepFillLima extends StatefulWidget {
  const StepFillLima({ Key? key }) : super(key: key);

  @override
  _StepFillLimaState createState() => _StepFillLimaState();
}

class _StepFillLimaState extends State<StepFillLima> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: Center(child: Text("data 5"),),
    );
  }
}