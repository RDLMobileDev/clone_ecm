// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, avoid_unnecessary_containers

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:e_cm/homepage/home/fillnew/additionpage/stepfillempatinput.dart';
import 'package:e_cm/homepage/home/model/item_checking.dart';
import 'package:e_cm/homepage/home/services/apifillnewempatdelete.dart';
import 'package:e_cm/homepage/home/services/apifillnewempatget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StepFillEmpat extends StatefulWidget {
  const StepFillEmpat({Key? key}) : super(key: key);

  @override
  _StepFillEmpatState createState() => _StepFillEmpatState();
}

class _StepFillEmpatState extends State<StepFillEmpat> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  String bahasa = "Bahasa Indonesia";
  bool bahasaSelected = false;

  String item_checking = '';
  String validation_repair = '';
  String add_item = '';
  String item_check = '';
  String type_name = '';

  String standard = '';
  String type_standard = '';
  String actual = '';
  String type_actual = '';
  String note = '';
  String ok = '';
  String limit = '';

  String ng = '';
  String starttime = '';
  String hm = '';
  String end_time = '';
  String name = '';
  String save_checking = '';
  String checking_time = '';
  String total_checking = '';
  String back = '';
  String confirm = '';
  String validation_delete = '';
  String cancel = '';
  String delete = '';
  String validation_checked = '';
  String add_item_ = '';

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
        item_checking = dataLang['step_4']['item_checking'];
        validation_repair = dataLang['step_4']['validation_repair'];
        add_item = dataLang['step_4']['add_item'];
        item_check = dataLang['step_4']['item_check'];
        standard = dataLang['step_4']['standard'];
        type_standard = dataLang['step_4']['type_standard'];
        actual = dataLang['step_4']['actual'];
        type_actual = dataLang['step_4']['type_actual'];
        note = dataLang['step_4']['note'];
        ok = dataLang['step_4']['ok'];

        limit = dataLang['step_4']['limit'];
        ng = dataLang['step_4']['ng'];
        starttime = dataLang['step_4']['starttime'];
        hm = dataLang['step_4']['hm'];
        end_time = dataLang['step_4']['end_time'];
        name = dataLang['step_4']['name'];
        type_name = dataLang['step_4']['type_name'];
        save_checking = dataLang['step_4']['save_checking'];
        checking_time = dataLang['step_4']['checking_time'];

        total_checking = dataLang['step_4']['total_checking'];
        back = dataLang['step_4']['back'];
        confirm = dataLang['step_4']['confirm'];
        validation_delete = dataLang['step_4']['validation_delete'];
        cancel = dataLang['step_4']['cancel'];
        delete = dataLang['step_4']['delete'];
        validation_checked = dataLang['step_4']['validation_checked'];
        add_item_ = dataLang['step_4']['add_item_'];
      });
    }
  }

  void getLanguageId() async {
    var response = await rootBundle.loadString("assets/lang/lang-id.json");
    var dataLang = json.decode(response)['data'];

    if (mounted) {
      setState(() {});
      item_checking = dataLang['step_4']['item_checking'];
      validation_repair = dataLang['step_4']['validation_repair'];
      add_item = dataLang['step_4']['add_item'];
      item_check = dataLang['step_4']['item_check'];
      standard = dataLang['step_4']['standard'];
      type_standard = dataLang['step_4']['type_standard'];
      actual = dataLang['step_4']['actual'];
      type_actual = dataLang['step_4']['type_actual'];
      note = dataLang['step_4']['note'];
      ok = dataLang['step_4']['ok'];

      limit = dataLang['step_4']['limit'];
      ng = dataLang['step_4']['ng'];
      starttime = dataLang['step_4']['starttime'];
      hm = dataLang['step_4']['hm'];
      end_time = dataLang['step_4']['end_time'];
      name = dataLang['step_4']['name'];
      type_name = dataLang['step_4']['type_name'];
      save_checking = dataLang['step_4']['save_checking'];
      checking_time = dataLang['step_4']['checking_time'];

      total_checking = dataLang['step_4']['total_checking'];
      back = dataLang['step_4']['back'];
      confirm = dataLang['step_4']['confirm'];
      validation_delete = dataLang['step_4']['validation_delete'];
      cancel = dataLang['step_4']['cancel'];
      delete = dataLang['step_4']['delete'];
      validation_checked = dataLang['step_4']['validation_checked'];
      add_item_ = dataLang['step_4']['add_item_'];
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

  String data = "Item deleted successfully";

  List<ItemChecking> _listItemChecking = [];
  StreamController step4getController = StreamController();

  Future<List> getDataItemChecking() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("tokenKey").toString();
    String ecmId = prefs.getString("idEcm") ?? "-";
    String userId = prefs.getString("idKeyUser") ?? "-";

    try {
      print("ecm id: $ecmId");
      print("user id: $userId");
      var data = await getFillNewEmpat(ecmId, userId, token);

      print("data from hasil input form step 4");
      print(data['data']);

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

      return _listItemChecking;
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
      return [];
    }
  }

  void deleteItemChecking() async {
    final prefs = await _prefs;
    String tokenUser = prefs.getString("tokenKey").toString();
    var idEcmItem = prefs.getString("idEcmItem");

    var result = await fillNewEmpatDelete(idEcmItem ?? "-", tokenUser);

    try {
      String resultMessage = "Item berhasil dihapus";
      switch (result['response']['status']) {
        case 200:
          getDataItemChecking();
          break;
        default:
          resultMessage = "Item gagal dihapus";
          break;
      }

      Fluttertoast.showToast(
          msg: resultMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.greenAccent,
          textColor: Colors.white,
          fontSize: 16);
      Navigator.pop(context, true);
    } catch (e) {
      String exceptionMessage = "Terjadi kesalahan, silahkan dicoba lagi nanti";
      if (e is SocketException) {
        exceptionMessage = "Kesalahan jaringan, silahkan cek koneksi anda";
      }

      if (e is TimeoutException) {
        exceptionMessage = "Jaringan buruk, silahkan cari koneksi yang stabil";
      }

      Fluttertoast.showToast(
          msg: exceptionMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.greenAccent,
          textColor: Colors.white,
          fontSize: 16);
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
                          cancel,
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
                      deleteItemChecking();
                    },
                    child: Container(
                        width: 115,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Color(0xFFEB3434),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
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
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getDataItemChecking();
    setLang();
    setBahasa();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: RichText(
                text: TextSpan(
                  text: item_checking,
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
                            "assets/images/checking.png",
                            width: 250,
                          ),
                          Center(
                            child: Text(validation_checked,
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
                      child: FutureBuilder(
                        future: getDataItemChecking(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          }

                          return ListView.builder(
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
                                              "$checking_time ${_listItemChecking[i].waktuJam}H : ${_listItemChecking[i].waktuMenit}M",
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
                                              // InkWell(
                                              //   onTap: () async {
                                              //     bool isInputted = await Navigator
                                              //             .of(context)
                                              //         .push(MaterialPageRoute(
                                              //             builder: (context) =>
                                              //                 StepFillEmpatInput(
                                              //                   ecmItemId:
                                              //                       _listItemChecking[
                                              //                               i]
                                              //                           .ecmitemId
                                              //                           .toString(),
                                              //                 )));

                                              //     if (isInputted) {
                                              //       // setState(() => );
                                              //       getDataItemChecking();
                                              //     }
                                              //   },
                                              //   child: Image.asset(
                                              //     "assets/icons/akar-icons_edit.png",
                                              //     width: 20,
                                              //   ),
                                              // ),
                                              InkWell(
                                                onTap: () {
                                                  confirmDelete(
                                                      _listItemChecking[i]
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
                          );
                        },
                      ),
                    ),
            ),
            InkWell(
              onTap: _listItemChecking.length == 6
                  ? () {
                      Fluttertoast.showToast(
                          msg: 'Item cek sudah maksimal 6',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.greenAccent,
                          textColor: Colors.white,
                          fontSize: 16);
                    }
                  : () async {
                      final prefs = await _prefs;
                      bool isInputted = await Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => StepFillEmpatInput()));

                      if (isInputted) {
                        // setState(() => getDataItemChecking());
                        prefs.setString("itemStep4Bool", "1");
                        getDataItemChecking();
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
                      add_item_,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Rubik',
                          color: Colors.white,
                          fontSize: 12),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
