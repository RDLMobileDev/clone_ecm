// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, unnecessary_const, avoid_unnecessary_containers

import 'package:flutter/material.dart';

class StepFillEnam extends StatefulWidget {
  const StepFillEnam({Key? key}) : super(key: key);

  @override
  _StepFillEnamState createState() => _StepFillEnamState();
}

class _StepFillEnamState extends State<StepFillEnam> {
  final TextEditingController tecItem = TextEditingController();
  final TextEditingController tecName = TextEditingController();

  Map<String, bool> formValidations = {
    "name": false,
    "idea": false,
  };

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
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                "Improvement/Kaizen",
                style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 8),
              // ignore: prefer_const_constructors
              child: RichText(
                text: TextSpan(
                  text: 'Name ',
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
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 10),
              height: 40,
              child: TextFormField(
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 18),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    filled: true,
                    suffixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                      size: 30,
                    ),
                    hintText: 'Type Name'),
                maxLines: 1,
                controller: tecName,
                onChanged: (value) {
                  setState(() {
                    formValidations["name"] = value.isNotEmpty;
                  });
                },
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 16),
              // ignore: prefer_const_constructors
              child: RichText(
                text: TextSpan(
                  text: 'Idea ',
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
            Container(
              margin: EdgeInsets.only(top: 10),
              child: TextFormField(
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Type your idea',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF979C9E)),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    formValidations["idea"] = value.isNotEmpty;
                  });
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 24),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 24),
              child: Text(
                "Working Time",
                style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Container(
                    width: 115,
                    child: Text(
                      "Check + Repair",
                      style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Text(
                    ":",
                    style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 44,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF979C9E)),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                      child: Text(
                        "1 H",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            color: Color(0xFF979C9E),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Container(
                    width: 44,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF979C9E)),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                      child: Text(
                        "0 M",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            color: Color(0xFF979C9E),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text(
                        "+",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            color: Color(0xFF979C9E),
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Container(
                    width: 44,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF979C9E)),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                      child: Text(
                        "1 H",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            color: Color(0xFF979C9E),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Container(
                    width: 44,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF979C9E)),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                      child: Text(
                        "0 M",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            color: Color(0xFF979C9E),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text(
                        "=",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            color: Color(0xFF979C9E),
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Container(
                    width: 44,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF979C9E)),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                      child: Text(
                        "2 H",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            color: Color(0xFF979C9E),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Container(
                    width: 44,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF979C9E)),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                      child: Text(
                        "0 M",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            color: Color(0xFF979C9E),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Break Time (H)  : ",
                    style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                  Container(
                    width: 150,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF979C9E)),
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.remove,
                              color: Color(0xFF979C9E),
                            ),
                          ),
                        ),
                        Text("1"),
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.add,
                              color: Color(0xFF20519F),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Container(
                    width: 115,
                    child: Text(
                      "Line Stop",
                      style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Text(
                    ":",
                    style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 44,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF979C9E)),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                      child: Text(
                        "1 H",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            color: Color(0xFF979C9E),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Container(
                    width: 44,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF979C9E)),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                      child: Text(
                        "0 M",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            color: Color(0xFF979C9E),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text(
                        "+",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            color: Color(0xFF979C9E),
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Container(
                    width: 44,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF979C9E)),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                      child: Text(
                        "1 H",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            color: Color(0xFF979C9E),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Container(
                    width: 44,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF979C9E)),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                      child: Text(
                        "0 M",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            color: Color(0xFF979C9E),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text(
                        "=",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            color: Color(0xFF979C9E),
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Container(
                    width: 44,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF979C9E)),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                      child: Text(
                        "2 H",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            color: Color(0xFF979C9E),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Container(
                    width: 44,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF979C9E)),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                      child: Text(
                        "0 M",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            color: Color(0xFF979C9E),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 24),
              width: MediaQuery.of(context).size.width,
              child: Text(
                "Cost",
                style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: Text(
                "In-House M/P Cost (Rp)",
                style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 44,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF979C9E)),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                      child: Text(
                        "2 H",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 14,
                            color: Color(0xFF979C9E),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text(
                        "X",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            color: Color(0xFF979C9E),
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Container(
                    width: 50,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF979C9E)),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                      child: Text(
                        "1 M/P",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 14,
                            color: Color(0xFF979C9E),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text(
                        "X",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            color: Color(0xFF979C9E),
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Container(
                    width: 67,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF979C9E)),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                      child: Text(
                        "60.000",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 14,
                            color: Color(0xFF979C9E),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text(
                        "+",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            color: Color(0xFF979C9E),
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Container(
                    width: 67,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF979C9E)),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                      child: Text(
                        "30.000",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 14,
                            color: Color(0xFF979C9E),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4),
              width: MediaQuery.of(context).size.width,
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF979C9E)),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Center(
                child: Text(
                  "Total = Rp. 0.0",
                  style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 16,
                      color: Color(0xFF404446),
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: Text(
                "Out-House (Rp)",
                style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 44,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF979C9E)),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                      child: Text(
                        "0 H",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 14,
                            color: Color(0xFF979C9E),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text(
                        "X",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            color: Color(0xFF979C9E),
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Container(
                    width: 50,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF979C9E)),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                      child: Text(
                        "0 M/P",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 14,
                            color: Color(0xFF979C9E),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text(
                        "X",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            color: Color(0xFF979C9E),
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Container(
                    width: 67,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF979C9E)),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                      child: Text(
                        "0/H",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 14,
                            color: Color(0xFF979C9E),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4),
              width: MediaQuery.of(context).size.width,
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF979C9E)),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Center(
                child: Text(
                  "Total = Rp. 0.0",
                  style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 16,
                      color: Color(0xFF404446),
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
