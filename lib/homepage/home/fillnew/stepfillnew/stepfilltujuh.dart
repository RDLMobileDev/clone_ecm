// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors
import 'package:e_cm/homepage/home/fillnew/additionpage/add_item_step7.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class StepFillTujuh extends StatefulWidget {
  final _StepFillTujuhState stepFillTujuhState = _StepFillTujuhState();

  @override
  _StepFillTujuhState createState() => _StepFillTujuhState();
}

class _StepFillTujuhState extends State<StepFillTujuh> {
  void getSaveStepFillTujuh() {
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
                text: 'Spare Part ',
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
                    "No spare part yet",
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
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddItemFillTujuh()));
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 40,
              decoration: BoxDecoration(
                  color: Color(0xFF00AEDB),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
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
                      'Total (Rp) :',
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        fontSize: 16,
                      ),
                    ),
                    Text('0.00'),
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
