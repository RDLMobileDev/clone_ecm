// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, avoid_unnecessary_containers

import 'dart:async';
import 'dart:io';

import 'package:e_cm/homepage/home/fillnew/additionpage/stepfillempatinput.dart';
import 'package:e_cm/homepage/home/model/item_checking.dart';
import 'package:e_cm/homepage/home/services/apifillnewempatdelete.dart';
import 'package:e_cm/homepage/home/services/apifillnewempatget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StepFillEmpat extends StatefulWidget {
  const StepFillEmpat({Key? key}) : super(key: key);

  @override
  _StepFillEmpatState createState() => _StepFillEmpatState();
}

class _StepFillEmpatState extends State<StepFillEmpat> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  List<ItemChecking> _listItemChecking = [];

  void getDataItemChecking() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("tokenKey").toString();
    String? ecmId = prefs.getString("idEcm") ?? "-";
    String? userId = prefs.getString("idKeyUser") ?? "-";

    try {
      var data = await getFillNewEmpat(ecmId, userId, token);

      switch (data["response"]['status']) {
        case 200:
          setState(() {
            _listItemChecking = (data['data'] as List)
                .map((e) => ItemChecking.fromJson(e))
                .toList();
          });
          break;
        default:
          Fluttertoast.showToast(
              msg: 'Gagal mendapat daftar item checking',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.greenAccent,
              textColor: Colors.white,
              fontSize: 16);
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

  void confirmDelete() {
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
                                    "Cancel",
                                    style: TextStyle(
                                        color: Color(0xFF00AEDB),
                                        fontFamily: 'Rubik',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                )),
                          ),
                          InkWell(
                            onTap: () async {
                              deleteItemChecking();
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
              });
  }

  @override
  void initState() {
    super.initState();
    getDataItemChecking();
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
                  text: 'Item Checking ',
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
                            "assets/images/empty.png",
                            width: 250,
                          ),
                          Center(
                            child: Text("Haven't checked item yet",
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
                                          "Checking Time: ${_listItemChecking[i].waktuJam}H : ${_listItemChecking[i].waktuMenit}M",
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
                                              bool isInputted = await Navigator
                                                      .of(context)
                                                  .push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          StepFillEmpatInput(
                                                            ecmItemId:
                                                                _listItemChecking[
                                                                        i]
                                                                    .ecmitemId
                                                                    .toString(),
                                                          )));

                                              if (isInputted) {
                                                // setState(() => );
                                                getDataItemChecking();
                                              }
                                            },
                                            child: Image.asset(
                                              "assets/icons/akar-icons_edit.png",
                                              width: 20,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              confirmDelete();
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
              onTap: () async {
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
                      'Add item',
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
