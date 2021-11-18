// ignore_for_file: sized_box_for_whitespace, avoid_print

import 'package:flutter/material.dart';

class StepFillSatu extends StatefulWidget {
  const StepFillSatu({ Key? key }) : super(key: key);

  @override
  StepFillSatuState createState() => StepFillSatuState();
}

class StepFillSatuState extends State<StepFillSatu> {
  
  // test call method from outside class (fillnew)
  void saveFillNewSatu() {
    print("fill new satu");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: const Text("Classification", style: TextStyle(fontFamily: 'Rubik', color: Color(0xFF404446), fontSize: 16, fontWeight: FontWeight.w400 ),),
            ),
            Container(
              margin: const EdgeInsets.only(top: 8),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    elevation: 2,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: 100,
                      height: 56,
                      child: const Center(child: Text("Breakdown Maintance", style: TextStyle(fontFamily: 'Rubik', fontSize: 14, color: Color(0xFF404446), fontWeight: FontWeight.w400 ), ),),
                    ),
                  ),

                  Card(
                    elevation: 2,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: 100,
                      height: 56,
                      child: const Center(child: Text("Preventive Maintance", style: TextStyle(fontFamily: 'Rubik', fontSize: 14, color: Color(0xFF404446), fontWeight: FontWeight.w400 ), ),),
                    ),
                  ),

                  Card(
                    elevation: 2,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: 100,
                      height: 56,
                      child: const Center(child: Text("Information Maintance", style: TextStyle(fontFamily: 'Rubik', color: Color(0xFF404446), fontSize: 14, fontWeight: FontWeight.w400 ), ),),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}