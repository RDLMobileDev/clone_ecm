// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:e_cm/homepage/home/services/apifillnewtiga.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  String bahasa = "Bahasa Indonesia";
  bool bahasaSelected = false;

  String why_analysis = '';
  String why = '';
  String how = '';
  String type_message = '';

  void setBahasa() async {
    final prefs = await _prefs;
    String bahasaBool = prefs.getString("bahasa") ?? "";

    if (bahasaBool.isNotEmpty && bahasaBool == "Bahasa Indonesia") {
      setState(() {
        bahasaSelected = false;
        bahasa = bahasaBool;
      });
    } else if (bahasaBool.isNotEmpty && bahasaBool == "English") {
      setState(() {
        bahasaSelected = true;
        bahasa = bahasaBool;
      });
    } else {
      setState(() {
        bahasaSelected = false;
        bahasa = "Bahasa Indonesia";
      });
    }
  }

  void getLanguageEn() async {
    var response = await rootBundle.loadString("assets/lang/lang-en.json");
    var dataLang = json.decode(response)['data'];
    if (mounted) {
      setState(() {
        why_analysis = dataLang['step_3']['why_analysis'];
        why = dataLang['step_3']['why'];
        how = dataLang['step_3']['how'];
        type_message = dataLang['step_3']['type_message'];
      });
    }
  }

  void getLanguageId() async {
    var response = await rootBundle.loadString("assets/lang/lang-id.json");
    var dataLang = json.decode(response)['data'];

    if (mounted) {
      setState(() {});
      why_analysis = dataLang['step_3']['why_analysis'];
      why = dataLang['step_3']['why'];
      how = dataLang['step_3']['how'];
      type_message = dataLang['step_3']['type_message'];
    }
  }

  void setLang() async {
    final prefs = await _prefs;
    var langSetting = prefs.getString("bahasa") ?? "";
    print(langSetting);

    if (langSetting.isNotEmpty && langSetting == "Bahasa Indonesia") {
      getLanguageId();
    } else if (langSetting.isNotEmpty && langSetting == "English") {
      getLanguageEn();
    } else {
      getLanguageId();
    }
  }

  GlobalKey<FormState> formKeyStep3 = GlobalKey();

  TextEditingController why1Controller = TextEditingController();
  TextEditingController why2Controller = TextEditingController();
  TextEditingController why3Controller = TextEditingController();
  TextEditingController why4Controller = TextEditingController();
  TextEditingController howController = TextEditingController();

  bool _customTileExpanded = false;

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

    try {
      if (why1.isNotEmpty &&
          why2.isNotEmpty &&
          why3.isNotEmpty &&
          how.isNotEmpty) {
        var result = await fillNewTiga(
            why1, why2, why3, why4, why5, how, ecmId, tokenUser);
        print(result);

        Fluttertoast.showToast(
            msg: 'Data step 3 Disimpan',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.white,
            fontSize: 16);
      } else {
        Fluttertoast.showToast(
            msg: 'Data tidak disimpan, cek semua input field',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.white,
            fontSize: 16);
      }
    } on SocketException catch (e) {
      print(e);
    } on TimeoutException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  void setFormStep3AfterChoosing() async {
    final prefs = await _prefs;

    String? why1 = prefs.getString("why1");
    String? why2 = prefs.getString("why2");
    String? why3 = prefs.getString("why3");
    String? why4 = prefs.getString("why4");
    String? howC = prefs.getString("howC");

    if (why1 != null && why2 != null && why3 != null && howC != null) {
      why1Controller = TextEditingController(text: why1);
      why2Controller = TextEditingController(text: why2);
      why3Controller = TextEditingController(text: why3);
      why4Controller = TextEditingController(text: why4);
      howController = TextEditingController(text: howC);
    }
  }

  @override
  void initState() {
    super.initState();
    setLang();
    setBahasa();
    setFormStep3AfterChoosing();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKeyStep3,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: RichText(
              text: TextSpan(
                text: why_analysis,
                style: TextStyle(
                    fontFamily: 'Rubik',
                    color: Color(0xFF404446),
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                children: const <TextSpan>[
                  TextSpan(
                      text: ' *',
                      style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 14,
                          color: Colors.red,
                          fontWeight: FontWeight.w400)),
                ],
              ),
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
              title: RichText(
                text: TextSpan(
                  text: why,
                  style: TextStyle(
                      fontFamily: 'Rubik',
                      color: Color(0xFFFFFFFF),
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  children: const <TextSpan>[
                    TextSpan(
                        text: ' *',
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 14,
                            color: Colors.red,
                            fontWeight: FontWeight.w400)),
                  ],
                ),
              ),
              children: <Widget>[
                TextFormField(
                  maxLength: 500,
                  controller: why1Controller,
                  onChanged: (value) async {
                    final prefs = await _prefs;
                    setState(() {
                      prefs.setString("why1", value);
                      prefs.setString("whyBool1", "1");
                    });
                  },
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      filled: true,
                      hintText: type_message),
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
              title: RichText(
                text: TextSpan(
                  text: 'Why 2',
                  style: TextStyle(
                      fontFamily: 'Rubik',
                      color: Color(0xFFFFFFFF),
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  children: const <TextSpan>[
                    TextSpan(
                        text: ' *',
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 14,
                            color: Colors.red,
                            fontWeight: FontWeight.w400)),
                  ],
                ),
              ),
              children: <Widget>[
                TextFormField(
                  maxLength: 500,
                  onChanged: (value) async {
                    final prefs = await _prefs;
                    setState(() {
                      prefs.setString("why2", value);
                      prefs.setString("whyBool2", "1");
                    });
                  },
                  controller: why2Controller,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      filled: true,
                      hintText: type_message),
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
              title: RichText(
                text: TextSpan(
                  text: 'Why 3 (Optional)',
                  style: TextStyle(
                      fontFamily: 'Rubik',
                      color: Color(0xFFFFFFFF),
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              ),
              children: <Widget>[
                TextFormField(
                  maxLength: 500,
                  controller: why3Controller,
                  onChanged: (value) async {
                    final prefs = await _prefs;
                    setState(() {
                      prefs.setString("why3", value);
                      prefs.setString("whyBool3", "1");
                    });
                  },
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      filled: true,
                      hintText: type_message),
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
                  maxLength: 500,
                  controller: why4Controller,
                  onChanged: (value) async {
                    final prefs = await _prefs;
                    setState(() {
                      prefs.setString("why4", value);
                    });
                  },
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      filled: true,
                      hintText: type_message),
                  maxLines: 5,
                )
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: RichText(
              text: TextSpan(
                text: how,
                style: TextStyle(
                    fontFamily: 'Rubik',
                    color: Color(0xFF404446),
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                children: const <TextSpan>[
                  TextSpan(
                      text: ' *',
                      style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 14,
                          color: Colors.red,
                          fontWeight: FontWeight.w400)),
                ],
              ),
            ),
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 10),
              child: TextFormField(
                maxLength: 500,
                controller: howController,
                onChanged: (value) async {
                  final prefs = await _prefs;
                  setState(() {
                    prefs.setString("howC", value);
                    prefs.setString("howBool", "1");
                  });
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    hintText: type_message),
                maxLines: 3,
              ))
        ],
      ),
    );
  }
}
