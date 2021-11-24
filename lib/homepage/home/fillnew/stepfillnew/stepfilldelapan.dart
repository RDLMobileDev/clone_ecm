// ignore_for_file: sized_box_for_whitespace, unnecessary_const

import 'package:e_cm/homepage/home/fillnew/additionpage/approvestepdelapan.dart';
import 'package:flutter/material.dart';

class StepFillDelapan extends StatefulWidget {
  const StepFillDelapan({Key? key}) : super(key: key);

  @override
  _StepFillDelapanState createState() => _StepFillDelapanState();
}

class _StepFillDelapanState extends State<StepFillDelapan> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: const Text(
                "E-Sign",
                style: TextStyle(
                    fontFamily: 'Rubik',
                    color: Color(0xFF404446),
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ApproveStepDelapan()));
              },
              child: Container(
                margin: const EdgeInsets.only(top: 16),
                width: MediaQuery.of(context).size.width,
                height: 40,
                decoration: const BoxDecoration(
                    color: Color(0XFF00AEDB),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Icon(
                      Icons.add_circle_outline,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "Add E-Sign",
                      style: TextStyle(
                          fontFamily: 'Rubik',
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 24),
              child: const Text(
                "Copy to",
                style: TextStyle(
                    fontFamily: 'Rubik',
                    color: Color(0xFF404446),
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.28,
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
                        const Text("Engineer")
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.28,
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
                        const Text("Product")
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.28,
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
                        const Text("Others")
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: const Text(
                "Approved by",
                style: TextStyle(
                    fontFamily: 'Rubik',
                    color: Color(0xFF404446),
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
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: TextFormField(
                style: const TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    suffixIcon: Icon(Icons.search),
                    hintText: 'Type name',
                    contentPadding: const EdgeInsets.only(top: 5, left: 5),
                    hintStyle: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
              ),
            ),
            SizedBox(
              height: 340,
            )
          ],
        ),
      ),
    );
  }
}
