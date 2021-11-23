// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class StepFillTiga extends StatefulWidget {
  final _StepFillTigaState stepFillTigaState = _StepFillTigaState();

  void getSaveStepFillTiga() {
    stepFillTigaState.saveStepFillTiga();
  }

  @override
  _StepFillTigaState createState() => _StepFillTigaState();
}

class _StepFillTigaState extends State<StepFillTiga> {
  bool _customTileExpanded = false;

  void saveStepFillTiga() {
    Fluttertoast.showToast(
        msg: 'Data Disimpan',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.greenAccent,
        textColor: Colors.white,
        fontSize: 16);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: Text(
            'Why Analysis',
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontFamily: 'Rubik'),
          ),
        ),
        Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.grey),
          child: ExpansionTile(
            tilePadding: EdgeInsets.only(left: 10, right: 5),
            collapsedIconColor: Colors.white,
            collapsedTextColor: Colors.black,
            title: Text(
              'Why 1',
              style: TextStyle(
                  color: Colors.white, fontFamily: 'Rubik', fontSize: 14),
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
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.grey),
          child: ExpansionTile(
            tilePadding: EdgeInsets.only(left: 10, right: 5),
            collapsedIconColor: Colors.white,
            collapsedTextColor: Colors.black,
            title: Text(
              'Why 2',
              style: TextStyle(
                  color: Colors.white, fontFamily: 'Rubik', fontSize: 14),
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
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.grey),
          child: ExpansionTile(
            tilePadding: EdgeInsets.only(left: 10, right: 5),
            collapsedIconColor: Colors.white,
            collapsedTextColor: Colors.black,
            title: Text(
              'Why 3',
              style: TextStyle(
                  color: Colors.white, fontFamily: 'Rubik', fontSize: 14),
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
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.only(top: 10, bottom: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.grey),
          child: ExpansionTile(
            tilePadding: EdgeInsets.only(left: 10, right: 5),
            collapsedIconColor: Colors.white,
            collapsedTextColor: Colors.black,
            title: Text(
              'Why 4 (Optional)',
              style: TextStyle(
                  color: Colors.white, fontFamily: 'Rubik', fontSize: 14),
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
          child: Text(
            'How',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 16, fontFamily: 'Rubik'),
          ),
        ),
        Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 10),
            child: TextFormField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  hintText: 'Type message..'),
              maxLines: 3,
            ))
      ],
    );
  }
}
