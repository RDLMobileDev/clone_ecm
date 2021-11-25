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
  bool _customTileExpanded = false;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final TextEditingController tecWhy1 = TextEditingController();
  final TextEditingController tecWhy2 = TextEditingController();
  final TextEditingController tecWhy3 = TextEditingController();
  final TextEditingController tecWhy4 = TextEditingController();
  final TextEditingController tecHow = TextEditingController();

  void saveStepFillTiga() async {
    // final SharedPreferences prefs = await _prefs;
    // String why1 = tecWhy1.text;
    // String why2 = tecWhy2.text;
    // String why3 = tecWhy3.text;
    // String why4 = tecWhy4.text;
    // String how = tecHow.text;
    // String? ecmId = prefs.getString("ecm_id");
    // String? token = prefs.getString("tokenKey");
    //
    // try {
    //   var messageResult = "loading";
    //   var rspStep = await fillNewTiga(
    //       why1, why2, why3, why4, "", how, ecmId ?? "", token ?? "");
    //
    //   switch (rspStep['response']['status']) {
    //     case 200:
    //       messageResult = "Step 3 sukses";
    //       break;
    //     default:
    //       messageResult = "Step 3 gagal";
    //       break;
    //   }
    //
    //   Fluttertoast.showToast(
    //       msg: messageResult,
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.BOTTOM,
    //       timeInSecForIosWeb: 2,
    //       backgroundColor: Colors.greenAccent,
    //       textColor: Colors.white,
    //       fontSize: 16);
    // } catch (e) {
    //   print(e);
    //   Fluttertoast.showToast(
    //       msg: "Terjadi kesalahan, silahkan dicoba lagi nanti",
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.BOTTOM,
    //       timeInSecForIosWeb: 2,
    //       backgroundColor: Colors.greenAccent,
    //       textColor: Colors.white,
    //       fontSize: 16);
    // }

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
                controller: tecWhy1,
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
                controller: tecWhy2,
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
                controller: tecWhy3,
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
    );
  }
}
