// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';

class StepFillDua extends StatefulWidget {
  const StepFillDua({ Key? key }) : super(key: key);

  @override
  _StepFillDuaState createState() => _StepFillDuaState();
}

class _StepFillDuaState extends State<StepFillDua> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: Center(child: Text("data 2"),),
    );
  }
}