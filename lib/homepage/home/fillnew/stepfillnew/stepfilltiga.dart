// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';

class StepFillTiga extends StatefulWidget {
  const StepFillTiga({ Key? key }) : super(key: key);

  @override
  _StepFillTigaState createState() => _StepFillTigaState();
}

class _StepFillTigaState extends State<StepFillTiga> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: Center(child: Text("data 3"),),
    );
  }
}