// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class SliderHistory extends StatelessWidget {
  final String? tanggal;
  final String? factoryPlace;
  final String? classificationName;
  final String? costRp;
  final String? namaMesin;
  final String? noMesin;
  final String? problem;

  final List? itemsRepair;

  const SliderHistory({
    Key? key,
    this.tanggal,
    this.factoryPlace,
    this.classificationName,
    this.costRp,
    this.namaMesin,
    this.noMesin,
    this.problem,
    this.itemsRepair,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.all(13),
      width: MediaQuery.of(context).size.width * 0.7,
      height: 150,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: Color(0xFF00AEDB))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Text(
            tanggal!,
            style: TextStyle(
                fontFamily: 'Rubik',
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: Color(0xFF404446)),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "$factoryPlace - $classificationName",
            style: TextStyle(
                fontFamily: 'Rubik',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xFF00AEDB)),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            namaMesin ?? "-",
            style: TextStyle(
                fontFamily: 'Rubik',
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Color(0xFF404446)),
          ),
          Text(
            noMesin ?? "-",
            style: TextStyle(
                fontFamily: 'Rubik',
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: Color(0xFF404446)),
          ),
          Text(
            problem ?? "-",
            style: TextStyle(
                fontFamily: 'Rubik',
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: Color(0xFF404446)),
          ),
          SizedBox(
            height: 14,
          ),
          Text(
            "Rp. $costRp",
            style: TextStyle(
                fontFamily: 'Rubik',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF404446)),
          ),
          // SizedBox(
          //   height: 5,
          // ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: itemsRepair!.map((value) {
                var qty = '';
                if (value['qty'] == null) {
                  qty = '0';
                } else {
                  qty = value['qty'];
                }
                return Text(
                  value['nama_part'].toUpperCase() + " - " + "QTY ($qty)",
                  style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF979C9E)),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
