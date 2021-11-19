// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';

class FormStepFilllima extends StatefulWidget {
  const FormStepFilllima({ Key? key }) : super(key: key);

  @override
  _FormStepFilllimaState createState() => _FormStepFilllimaState();
}

class _FormStepFilllimaState extends State<FormStepFilllima> {
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
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              // ignore: prefer_const_constructors
              child: Text(
                'Item Name',
                textAlign: TextAlign.left,
                style: const TextStyle(fontSize: 16, fontFamily: 'Rubik'),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 10),
              child: const TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF979C9E)),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    filled: true,
                    hintText: 'Type Item Name'),
                maxLines: 1,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 10),
              child: Text(
                'Note',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16, fontFamily: 'Rubik'),
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 10, right: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.transparent),
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Icon(
                            Icons.circle_outlined,
                            color: Colors.grey,
                            size: 30,
                          ),
                        ),
                        Text(
                          'OK',
                          style: TextStyle(fontSize: 16, fontFamily: 'Rubik'),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, right: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.transparent),
                    // ignore: prefer_const_literals_to_create_immutables
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.change_history_outlined,
                          color: Colors.grey,
                          size: 30,
                        ),
                        Text(
                          'Limit',
                          style: TextStyle(fontSize: 16, fontFamily: 'Rubik'),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.transparent),
                    // ignore: prefer_const_literals_to_create_immutables
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.close,
                          color: Colors.grey,
                          size: 30,
                        ),
                        Text(
                          'N / G',
                          style: TextStyle(fontSize: 16, fontFamily: 'Rubik'),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 10),
              child: Text(
                'Start Time',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16, fontFamily: 'Rubik'),
              ),
            ),
            Container(
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: ExpansionTile(
                tilePadding: EdgeInsets.only(left: 10, right: 5),
                collapsedIconColor: Colors.black,
                collapsedTextColor: Colors.black,
                iconColor: Colors.black,
                leading: Icon(
                  Icons.access_time,
                  color: Colors.grey,
                  size: 30,
                ),
                title: Text(
                  'HH : MM',
                  style: TextStyle(
                      color: Colors.black, fontFamily: 'Rubik', fontSize: 14),
                ),
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                        filled: true,
                        hintText: 'Type message..'),
                    maxLines: 5,
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 10),
              child: Text(
                'End Time',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16, fontFamily: 'Rubik'),
              ),
            ),
            Container(
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: ExpansionTile(
                tilePadding: EdgeInsets.only(left: 10, right: 5),
                collapsedIconColor: Colors.black,
                collapsedTextColor: Colors.black,
                iconColor: Colors.black,
                leading: Icon(
                  Icons.access_time,
                  color: Colors.grey,
                  size: 30,
                ),
                title: Text(
                  'HH : MM',
                  style: TextStyle(
                      color: Colors.black, fontFamily: 'Rubik', fontSize: 14),
                ),
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                        filled: true,
                        hintText: 'Type message..'),
                    maxLines: 5,
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 10),
              child: Text(
                'Name',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16, fontFamily: 'Rubik'),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 10),
              child: TextFormField(
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF979C9E)),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    filled: true,
                    suffixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                      size: 30,
                    ),
                    hintText: 'Type Name'),
                maxLines: 1,
              ),
            ),
            
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 10),
              child: Text(
                'Repair made',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16, fontFamily: 'Rubik'),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: TextFormField(
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Type message...',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF979C9E)),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  )
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.only(top: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.grey),
              child: Text(
                'Save Checking',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Rubik', color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}