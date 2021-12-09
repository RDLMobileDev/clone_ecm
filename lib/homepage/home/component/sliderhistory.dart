// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class SliderHistory extends StatelessWidget {
  const SliderHistory({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width * 0.7,
      height: 130,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: Color(0xFF00AEDB))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Text(
            "22-10-2021",
            style: TextStyle(
                fontFamily: 'Rubik',
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: Color(0xFF404446)),
          ),
          SizedBox(height: 8,),
          Text(
            "Factory 3 - Preventive Maintenance",
            style: TextStyle(
                fontFamily: 'Rubik',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xFF00AEDB)),
          ),
          SizedBox(height: 22,),
          Text(
            "Rp. 155. 833",
            style: TextStyle(
                fontFamily: 'Rubik',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF404446)),
          ),
          SizedBox(height: 5,),
          Text(
            "KABEL NYYHY SELANG PU - QTY (1)",
            style: TextStyle(
                fontFamily: 'Rubik',
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: Color(0xFF979C9E)),
          ),
        ],
      ),
    );
  }
}
