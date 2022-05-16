// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:e_cm/homepage/home/component/function_header_stepper.dart';
import 'package:e_cm/homepage/home/component/widget_fill_new.dart';
import 'package:e_cm/homepage/home/component/widget_line_stepper.dart';
import 'package:e_cm/homepage/home/fillnew/stepfillnew/stepfillempat.dart';
import 'package:e_cm/homepage/home/services/apifillnewtiga.dart';
import 'package:e_cm/util/shared_prefs_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../fillnew.dart';

class StepFillTiga extends StatefulWidget {
  final _StepFillTigaState stepFillTigaState = _StepFillTigaState();

  StepFillTiga({Key? key}) : super(key: key);

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

  String ecmId = SharedPrefsUtil.getEcmId();

  String ecmIdEdit = SharedPrefsUtil.getEcmIdEdit();
  String tokenUser = SharedPrefsUtil.getTokenUser();

  String why_analysis = '';
  String why = '';
  String how = '';
  String type_message = '';
  String optional = '';

  String bahasa = "Bahasa Indonesia";

  bool _customTileExpanded = false;

  bool bahasaSelected = false;

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

        optional = dataLang['step_3']['optional'];
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

      optional = dataLang['step_3']['optional'];
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

  void saveStepFillTiga() async {
    // print("why1");
    // print(why2);

    try {
      if (why1Controller.text.isNotEmpty && why2Controller.text.isNotEmpty) {
        var result = await fillNewTiga(
            why1Controller.text,
            why2Controller.text,
            why3Controller.text.isNotEmpty ? why3Controller.text : "-",
            why4Controller.text.isNotEmpty ? why4Controller.text : "-",
            howController.text.isNotEmpty ? howController.text : "-",
            "",
            ecmId == "" || ecmId.isEmpty ? ecmIdEdit : ecmId,
            tokenUser);
        print(result);

        if (result['response']['status'] == 200) {
          Fluttertoast.showToast(
              msg: 'Data step 3 Disimpan',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.greenAccent,
              textColor: Colors.white,
              fontSize: 16);

          // isStepTigaFill = false;
          // isStepEmpatFill = true;
          Get.to(StepFillEmpat());
        } else {
          Fluttertoast.showToast(
              msg: 'Terjadi kesalahan, Data gagal disimpan',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.greenAccent,
              textColor: Colors.white,
              fontSize: 16);
        }
      } else {
        Fluttertoast.showToast(
            msg: 'Kolom Why 1 dan Why 2 wajib diisi',
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

  void getStep3DataForEdit() async {
    if ((ecmId.isNotEmpty || ecmId != "") ||
        (ecmIdEdit.isNotEmpty || ecmIdEdit != "")) {
      try {
        var result = await getStepTigaDataForEdit(ecmIdEdit, tokenUser);

        print(result);

        if (result['response']['status'] == 200) {
          var dataStepTiga = result['data'];

          setState(() {
            why1Controller =
                TextEditingController(text: dataStepTiga['t_ecm_why1']);
            why2Controller =
                TextEditingController(text: dataStepTiga['t_ecm_why2']);
            why3Controller =
                TextEditingController(text: dataStepTiga['t_ecm_why3']);
            why4Controller =
                TextEditingController(text: dataStepTiga['t_ecm_why4']);
            howController =
                TextEditingController(text: dataStepTiga['t_ecm_why5']);
          });
        }
      } catch (e) {
        print(e);
      }
    }
  }

  getDataStep3() async {
    final prefs = await _prefs;

    if (prefs.getString("why1") != null) {
      why1Controller.text = prefs.getString("why1").toString();
    }

    if (prefs.getString("why2") != null) {
      why2Controller.text = prefs.getString("why2").toString();
    }
    if (prefs.getString("why3") != null) {
      why3Controller.text = prefs.getString("why3").toString();
    }
    if (prefs.getString("why4") != null) {
      why4Controller.text = prefs.getString("why4").toString();
    }
    if (prefs.getString("howC") != null) {
      howController.text = prefs.getString("howC").toString();
    }
  }

  @override
  void initState() {
    super.initState();
    getStep3DataForEdit();
    setLang();
    setBahasa();
    // getDataStep3();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF00AEDB),
        elevation: 1,
        title: Text(
          "E-CM Card",
          style: TextStyle(
              fontFamily: 'Rubik',
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () async {
              await confirmBackToHome(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  showCustomDialog(context);
                });
              },
              icon: Icon(
                Icons.info_outline,
                color: Colors.white,
              ))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StepperNumber(
                      numberStep: "1",
                      isFilled: false,
                    ),
                    LineStepper(),
                    StepperNumber(
                      numberStep: "2",
                      isFilled: false,
                    ),
                    LineStepper(),
                    StepperNumber(
                      numberStep: "3",
                      isFilled: true,
                    ),
                    LineStepper(),
                    StepperNumber(
                      numberStep: "4",
                      isFilled: false,
                    ),
                    LineStepper(),
                    StepperNumber(
                      numberStep: "5",
                      isFilled: false,
                    ),
                    LineStepper(),
                    StepperNumber(
                      numberStep: "6",
                      isFilled: false,
                    ),
                    LineStepper(),
                    StepperNumber(
                      numberStep: "7",
                      isFilled: false,
                    ),
                    LineStepper(),
                    StepperNumber(
                      numberStep: "8",
                      isFilled: false,
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: RichText(
                  text: TextSpan(
                    text: why_analysis,
                    style: TextStyle(
                        fontFamily: 'Rubik',
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                    children: const <TextSpan>[],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10, top: 10),
                    child: RichText(
                      text: TextSpan(
                        text: why,
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            color: Colors.black,
                            fontSize: 14,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10, top: 10),
                    child: RichText(
                      text: TextSpan(
                        text: 'Why 2',
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            color: Colors.black,
                            fontSize: 14,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10, top: 10),
                    child: RichText(
                      text: TextSpan(
                        text: 'Why 3 ($optional)',
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  TextFormField(
                    maxLength: 500,
                    controller: why3Controller,
                    onChanged: (value) async {
                      final prefs = await _prefs;
                      setState(() {
                        prefs.setString("why3", value);
                        prefs.setString("whyBool3", "0");
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10, top: 10),
                    child: Text(
                      'Why 4 ($optional)',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Rubik',
                          fontSize: 14),
                    ),
                  ),
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
              Container(
                width: MediaQuery.of(context).size.width,
                child: RichText(
                  text: TextSpan(
                    text: "Why 5 ($optional)",
                    style: TextStyle(
                        fontFamily: 'Rubik',
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
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
                        // prefs.setString("howBool", "0");
                      });
                    },
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                        filled: true,
                        hintText: type_message),
                    maxLines: 5,
                  )),
              Container(
                margin: EdgeInsets.only(top: 26),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        // isStepDuaFill = true;
                        // isStepTigaFill = false;
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: Color(0xFF00AEDB))),
                        child: Center(
                          child: Text(
                            "Kembali",
                            style: TextStyle(
                                fontFamily: 'Rubik',
                                color: Color(0xFF00AEDB),
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => saveStepFillTiga(),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Color(0xFF00AEDB)),
                        child: Center(
                          child: Text("Lanjut 4/8",
                              style: TextStyle(
                                  fontFamily: 'Rubik',
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400)),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
