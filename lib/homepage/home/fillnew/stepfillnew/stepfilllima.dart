// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:e_cm/homepage/home/fillnew/additionpage/formstepfilllima.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class StepFillLima extends StatefulWidget {
  final _StepFillLimaState stepFillLimaState = _StepFillLimaState();

  void getSavedStepFillLima() {
    stepFillLimaState.getSavedStepFillLima();
  }

  @override
  _StepFillLimaState createState() => _StepFillLimaState();
}

class _StepFillLimaState extends State<StepFillLima> {
  void getSavedStepFillLima() {
    Fluttertoast.showToast(
        msg: "asdasd",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.white,
        fontSize: 16);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                "Item Repairing",
                style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Image.asset(
                      "assets/images/amico.png",
                      width: 212.5,
                      height: 244.0,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 20),
                    child: Text(
                      "Haven’t checked the item yet",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF00AEDB),
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Rubik',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FormStepFilllima()));
              },
              child: Container(
                margin: const EdgeInsets.only(top: 5),
                width: MediaQuery.of(context).size.width,
                height: 40,
                decoration: BoxDecoration(
                    color: Color(0xFF00AEDB),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Icon(
                      Icons.add_circle_outline,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Add item",
                      style: TextStyle(
                          fontFamily: 'Rubik',
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 150,
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Divider(
                    color: Color(0xFFCDCFD0),
                    thickness: 2,
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Checking Time :',
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          fontSize: 16,
                        ),
                      ),
                      Text('0 H : 0 M'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
