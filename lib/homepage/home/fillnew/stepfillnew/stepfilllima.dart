// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'dart:async';
import 'dart:io';

import 'package:e_cm/homepage/home/fillnew/additionpage/formstepfilllima.dart';
import 'package:e_cm/homepage/home/model/item_checking.dart';
import 'package:e_cm/homepage/home/services/api_fill_new_lima_get.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StepFillLima extends StatefulWidget {
  const StepFillLima({Key? key}) : super(key: key);

  @override
  _StepFillLimaState createState() => _StepFillLimaState();
}

class _StepFillLimaState extends State<StepFillLima> {
  List<ItemChecking> _listItemChecking = <ItemChecking>[];

  void getDataItemRepairing() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("tokenKey").toString();
    String? ecmId = prefs.getString("idEcm") ?? "-";
    String? userId = prefs.getString("idKeyUser") ?? "-";

    try {
      var data = await getFillNewLima(ecmId, userId, token);

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
              msg: 'Gagal mendapat daftar item repairing',
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

  @override
  void initState() {
    super.initState();
    getDataItemRepairing();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                "Item Repairing",
                style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
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
                            child: Text("Haven't repaired the item yet",
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
                                          "Repair Time: ${_listItemChecking[i].waktuJam}H : ${_listItemChecking[i].waktuMenit}M",
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
                                            onTap: () async {},
                                            child: Image.asset(
                                              "assets/icons/akar-icons_edit.png",
                                              width: 20,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {},
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
                bool isInputted = await Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => FormStepFilllima()));

                if (isInputted) {
                  getDataItemRepairing();
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Checking Time :',
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          fontSize: 16,
                        ),
                      ),
                      Text('0 H : 0 M'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
