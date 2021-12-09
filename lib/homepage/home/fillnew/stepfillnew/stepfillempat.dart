// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, avoid_unnecessary_containers

import 'package:e_cm/homepage/home/fillnew/additionpage/stepfillempatinput.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class StepFillEmpat extends StatefulWidget {
  final _StepFillEmpatState stepFillEmpatState = _StepFillEmpatState();

  void getSaveStepFillEmpat() {
    stepFillEmpatState.getSaveStepFillEmpat();
  }

  @override
  _StepFillEmpatState createState() => _StepFillEmpatState();
}

class _StepFillEmpatState extends State<StepFillEmpat> {
  void getSaveStepFillEmpat() {
    Fluttertoast.showToast(
        msg: "asdasd",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.greenAccent,
        textColor: Colors.white,
        fontSize: 16);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: RichText(
              text: TextSpan(
                text: 'Item Checking ',
                style: TextStyle(
                    fontFamily: 'Rubik',
                    color: Color(0xFF404446),
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
                children: const <TextSpan>[
                  TextSpan(
                      text: '*',
                      style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 16,
                          color: Colors.red,
                          fontWeight: FontWeight.w400)),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 48,
          ),
          Container(
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
                  builder: (context) => StepFillEmpatInput()));
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.only(top: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Color(0XFF00AEDB)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 5),
                    child: Icon(
                      Icons.add_circle_outline,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  Text(
                    'Add item',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Rubik', color: Colors.white, fontSize: 12),
                  ),
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
    );
  }
}
