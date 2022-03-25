// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:e_cm/homepage/home/fillnew/additionpage/formstepfilllima.dart';
import 'package:e_cm/homepage/home/fillnew/fillnew.dart';
import 'package:e_cm/homepage/home/model/item_checking.dart';
import 'package:e_cm/homepage/home/services/api_fill_new_lima_get.dart';
import 'package:e_cm/homepage/home/services/apideletefillnewlima.dart';
import 'package:e_cm/homepage/home/services/apifillnewlimadelete.dart';
import 'package:e_cm/util/shared_prefs_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StepFillLima extends StatefulWidget {
  const StepFillLima({Key? key}) : super(key: key);

  @override
  _StepFillLimaState createState() => _StepFillLimaState();
}

class _StepFillLimaState extends State<StepFillLima> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  String token = SharedPrefsUtil.getTokenUser();
  String ecmId = SharedPrefsUtil.getEcmId();
  String ecmIdEdit = SharedPrefsUtil.getEcmIdEdit();
  String userId = SharedPrefsUtil.getIdUser();

  String bahasa = "Bahasa Indonesia";

  String item_repairing = '';
  String validation_repair = '';
  String add_item = '';
  String item_repair = '';
  String type_name_item = '';
  String note = '';
  String ok = '';
  String limit = '';

  String ng = '';
  String starttime = '';
  String hm = '';
  String end_time = '';
  String name = '';
  String type_name = '';

  String repair_made = '';
  String type_message = '';
  String save_repair = '';
  String repair_time = '';
  String total_repair = '';
  String back = '';
  String confirm = '';
  String delete = '';
  String validation_delete = '';
  String cancel = '';

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
        item_repair = dataLang['step_5']['item_repair'];
        validation_repair = dataLang['step_5']['validation_repair'];
        add_item = dataLang['step_5']['add_item'];
        item_repairing = dataLang['step_5']['item_repairing'];
        type_name_item = dataLang['step_5']['type_name_item'];

        note = dataLang['step_5']['note'];
        ok = dataLang['step_5']['ok'];
        limit = dataLang['step_5']['limit'];
        ng = dataLang['step_5']['ng'];
        starttime = dataLang['step_5']['starttime'];
        hm = dataLang['step_5']['hm'];
        end_time = dataLang['step_5']['end_time'];
        name = dataLang['step_5']['name'];
        type_name = dataLang['step_5']['type_name'];

        repair_made = dataLang['step_5']['repair_made'];
        type_message = dataLang['step_5']['type_message'];
        save_repair = dataLang['step_5']['save_repair'];
        repair_time = dataLang['step_5']['repair_time'];
        total_repair = dataLang['step_5']['total_repair'];

        back = dataLang['step_5']['back'];
        confirm = dataLang['step_5']['confirm'];
        validation_delete = dataLang['step_5']['validation_delete'];
        cancel = dataLang['step_5']['cancel'];
        delete = dataLang['step_5']['delete'];
      });
    }
  }

  void getLanguageId() async {
    var response = await rootBundle.loadString("assets/lang/lang-id.json");
    var dataLang = json.decode(response)['data'];

    if (mounted) {
      setState(() {});
      item_repair = dataLang['step_5']['item_repair'];
      validation_repair = dataLang['step_5']['validation_repair'];
      add_item = dataLang['step_5']['add_item'];
      item_repairing = dataLang['step_5']['item_repairing'];
      type_name_item = dataLang['step_5']['type_name_item'];

      note = dataLang['step_5']['note'];
      ok = dataLang['step_5']['ok'];
      limit = dataLang['step_5']['limit'];
      ng = dataLang['step_5']['ng'];
      starttime = dataLang['step_5']['starttime'];
      hm = dataLang['step_5']['hm'];
      end_time = dataLang['step_5']['end_time'];
      name = dataLang['step_5']['name'];
      type_name = dataLang['step_5']['type_name'];

      repair_made = dataLang['step_5']['repair_made'];
      type_message = dataLang['step_5']['type_message'];
      save_repair = dataLang['step_5']['save_repair'];
      repair_time = dataLang['step_5']['repair_time'];
      total_repair = dataLang['step_5']['total_repair'];

      back = dataLang['step_5']['back'];
      confirm = dataLang['step_5']['confirm'];
      validation_delete = dataLang['step_5']['validation_delete'];
      cancel = dataLang['step_5']['cancel'];
      delete = dataLang['step_5']['delete'];
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

  List<ItemChecking> _listItemChecking = <ItemChecking>[];

  void getDataItemRepairing() async {
    try {
      var data = await getFillNewLima(
          ecmId.isEmpty || ecmId == "" ? ecmIdEdit : ecmId, userId, token);
      print("data step 5");
      print(data);

      switch (data["response"]['status']) {
        case 200:
          setState(() {
            _listItemChecking = (data['data'] as List)
                .map((e) => ItemChecking.fromJson(e))
                .toList();
          });
          break;
        default:
          setState(() {
            _listItemChecking = [];
          });
          break;
      }
    } catch (e) {
      String exceptionMessage = "Terjadi kesalahan, silahkan dicoba lagi nanti";
      if (e is SocketException) {
        exceptionMessage = "Kesalahan jaringan, silahkan cek koneksi anda";
      }

      if (e is TimeoutException) {
        exceptionMessage = "Jaringan buruk, silahkan cari koneksi yang stabil";
      }

      // Fluttertoast.showToast(
      //     msg: exceptionMessage,
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     timeInSecForIosWeb: 2,
      //     backgroundColor: Colors.greenAccent,
      //     textColor: Colors.white,
      //     fontSize: 16);
    }
  }

  void confirmDelete(String ecmItemId) {
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
                    confirm,
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
                    validation_delete,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () async {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: 40,
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFF00AEDB)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Center(
                            child: Text(
                              cancel,
                              style: TextStyle(
                                  color: Color(0xFF00AEDB),
                                  fontFamily: 'Rubik',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          )),
                    ),
                    InkWell(
                      onTap: () {
                        hapusItemStepLima(ecmItemId).then((value) {
                          if (value['response']['status'] != 200) {
                            Fluttertoast.showToast(
                                msg: 'Item gagal dihapus',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.greenAccent,
                                textColor: Colors.white,
                                fontSize: 16);
                          }
                          Navigator.of(context).pop(true);
                          getDataItemRepairing();
                        });
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Color(0xFFEB3434),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Center(
                            child: Text(
                              delete,
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
        });
  }

  Future hapusItemStepLima(String ecmItemId) async {
    // final prefs = await SharedPreferences.getInstance();
    // String token = prefs.getString("tokenKey").toString();

    var result = await deleteFillLima.hapusItemFillLima(token, ecmItemId);

    return result;
  }

  @override
  void initState() {
    super.initState();
    getDataItemRepairing();
    setLang();
    setBahasa();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.58,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: RichText(
                text: TextSpan(
                  text: item_repairing,
                  style: TextStyle(
                      fontFamily: 'Rubik',
                      color: Color(0xFF404446),
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                  children: const <TextSpan>[
                    TextSpan(
                        text: ' *',
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 16,
                            color: Colors.red,
                            fontWeight: FontWeight.w400)),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: _listItemChecking.isEmpty
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/images/repair.png",
                            width: 250,
                          ),
                          Center(
                            child: Text(validation_repair,
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
                        itemCount: _listItemChecking.length,
                        itemBuilder: (context, i) {
                          return Container(
                            padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                            margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Color(0xFF00AEDB),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Column(
                              // ignore: prefer_const_literals_to_create_immutables
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_listItemChecking[i].partNama ?? "-",
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
                                          "$repair_time ${_listItemChecking[i].waktuJam}H : ${_listItemChecking[i].waktuMenit}M",
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
                                            onTap: () async {
                                              final result =
                                                  await Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                          builder: (context) =>
                                                              FormStepFilllima(
                                                                idEcmItem:
                                                                    _listItemChecking[
                                                                            i]
                                                                        .ecmitemId
                                                                        .toString(),
                                                                isUpdate: true,
                                                              )));
                                            },
                                            child: Image.asset(
                                              "assets/icons/akar-icons_edit.png",
                                              width: 20,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              confirmDelete(_listItemChecking[i]
                                                  .ecmitemId
                                                  .toString());
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
                    ),
            ),
            InkWell(
              onTap: _listItemChecking.length == 6
                  ? () {
                      Fluttertoast.showToast(
                          msg: 'Item sudah maksimal 6',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.greenAccent,
                          textColor: Colors.white,
                          fontSize: 16);
                    }
                  : () async {
                      final prefs = await _prefs;
                      try {
                        bool isInputted =
                            await Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => FormStepFilllima(
                                      isUpdate: false,
                                    )));

                        if (isInputted) {
                          prefs.setString("itemRepairBool", "1");
                          getDataItemRepairing();
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(top: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Color(0xFF00AEDB)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 5),
                      child: Icon(
                        Icons.add_circle_outline,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    Text(
                      add_item,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Rubik',
                          color: Colors.white,
                          fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Divider(
                    color: Color(0xFFCDCFD0),
                    thickness: 2,
                    height: 16,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       'Total Checking Time :',
                  //       style: TextStyle(
                  //         fontFamily: 'Rubik',
                  //         fontWeight: FontWeight.w700,
                  //         fontStyle: FontStyle.normal,
                  //         fontSize: 16,
                  //       ),
                  //     ),
                  //     Text('0 H : 0 M'),
                  //   ],
                  // ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 26),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      isStepEmpatFill.value = true;
                      isStepLimaFill.value = false;
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
                    onTap: () {
                      if (_listItemChecking.isNotEmpty) {
                        isStepLimaFill.value = false;
                        isStepEnamFill.value = true;
                      } else {
                        Fluttertoast.showToast(
                            msg: 'Anda belum menambahkan item',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 2,
                            backgroundColor: Colors.greenAccent,
                            textColor: Colors.white,
                            fontSize: 16);
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Color(0xFF00AEDB)),
                      child: Center(
                        child: Text("Lanjut 6/8",
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
    );
  }
}
