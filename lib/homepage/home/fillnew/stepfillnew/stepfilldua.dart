// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StepFillDua extends StatefulWidget {
  const StepFillDua({Key? key}) : super(key: key);

  @override
  _StepFillDuaState createState() => _StepFillDuaState();
}

class _StepFillDuaState extends State<StepFillDua> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text(
                    "Incident",
                    style: TextStyle(
                        fontFamily: 'Rubik',
                        color: Color(0xFF404446),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal),
                  ),
                   const Text(
                    "*",
                    style: TextStyle(
                        fontFamily: 'Rubik',
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: 40,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF979C9E)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: 30,
                            height: 30,
                            child:
                                Checkbox(value: false, onChanged: (value) {})),
                        const Text("Shift A")
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: 40,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF979C9E)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: 30,
                            height: 30,
                            child:
                                Checkbox(value: false, onChanged: (value) {})),
                        const Text("Shift B")
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: 40,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF979C9E)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: 30,
                            height: 30,
                            child:
                                Checkbox(value: false, onChanged: (value) {})),
                        const Text("Shift C")
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              padding: const EdgeInsets.all(5),
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF979C9E)),
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: TextFormField(
                style: const TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    prefixIcon: Icon(Icons.access_time),
                    suffixIcon: Icon(Icons.arrow_drop_down),
                    hintText: 'HH:MM',
                    contentPadding: EdgeInsets.all(5),
                    hintStyle: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              padding: const EdgeInsets.all(5),
              height: 80,
              width: 343,
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF979C9E)),
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: Text(
                "Type the problem",
                style: const TextStyle(
                    color: Color(0xFF979C9E),
                    fontSize: 14,
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w400),
              ),
              // child: TextFormField(
              //   style: const TextStyle(
              //       fontFamily: 'Rubik',
              //       fontSize: 14,
              //       fontWeight: FontWeight.w400),
              //   decoration: const InputDecoration(
              //       border: OutlineInputBorder(borderSide: BorderSide.none),
              //       hintText: 'Type the problem'),
              // ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.40,
                    height: 40,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF979C9E)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: 30,
                            height: 30,
                            child:
                                Checkbox(value: false, onChanged: (value) {})),
                        const Text(
                          "Safety",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF72777A),
                              fontStyle: FontStyle.normal),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.40,
                    height: 40,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF979C9E)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: 30,
                            height: 30,
                            child:
                                Checkbox(value: false, onChanged: (value) {})),
                        const Text(
                          "Quality",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF72777A),
                              fontStyle: FontStyle.normal),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.40,
                    height: 40,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF979C9E)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: 30,
                            height: 30,
                            child:
                                Checkbox(value: false, onChanged: (value) {})),
                        const Text(
                          "Delivery",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF72777A),
                              fontStyle: FontStyle.normal),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.40,
                    height: 40,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF979C9E)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: 30,
                            height: 30,
                            child:
                                Checkbox(value: false, onChanged: (value) {})),
                        const Text(
                          "Cost",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF72777A),
                              fontStyle: FontStyle.normal),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: const Text(
                "Percentage Mistake",
                style: TextStyle(
                    fontFamily: 'Rubik',
                    color: Color(0xFF404446),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.40,
                    height: 40,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF979C9E)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: 30,
                            height: 30,
                            child:
                                Checkbox(value: false, onChanged: (value) {})),
                        const Text(
                          "Molding",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF72777A),
                              fontStyle: FontStyle.normal),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.40,
                    height: 40,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF979C9E)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: 30,
                            height: 30,
                            child:
                                Checkbox(value: false, onChanged: (value) {})),
                        const Text(
                          "Utility",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF72777A),
                              fontStyle: FontStyle.normal),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.40,
                    height: 40,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF979C9E)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: 30,
                            height: 30,
                            child:
                                Checkbox(value: false, onChanged: (value) {})),
                        const Text(
                          "Production",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF72777A),
                              fontStyle: FontStyle.normal),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.40,
                    height: 40,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF979C9E)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: 30,
                            height: 30,
                            child:
                                Checkbox(value: false, onChanged: (value) {})),
                        const Text(
                          "Engineering",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF72777A),
                              fontStyle: FontStyle.normal),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.40,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF979C9E)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: 30,
                            height: 30,
                            child:
                                Checkbox(value: false, onChanged: (value) {})),
                        const Text(
                          "Other",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF72777A),
                              fontStyle: FontStyle.normal),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: const Text(
                "Picture and Analysis",
                style: TextStyle(
                    fontFamily: 'Rubik',
                    color: Color(0xFF404446),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4),
              height: 120,
              width: 343,
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF979C9E)),
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_a_photo,
                    color: Color(0xFF979C9E),
                    size: 50,
                  ),
                  Text(
                    "Tap to add, max 4 photo",
                    style: const TextStyle(
                        color: Color(0xFF979C9E),
                        fontSize: 14,
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              // child: TextFormField(
              //   style: const TextStyle(
              //       fontFamily: 'Rubik',
              //       fontSize: 14,
              //       fontWeight: FontWeight.w400),
              //   decoration: const InputDecoration(
              //       border: OutlineInputBorder(borderSide: BorderSide.none),
              //       hintText: 'Type the problem'),
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
