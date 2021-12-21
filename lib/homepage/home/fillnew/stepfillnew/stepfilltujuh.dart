// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, avoid_unnecessary_containers, curly_braces_in_flow_control_structures
import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:e_cm/homepage/home/fillnew/additionpage/add_item_step7.dart';
import 'package:e_cm/homepage/home/model/partitemmachinesavedmodel.dart';
import 'package:e_cm/homepage/home/services/PartItemMachineSaveService.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StepFillTujuh extends StatefulWidget {
  const StepFillTujuh({Key? key}) : super(key: key);

  @override
  _StepFillTujuhState createState() => _StepFillTujuhState();
}

class _StepFillTujuhState extends State<StepFillTujuh> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  StreamController streamController = StreamController();
  late Timer _timer;
  String bahasa = "Bahasa Indonesia";
  bool bahasaSelected = false;

  String sparepart = "";
  String no_sparepart = "";
  String add_item = "";
  String part_name = "";
  String type_name = "";
  String quantity_used = "";
  String quantity_stock = "";
  String cost = "";
  String type_cost = "";
  String subtotal = "";
  String save_sparepart = "";
  String cost_ = "";
  String total_cost = "";
  String back = "";
  String next_eight = "";

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
        sparepart = dataLang['step_7']['sparepart'];
        no_sparepart = dataLang['step_7']['no_sparepart'];
        add_item = dataLang['step_7']['add_item'];
        part_name = dataLang['step_7']['part_name'];
        type_name = dataLang['step_7']['type_name'];
        quantity_used = dataLang['step_7']['quantity_used'];
        quantity_stock = dataLang['step_7']['quantity_stock'];
        cost = dataLang['step_7']['cost'];
        total_cost = dataLang['step_7']['total_cost'];
        back = dataLang['step_7']['back'];
        next_eight = dataLang['step_7']['next_eight'];
        subtotal = dataLang['step_7']['subtotal'];
        save_sparepart = dataLang['step_7']['save_sparepart'];
        cost_ = dataLang['step_7']['cost_'];
        type_cost = dataLang['step_7']['type_cost'];
      });
    }
  }

  void getLanguageId() async {
    var response = await rootBundle.loadString("assets/lang/lang-id.json");
    var dataLang = json.decode(response)['data'];

    if (mounted) {
      setState(() {
        sparepart = dataLang['step_7']['sparepart'];
        no_sparepart = dataLang['step_7']['no_sparepart'];
        add_item = dataLang['step_7']['add_item'];
        part_name = dataLang['step_7']['part_name'];
        type_name = dataLang['step_7']['type_name'];
        quantity_used = dataLang['step_7']['quantity_used'];
        quantity_stock = dataLang['step_7']['quantity_stock'];
        cost = dataLang['step_7']['cost'];
        total_cost = dataLang['step_7']['total_cost'];
        back = dataLang['step_7']['back'];
        next_eight = dataLang['step_7']['next_eight'];
        subtotal = dataLang['step_7']['subtotal'];
        save_sparepart = dataLang['step_7']['save_sparepart'];
        cost_ = dataLang['step_7']['cost_'];
        type_cost = dataLang['step_7']['type_cost'];
      });
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

  List<PartItemMachineSavedModel> _listDataPartSaved = [];

  Future<List<PartItemMachineSavedModel>> getDataPartItemSaved() async {
    final prefs = await _prefs;
    String tokenUser = prefs.getString("tokenKey").toString();
    String? idEcmKey = prefs.getString("idEcm") ?? "";

    _listDataPartSaved = await partItemMachineSaveService
        .getPartItemMachineSaveData(tokenUser, idEcmKey);
    print("total data: $idEcmKey");

    streamController.add(_listDataPartSaved);

    return await partItemMachineSaveService.getPartItemMachineSaveData(
        tokenUser, idEcmKey);
  }

  void deletePartMachineSaved(String idEcmData) async {
    // print(idEcmData);
    final prefs = await _prefs;
    String tokenUser = prefs.getString("tokenKey").toString();

    // var idPart = prefs.getString("idPartItemMachine");
    print("id data: $idEcmData");

    var result = await partItemMachineSaveService.deletePartItemMachineSaved(
        idEcmData, tokenUser);

    print(result);

    // getDataPartItemSaved();

    Fluttertoast.showToast(
        msg: 'Item dihapus',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.greenAccent,
        textColor: Colors.white,
        fontSize: 16);
  }

  void confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.topRight,
                child: Image.asset(
                  "assets/icons/X.png",
                  width: 20,
                ),
              ),
            ),
            Container(
              child: Center(
                  child: Image.asset(
                "assets/icons/Sign.png",
                width: 100,
              )),
            ),
            Container(
              margin: EdgeInsets.only(top: 8),
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  "Confirm",
                  style: TextStyle(
                      color: Color(0xFF404446),
                      fontFamily: 'Rubik',
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8, left: 16, right: 16),
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  "Are you sure want to delete item?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xFF404446),
                      fontFamily: 'Rubik',
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, left: 16, right: 16),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: 115,
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFF00AEDB)),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Center(
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                              color: Color(0xFF00AEDB),
                              fontFamily: 'Rubik',
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 14,
                  ),
                  InkWell(
                    onTap: () async {
                      deletePartMachineSaved(
                          _listDataPartSaved[index].ecmPartId);
                      Navigator.pop(context);
                    },
                    child: Container(
                        width: 115,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Color(0xFFEB3434),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Center(
                          child: Text(
                            "Delete",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Rubik',
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        )),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  @override
  void initState() {
    getDataPartItemSaved();
    // addItemStep7Finish();
    _timer =
        Timer.periodic(Duration(seconds: 3), (timer) => getDataPartItemSaved());
    print("tes step 7");
    setBahasa();
    setLang();
    super.initState();
  }

  @override
  void dispose() {
    //cancel the timer
    if (_timer.isActive) _timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Text(sparepart,
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  )),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder(
                stream: streamController.stream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Center(
                            child: Text("Loading spare part...",
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  color: Color(0xFF00AEDB),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                )),
                          ),
                        ],
                      ),
                    );
                  }

                  return _listDataPartSaved.isEmpty
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/images/empty.png",
                                width: 250,
                              ),
                              Center(
                                child: Text(no_sparepart,
                                    style: TextStyle(
                                      fontFamily: 'Rubik',
                                      color: Color(0xFF00AEDB),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                    )),
                              ),
                            ],
                          ),
                        )
                      : Container(
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _listDataPartSaved.length,
                            itemBuilder: (context, i) {
                              print(_listDataPartSaved[i].ecmPartId);
                              return Container(
                                padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                                width: MediaQuery.of(context).size.width,
                                margin:
                                    const EdgeInsets.only(top: 8, bottom: 8),
                                decoration: BoxDecoration(
                                  color: Color(0xFF00AEDB),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                ),
                                child: Column(
                                  // ignore: prefer_const_literals_to_create_immutables
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(_listDataPartSaved[i].partItemNama,
                                        style: TextStyle(
                                          fontFamily: 'Rubik',
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Text(
                                              "$cost_ ${_listDataPartSaved[i].totalHarga}",
                                              style: TextStyle(
                                                fontFamily: 'Rubik',
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                              )),
                                        ),
                                        Container(
                                          width: 60,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              AddItemFillTujuh(
                                                                isFromUpdate:
                                                                    true,
                                                                partIdEcm:
                                                                    _listDataPartSaved[
                                                                            i]
                                                                        .ecmPartId,
                                                              )));
                                                },
                                                child: Image.asset(
                                                  "assets/icons/akar-icons_edit.png",
                                                  width: 20,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  confirmDelete(i);
                                                },
                                                child: Image.asset(
                                                  "assets/icons/trash.png",
                                                  width: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                },
              ),
            ),
            InkWell(
              onTap: _listDataPartSaved.length == 7
                  ? () {
                      Fluttertoast.showToast(
                          msg: 'Item sudah maksimal 7',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.greenAccent,
                          textColor: Colors.white,
                          fontSize: 16);
                    }
                  : () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AddItemFillTujuh(
                                isFromUpdate: false,
                              )));
                    },
              child: Container(
                margin: EdgeInsets.only(top: 50),
                width: MediaQuery.of(context).size.width,
                height: 40,
                decoration: BoxDecoration(
                    color: Color(0xFF00AEDB),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Icon(
                        Icons.add_circle_outline,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text(
                        add_item,
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            color: Colors.white,
                            fontSize: 12,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
