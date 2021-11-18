// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';

class StepFillEmpat extends StatefulWidget {
  const StepFillEmpat({ Key? key }) : super(key: key);

  @override
  _StepFillEmpatState createState() => _StepFillEmpatState();
}

class _StepFillEmpatState extends State<StepFillEmpat> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: Center(child: Text("data 4"),),
    );
  }
}