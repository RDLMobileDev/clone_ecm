import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StepFillDua extends StatefulWidget {
  const StepFillDua({Key? key}) : super(key: key);

  @override
  _StepFillDuaState createState() => _StepFillDuaState();
}

class _StepFillDuaState extends State<StepFillDua> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 24, 16, 16),
      color: Colors.white,
      child: Text(
        "Incident",
        style: TextStyle(
            fontSize: 16,
            fontFamily: 'Rubik',
            color: Color(0xff404446),
            fontWeight: FontWeight.normal),
      ),
    );
  }
}
