// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';

class AddItemFillTujuh extends StatefulWidget {
  const AddItemFillTujuh({Key? key}) : super(key: key);

  @override
  _AddItemFillTujuhState createState() => _AddItemFillTujuhState();
}

class _AddItemFillTujuhState extends State<AddItemFillTujuh> {
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
        padding: const EdgeInsets.only(left: 16, right: 16),
        height: MediaQuery.of(context).size.height,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 16,
                          ),
                          // ignore: prefer_const_literals_to_create_immutables
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Part Name',
                                style: TextStyle(color: Color(0xFF404446))),
                            TextSpan(
                                text: ' * ',
                                style: TextStyle(color: Colors.red)),
                            TextSpan(
                                text: ':',
                                style: TextStyle(color: Color(0xFF404446))),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFF979C9E)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                      child: TextFormField(
                        style: const TextStyle(
                            fontFamily: 'Rubik',
                            color: Color(0xFF979C9E),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal),
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(top: 10, left: 10),
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            hintText: 'Type Item Name'),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 16,
                              ),
                              // ignore: prefer_const_literals_to_create_immutables
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Quantity (Used)',
                                    style: TextStyle(color: Color(0xFF404446))),
                                TextSpan(
                                    text: ' * ',
                                    style: TextStyle(color: Colors.red)),
                                TextSpan(
                                    text: ':',
                                    style: TextStyle(color: Color(0xFF404446))),
                              ],
                            ),
                          ),
                          Container(
                            width: 110,
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFF979C9E)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            child: Row(
                              // ignore: prefer_const_literals_to_create_immutables
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: Icon(
                                    Icons.remove,
                                    color: Color(0xFF979C9E),
                                  ),
                                ),
                                Text("1",
                                    style: TextStyle(
                                        color: Color(0xFF404446),
                                        fontFamily: 'Rubik',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700)),
                                SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: Icon(
                                    Icons.add,
                                    color: Color(0xFF20519F),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 16,
                              ),
                              // ignore: prefer_const_literals_to_create_immutables
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Quantity (Stock)',
                                    style: TextStyle(color: Color(0xFF404446))),
                                TextSpan(
                                    text: ' * ',
                                    style: TextStyle(color: Colors.red)),
                                TextSpan(
                                    text: ':',
                                    style: TextStyle(color: Color(0xFF404446))),
                              ],
                            ),
                          ),
                          Container(
                            width: 110,
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFF979C9E)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            child: Row(
                              // ignore: prefer_const_literals_to_create_immutables
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: Icon(
                                    Icons.remove,
                                    color: Color(0xFF979C9E),
                                  ),
                                ),
                                Text("1",
                                    style: TextStyle(
                                        color: Color(0xFF404446),
                                        fontFamily: 'Rubik',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700)),
                                SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: Icon(
                                    Icons.add,
                                    color: Color(0xFF20519F),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 16,
                          ),
                          // ignore: prefer_const_literals_to_create_immutables
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Cost (Rp)',
                                style: TextStyle(color: Color(0xFF404446))),
                            TextSpan(
                                text: ' * ',
                                style: TextStyle(color: Colors.red)),
                            TextSpan(
                                text: ':',
                                style: TextStyle(color: Color(0xFF404446))),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFF979C9E)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                      child: TextFormField(
                        style: const TextStyle(
                            fontFamily: 'Rubik',
                            color: Color(0xFF979C9E),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal),
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(top: 10, left: 10),
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            hintText: 'Type Item Name'),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Color(0xFFCDCFD0)))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Sub Total (Rp) :", style: TextStyle(fontFamily: 'Rubik', fontSize: 16, fontWeight: FontWeight.w700),),
                          Text("0.00", style: TextStyle(fontFamily: 'Rubik', fontSize: 16, fontWeight: FontWeight.w400),),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xFF979C9E),
                        borderRadius: BorderRadius.all(Radius.circular(5))
                      ),
                      child: Center(child: Text("Save Spare part", style: TextStyle(fontFamily: 'Rubik', color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),),),
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
