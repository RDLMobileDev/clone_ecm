// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ApprovedEcm extends StatefulWidget {
  const ApprovedEcm({Key? key}) : super(key: key);

  @override
  _ApprovedEcmState createState() => _ApprovedEcmState();
}

class _ApprovedEcmState extends State<ApprovedEcm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF00AEDB),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          "E-CM Card",
          style: TextStyle(
              fontFamily: 'Rubik', fontSize: 16, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16),
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              width: MediaQuery.of(context).size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                        color: Color(0xFF00AEDB),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage("assets/images/ario.png"))),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 16,
                          ),
                          // ignore: prefer_const_literals_to_create_immutables
                          children: <TextSpan>[
                            TextSpan(
                                text: 'E-CM Card from',
                                style: TextStyle(color: Color(0xFF6C7072))),
                            TextSpan(
                                text: ' Pedrosa',
                                style: TextStyle(
                                    color: Color(0xFF00AEDB),
                                    fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                      const Text(
                        "1 hour ago",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 10,
                            color: Color(0xFF979C9E)),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 22),
                        child: Row(
                          children: [
                            Container(
                              width: 63,
                              height: 24,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xFF00AEDB)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: const Center(
                                child: Text(
                                  "Review",
                                  style: TextStyle(
                                      fontFamily: 'Rubik',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Container(
                              width: 63,
                              height: 24,
                              decoration: const BoxDecoration(
                                  color: Color(0xFF00AEDB),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: const Center(
                                child: Text(
                                  "Approve",
                                  style: TextStyle(
                                      fontFamily: 'Rubik',
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Container(
                              width: 63,
                              height: 24,
                              decoration: const BoxDecoration(
                                  color: Color(0xFFFF0000),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: const Center(
                                child: Text(
                                  "Decline",
                                  style: TextStyle(
                                      fontFamily: 'Rubik',
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              width: MediaQuery.of(context).size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                        color: Color(0xFF00AEDB),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage("assets/images/ario.png"))),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 16,
                          ),
                          // ignore: prefer_const_literals_to_create_immutables
                          children: <TextSpan>[
                            TextSpan(
                                text: 'E-CM Card from',
                                style: TextStyle(color: Color(0xFF6C7072))),
                            TextSpan(
                                text: ' Pedrosa',
                                style: TextStyle(
                                    color: Color(0xFF00AEDB),
                                    fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                      const Text(
                        "1 hour ago",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 10,
                            color: Color(0xFF979C9E)),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 22),
                        child: Row(
                          children: [
                            Container(
                              width: 63,
                              height: 24,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xFF00AEDB)),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5))),
                              child: const Center(
                                child: Text(
                                  "Review",
                                  style: TextStyle(
                                      fontFamily: 'Rubik',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Container(
                              width: 63,
                              height: 24,
                              decoration: BoxDecoration(
                                  color: Color(0xFF00AEDB),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: Center(
                                child: Text(
                                  "Approve",
                                  style: TextStyle(
                                      fontFamily: 'Rubik',
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Container(
                              width: 63,
                              height: 24,
                              decoration: BoxDecoration(
                                  color: Color(0xFFFF0000),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: Center(
                                child: Text(
                                  "Decline",
                                  style: TextStyle(
                                      fontFamily: 'Rubik',
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
