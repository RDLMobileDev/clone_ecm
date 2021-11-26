// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:e_cm/homepage/home/services/apifillnewtiga.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StepFillTiga extends StatefulWidget {
  final _StepFillTigaState stepFillTigaState = _StepFillTigaState();

  void getSaveStepFillTiga() {
    stepFillTigaState.saveStepFillTiga();
  }

  @override
  _StepFillTigaState createState() => _StepFillTigaState();
}

class _StepFillTigaState extends State<StepFillTiga> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  GlobalKey<FormState> formKeyStep3 = GlobalKey();

  TextEditingController why1Controller = TextEditingController();
  TextEditingController why2Controller = TextEditingController();
  TextEditingController why3Controller = TextEditingController();
  TextEditingController why4Controller = TextEditingController();
  TextEditingController howController = TextEditingController();

  bool _customTileExpanded = false;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final TextEditingController tecWhy1 = TextEditingController();
  final TextEditingController tecWhy2 = TextEditingController();
  final TextEditingController tecWhy3 = TextEditingController();
  final TextEditingController tecWhy4 = TextEditingController();
  final TextEditingController tecHow = TextEditingController();

  void saveStepFillTiga() async {
    final prefs = await _prefs;
    var why1 = prefs.getString("why1") ?? "";
    var why2 = prefs.getString("why2") ?? "";
    var why3 = prefs.getString("why3") ?? "";
    var why4 = prefs.getString("why4") ?? "";
    var why5 = "";
    var how = prefs.getString("howC") ?? "";
    var ecmId = prefs.getString("idEcm") ?? "";
    String tokenUser = prefs.getString("tokenKey").toString();

    print(why1);

    var result =
        await fillNewTiga(why1, why2, why3, why4, why5, how, ecmId, tokenUser);
    print(result);

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
    return Form(
      key: formKeyStep3,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              'Why Analysis',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.black, fontSize: 16, fontFamily: 'Rubik'),
            ),
<<<<<<< HEAD
=======
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    filled: true,
                    hintText: 'Type message..'),
                maxLines: 5,
                controller: tecWhy1,
              )
            ],
>>>>>>> origin
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
                  controller: why1Controller,
                  onChanged: (value) async {
                    final prefs = await _prefs;
                    setState(() {
                      prefs.setString("why1", value);
                    });
                  },
                  decoration: const InputDecoration(
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      filled: true,
                      hintText: 'Type message..'),
                  maxLines: 5,
                )
              ],
            ),
<<<<<<< HEAD
=======
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    filled: true,
                    hintText: 'Type message..'),
                maxLines: 5,
                controller: tecWhy2,
              )
            ],
>>>>>>> origin
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
                  onChanged: (value) async {
                    final prefs = await _prefs;
                    setState(() {
                      prefs.setString("why2", value);
                    });
                  },
                  controller: why2Controller,
                  decoration: const InputDecoration(
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      filled: true,
                      hintText: 'Type message..'),
                  maxLines: 5,
                )
              ],
            ),
<<<<<<< HEAD
=======
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    filled: true,
                    hintText: 'Type message..'),
                maxLines: 5,
                controller: tecWhy3,
              )
            ],
>>>>>>> origin
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
                  controller: why3Controller,
                  onChanged: (value) async {
                    final prefs = await _prefs;
                    setState(() {
                      prefs.setString("why3", value);
                    });
                  },
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
                  controller: why4Controller,
                  onChanged: (value) async {
                    final prefs = await _prefs;
                    setState(() {
                      prefs.setString("why4", value);
                    });
                  },
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
                controller: howController,
                onChanged: (value) async {
                  final prefs = await _prefs;
                  setState(() {
                    prefs.setString("howC", value);
                  });
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    hintText: 'Type message..'),
<<<<<<< HEAD
                maxLines: 3,
              ))
        ],
      ),
=======
                maxLines: 5,
                controller: tecWhy4,
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
              controller: tecHow,
            ))
      ],
>>>>>>> origin
    );
  }
}
