// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors
import 'package:flutter/material.dart';

class StepFillTujuh extends StatefulWidget {
  const StepFillTujuh({Key? key}) : super(key: key);

  @override
  _StepFillTujuhState createState() => _StepFillTujuhState();
}

class _StepFillTujuhState extends State<StepFillTujuh> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40,
      decoration: BoxDecoration(
          color: Color(0xFF00AEDB),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_circle_outline,
              color: Colors.white,
            ),
            SizedBox(width: 10),
            Text(
              "Add Item",
              style: TextStyle(
                  fontFamily: 'Rubik',
                  color: Colors.white,
                  fontSize: 12,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
