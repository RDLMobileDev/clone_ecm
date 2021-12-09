// ignore_for_file: sized_box_for_whitespace, unnecessary_const, prefer_const_constructors

import 'package:flutter/material.dart';

class ApproveStepDelapan extends StatefulWidget {
  const ApproveStepDelapan({Key? key}) : super(key: key);

  @override
  _ApproveStepDelapanState createState() => _ApproveStepDelapanState();
}

class _ApproveStepDelapanState extends State<ApproveStepDelapan> {
  String positionSelected = 'Select position';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF00AEDB),
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    child: const Text(
                      "Position",
                      style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.all(5),
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF979C9E)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            positionSelected,
                            style: const TextStyle(
                                fontFamily: 'Rubik',
                                color: Color(0xFF979C9E),
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        const SizedBox(
                            width: 40,
                            height: 40,
                            child: Icon(Icons.arrow_drop_down))
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    child: const Text(
                      "Name",
                      style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.all(5),
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF979C9E)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    child: TextFormField(
                      style: const TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      decoration: const InputDecoration(
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          suffixIcon: Icon(Icons.search),
                          hintText: 'Type name',
                          contentPadding:
                              const EdgeInsets.only(top: 5, left: 5),
                          hintStyle: TextStyle(
                              fontFamily: 'Rubik',
                              fontSize: 14,
                              fontWeight: FontWeight.w400)),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 40,
              decoration: BoxDecoration(
                color: Color(0xFF979C9E),
                borderRadius: BorderRadius.all(Radius.circular(5))
              ),
              child: Center(child: Text("Approve", style: TextStyle(fontFamily: 'Rubik', color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),),),
            )
          ],
        ),
      ),
    );
  }
}
