// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors
import 'package:e_cm/homepage/home/fillnew/additionpage/add_item_step7.dart';
import 'package:flutter/material.dart';

class StepFillTujuh extends StatefulWidget {
  const StepFillTujuh({Key? key}) : super(key: key);

  @override
  _StepFillTujuhState createState() => _StepFillTujuhState();
}

class _StepFillTujuhState extends State<StepFillTujuh> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => AddItemFillTujuh())
        );
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
    );
  }
}
