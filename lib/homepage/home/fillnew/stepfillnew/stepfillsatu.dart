// ignore_for_file: sized_box_for_whitespace, avoid_print, unnecessary_const

import 'package:flutter/material.dart';

class StepFillSatu extends StatefulWidget {
  const StepFillSatu({ Key? key }) : super(key: key);

  @override
  StepFillSatuState createState() => StepFillSatuState();
}

class StepFillSatuState extends State<StepFillSatu> {
  String dateSelected = 'DD/MM/YYYY';
  String locationSelected = 'Select Factory';
  String machineSelected = '-Machine selected-';

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
          crossAxisAlignment: CrossAxisAlignment.start,
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
                      padding: const EdgeInsets.all(8),
                      width: 96,
                      child: const Center(child: Text("Breakdown Maintance", style: TextStyle(fontFamily: 'Rubik', fontSize: 14, color: Color(0xFF404446), fontWeight: FontWeight.w400 ), ),),
                    ),
                  ),

                  Card(
                    elevation: 2,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      width: 96,
                      child: const Center(child: Text("Preventive Maintance", style: TextStyle(fontFamily: 'Rubik', fontSize: 14, color: Color(0xFF404446), fontWeight: FontWeight.w400 ), ),),
                    ),
                  ),

                  Card(
                    elevation: 2,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      width: 96,
                      child: const Center(child: Text("Information Maintance", style: TextStyle(fontFamily: 'Rubik', color: Color(0xFF404446), fontSize: 14, fontWeight: FontWeight.w400 ), ),),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: const Text("Date", style: TextStyle(fontFamily: 'Rubik', fontSize: 16, fontWeight: FontWeight.w400),),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.all(5),
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF979C9E)),
                borderRadius: const BorderRadius.all(Radius.circular(5))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const SizedBox(width: 40, height: 40, child: Icon(Icons.calendar_today)),
                  Text(dateSelected, style: const TextStyle(fontFamily: 'Rubik', fontSize: 14, fontWeight: FontWeight.w400),),
                  const SizedBox(width: 40, height: 40, child: Icon(Icons.arrow_drop_down))
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: const Text("Team Member", style: TextStyle(fontFamily: 'Rubik', fontSize: 16, fontWeight: FontWeight.w400),),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.all(5),
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF979C9E)),
                borderRadius: const BorderRadius.all(Radius.circular(5))
              ),
              child: TextFormField(
                style: const TextStyle(fontFamily: 'Rubik', fontSize: 14, fontWeight: FontWeight.w400),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  suffixIcon: Icon(Icons.search),
                  hintText: 'Type name',
                  contentPadding: const EdgeInsets.only(top: 5, left: 5),
                  hintStyle: TextStyle(fontFamily: 'Rubik', fontSize: 14, fontWeight: FontWeight.w400)
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: const Text("Location", style: TextStyle(fontFamily: 'Rubik', fontSize: 16, fontWeight: FontWeight.w400),),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.all(5),
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF979C9E)),
                borderRadius: const BorderRadius.all(Radius.circular(5))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(locationSelected, style: const TextStyle(fontFamily: 'Rubik', color: Color(0xFF979C9E), fontSize: 14, fontWeight: FontWeight.w400),),
                  ),
                  const SizedBox(width: 40, height: 40, child: Icon(Icons.arrow_drop_down))
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: const Text("Machine Name", style: TextStyle(fontFamily: 'Rubik', fontSize: 16, fontWeight: FontWeight.w400),),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.all(5),
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF979C9E)),
                borderRadius: const BorderRadius.all(Radius.circular(5))
              ),
              child: TextFormField(
                style: const TextStyle(fontFamily: 'Rubik', fontSize: 14, fontWeight: FontWeight.w400),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  suffixIcon: Icon(Icons.search),
                  hintText: 'Type machine',
                  contentPadding: const EdgeInsets.only(top: 5, left: 5),
                  hintStyle: TextStyle(fontFamily: 'Rubik', fontSize: 14, fontWeight: FontWeight.w400)
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: const Text("Machine number", style: TextStyle(fontFamily: 'Rubik', fontSize: 16, fontWeight: FontWeight.w400),),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.all(5),
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF979C9E)),
                borderRadius: const BorderRadius.all(Radius.circular(5))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(machineSelected, style: const TextStyle(fontFamily: 'Rubik', fontSize: 14, fontWeight: FontWeight.w400),),
                  ),
                  const SizedBox(width: 40, height: 40, child: Icon(Icons.arrow_drop_down))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}