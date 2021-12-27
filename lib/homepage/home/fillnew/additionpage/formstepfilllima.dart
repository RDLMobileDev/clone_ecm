// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace

import 'dart:async';
import 'dart:io';

import 'package:e_cm/homepage/home/model/item_checking.dart';
import 'package:e_cm/homepage/home/model/steplimaitemmodel.dart';
import 'package:e_cm/homepage/home/services/api_fill_new_lima_insert.dart';
import 'package:e_cm/homepage/home/services/apifillnewempatget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormStepFilllima extends StatefulWidget {
  final bool? isUpdate;

  const FormStepFilllima({Key? key, this.isUpdate}) : super(key: key);

  @override
  _FormStepFilllimaState createState() => _FormStepFilllimaState();
}

class _FormStepFilllimaState extends State<FormStepFilllima> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  TextEditingController? startTimePickerController;
  TextEditingController? endTimePickerController;
  TextEditingController repairMadeController = TextEditingController();
  final TextEditingController tecItem = TextEditingController();
  TextEditingController tecName = TextEditingController();
  List<ItemChecking> _listData = [];
  String _username = "";

  bool itemNameTapped = false;

  Map<String, bool> noteOptions = {
    "ok": false,
    "limit": false,
    "ng": false,
  };

  Map<String, bool> formValidations = {
    "item": false,
    "note": false,
    "start": false,
    "end": false,
    "name": false,
    "repair": false,
  };

  Map<String, String> formValue = {
    "item": "",
    "note": "",
    "start": "",
    "end": "",
    "name": "",
    "repair": "",
  };

  final DateTime now = DateTime.now();

  void getItemStepLimaforUpdate() async {
    final prefs = await _prefs;

    String itemNameStepLima = prefs.getString("itemNameStepLima") ?? "";
    String noteStep5 = prefs.getString("noteStep5") ?? "";
    String startTimeStep5 = prefs.getString("startTimeStep5") ?? "";
    String endTimeStep5 = prefs.getString("endTimeStep5") ?? "";
    String repairMade = prefs.getString("repairMade") ?? "";

    if (itemNameStepLima.isNotEmpty && itemNameStepLima != "") {
      tecName = TextEditingController(text: itemNameStepLima);
    }

    if (noteStep5.isNotEmpty && noteStep5 != "" && noteStep5 == "ok") {
      setState(() {
        noteOptions["ok"] = true;
        noteOptions["limit"] = false;
        noteOptions["ng"] = false;
      });
    } else if (noteStep5.isNotEmpty &&
        noteStep5 != "" &&
        noteStep5 == "limit") {
      setState(() {
        noteOptions["ok"] = false;
        noteOptions["limit"] = true;
        noteOptions["ng"] = false;
      });
    } else if (noteStep5.isNotEmpty && noteStep5 != "" && noteStep5 == "ng") {
      setState(() {
        noteOptions["ok"] = false;
        noteOptions["limit"] = false;
        noteOptions["ng"] = true;
      });
    }

    if (startTimeStep5.isNotEmpty && startTimeStep5 != "") {
      startTimePickerController = TextEditingController(text: startTimeStep5);
    }

    if (endTimeStep5.isNotEmpty && endTimeStep5 != "") {
      endTimePickerController = TextEditingController(text: endTimeStep5);
    }

    if (repairMade.isNotEmpty && repairMade != "") {
      repairMadeController = TextEditingController(text: repairMade);
    }
  }

  void getStep4Data() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("tokenKey").toString();
    String? ecmId = prefs.getString("idEcm") ?? "-";
    String? userId = prefs.getString("idKeyUser") ?? "-";
    print("from step 5 item");
    print(ecmId);

    try {
      var data = await getFillNewEmpat(ecmId, userId, token);

      print(data);

      switch (data["response"]['status']) {
        case 200:
          setState(() {
            _listData = (data['data'] as List)
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

  void getStartTime() async {
    final prefs = await _prefs;
    showTimePicker(
            context: context,
            initialTime: TimeOfDay(hour: now.hour, minute: now.minute))
        .then((value) {
      setState(() {
        formValidations["start"] = true;
        startTimePickerController =
            TextEditingController(text: value!.format(context));
        prefs.setString("startTimeStep5", value.format(context));

        DateTime convertedValue =
            DateFormat("HH:mm").parse(value.format(context));
        DateFormat timeFormat = DateFormat("HH:mm:ss");
        formValue["start"] = timeFormat.format(convertedValue);
      });
    });
  }

  void getEndTime() async {
    final prefs = await _prefs;
    showTimePicker(
            context: context,
            initialTime: TimeOfDay(hour: now.hour, minute: now.minute))
        .then((value) {
      if (!_isEndTimeGreaterThanStart(
          startTimePickerController!.text, value!.format(context))) {
        Fluttertoast.showToast(
          msg: "End time harus lebih besar dari start time",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.greenAccent,
          textColor: Colors.white,
          fontSize: 16,
        );
        return;
      }
      setState(() {
        formValidations["end"] = true;
        endTimePickerController =
            TextEditingController(text: value.format(context));
        prefs.setString("endTimeStep5", value.format(context));

        DateTime convertedValue =
            DateFormat("HH:mm").parse(value.format(context));
        DateFormat timeFormat = DateFormat("HH:mm:ss");
        formValue["end"] = timeFormat.format(convertedValue);
      });
    });
  }

  void saveStepInputRepairing() async {
    final prefs = await SharedPreferences.getInstance();
    var ecmItemId = prefs.getString("idEcmItem");
    var idUser = prefs.getString("idKeyUser").toString();
    String tokenUser = prefs.getString("tokenKey") ?? "";

    print("ecm item id -> $ecmItemId");

    try {
      String resultMessage = "Data disimpan";
      var result = await fillNewLimaInsert(
        token: tokenUser,
        ecmItemId: ecmItemId,
        userId: idUser,
        repairMessage: formValue["repair"],
        note: formValue["note"],
        start: formValue["start"],
        end: formValue["end"],
      );

      print("result insert 5 -> $result");
      print(result['data']['t_ecmitem_id']);

      switch (result['response']['status']) {
        case 200:
          Navigator.of(context).pop(true);
          break;
        default:
          resultMessage = "Data gagal disimpan";
          break;
      }

      Fluttertoast.showToast(
        msg: resultMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.greenAccent,
        textColor: Colors.white,
        fontSize: 16,
      );
    } catch (e) {
      print("exception occured -> $e");
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

  void getUsernameSession() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString("usernameKey") ?? "";
      formValidations["name"] = true;
      formValue["name"] = _username;
    });
  }

  bool _isEndTimeGreaterThanStart(String start, String end) {
    DateFormat format = DateFormat("HH:mm");
    DateTime parsedStart = format.parse(start);
    DateTime parsedEnd = format.parse(end);
    return parsedStart.isBefore(parsedEnd);
  }

  static String _displayPartOption(ItemChecking option) =>
      option.partNama ?? "-";

  @override
  void initState() {
    super.initState();

    if (widget.isUpdate == true) {
      getItemStepLimaforUpdate();
    } else {
      Future.delayed(Duration(seconds: 3), () => getStep4Data());
    }
    getUsernameSession();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF00AEDB),
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Item Name',
                textAlign: TextAlign.left,
                style: const TextStyle(fontSize: 16, fontFamily: 'Rubik'),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 40,
              margin: const EdgeInsets.only(top: 10),
              child: TextFormField(
                controller: tecName,
                showCursor: true,
                readOnly: true,
                onTap: () {
                  setState(() {
                    itemNameTapped = !itemNameTapped;
                  });
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey))),
              ),
            ),
            itemNameTapped == false
                ? Container()
                : Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _listData.length,
                      itemBuilder: (context, i) {
                        return InkWell(
                            onTap: () async {
                              final prefs = await _prefs;
                              setState(() {
                                tecName = TextEditingController(
                                    text: _listData[i].partNama);
                                formValidations["item"] =
                                    _listData[i].partNama.toString().isNotEmpty;
                                itemNameTapped = !itemNameTapped;
                              });
                              prefs.setString("itemNameStepLima",
                                  _listData[i].partNama.toString());
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(_listData[i].partNama!),
                            ));
                      },
                    ),
                  ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 10),
              child: Text(
                'Note',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16, fontFamily: 'Rubik'),
              ),
            ),
            Container(
              height: 40,
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 10, right: 10),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: (noteOptions["ok"] ?? false)
                                ? Color(0xFF00AEDB)
                                : Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Colors.transparent),
                    child: InkWell(
                      onTap: () async {
                        final prefs = await _prefs;
                        setState(() {
                          noteOptions["ok"] = !(noteOptions["ok"] ?? false);
                          noteOptions["limit"] = false;
                          noteOptions["ng"] = false;

                          formValidations["note"] =
                              noteOptions.containsValue(true);
                          formValue["note"] = "ok";
                        });
                        prefs.setString("noteStep5", "ok");
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.circle_outlined,
                              color: (noteOptions["ok"] ?? false)
                                  ? Color(0xFF00AEDB)
                                  : Colors.grey,
                              size: 20,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'OK',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Rubik',
                                color: (noteOptions["ok"] ?? false)
                                    ? Color(0xFF00AEDB)
                                    : Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final prefs = await _prefs;
                      setState(() {
                        noteOptions["limit"] = !(noteOptions["limit"] ?? false);
                        noteOptions["ok"] = false;
                        noteOptions["ng"] = false;

                        formValidations["note"] =
                            noteOptions.containsValue(true);
                        formValue["note"] = "limit";
                      });
                      prefs.setString("noteStep5", "limit");
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 10, right: 10),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: (noteOptions["limit"] ?? false)
                                  ? Color(0xFF00AEDB)
                                  : Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Colors.transparent),
                      // ignore: prefer_const_literals_to_create_immutables
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.change_history_outlined,
                            color: (noteOptions["limit"] ?? false)
                                ? Color(0xFF00AEDB)
                                : Colors.grey,
                            size: 20,
                          ),
                          Text(
                            'Limit',
                            style: TextStyle(
                                color: (noteOptions["limit"] ?? false)
                                    ? Color(0xFF00AEDB)
                                    : Colors.grey,
                                fontSize: 16,
                                fontFamily: 'Rubik'),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final prefs = await _prefs;
                      setState(() {
                        noteOptions["ng"] = !(noteOptions["ng"] ?? false);
                        noteOptions["limit"] = false;
                        noteOptions["ok"] = false;

                        formValidations["note"] =
                            noteOptions.containsValue(true);
                        formValue["note"] = "ng";
                      });
                      prefs.setString("noteStep5", "ng");
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: (noteOptions["ng"] ?? false)
                                ? Color(0xFF00AEDB)
                                : Colors.grey,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Colors.transparent),
                      // ignore: prefer_const_literals_to_create_immutables
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.close,
                            color: (noteOptions["ng"] ?? false)
                                ? Color(0xFF00AEDB)
                                : Colors.grey,
                            size: 20,
                          ),
                          Text(
                            'N / G',
                            style: TextStyle(
                                color: (noteOptions["ng"] ?? false)
                                    ? Color(0xFF00AEDB)
                                    : Colors.grey,
                                fontSize: 16,
                                fontFamily: 'Rubik'),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 10),
              child: Text(
                'Start Time',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16, fontFamily: 'Rubik'),
              ),
            ),
            Container(
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.only(top: 10),
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: Icon(Icons.access_time, color: Colors.grey),
                  ),
                  Expanded(
                    child: TextFormField(
                      onTap: () => getStartTime(),
                      readOnly: true,
                      controller: startTimePickerController,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          fillColor: Colors.white,
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          filled: true,
                          hintText: 'HH:MM'),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 10),
              child: Text(
                'End Time',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16, fontFamily: 'Rubik'),
              ),
            ),
            Container(
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.only(top: 10),
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: Icon(Icons.access_time, color: Colors.grey),
                  ),
                  Expanded(
                    child: TextFormField(
                      onTap: () => getEndTime(),
                      readOnly: true,
                      controller: endTimePickerController,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          fillColor: Colors.white,
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          filled: true,
                          hintText: 'HH:MM'),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 10),
              child: Text(
                'Name',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16, fontFamily: 'Rubik'),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 10),
              height: 40,
              child: TextFormField(
                keyboardType: TextInputType.text,
                readOnly: true,
                showCursor: false,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 18),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    filled: true,
                    suffixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                      size: 30,
                    ),
                    hintText: 'Type Name'),
                maxLines: 1,
                controller: TextEditingController(text: _username),
                onChanged: (value) {
                  setState(() {
                    formValidations["name"] = value.isNotEmpty;

                    formValue["name"] = value;
                  });
                },
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 10),
              child: Text(
                'Repair made',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16, fontFamily: 'Rubik'),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: TextFormField(
                controller: repairMadeController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Type message...',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF979C9E)),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                onChanged: (value) async {
                  final prefs = await _prefs;
                  setState(() {
                    formValidations["repair"] = value.isNotEmpty;

                    formValue["repair"] = value;
                  });
                  prefs.setString("repairMade", value);
                },
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 50),
              height: 40,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          formValidations.containsValue(false)
                              ? Colors.grey
                              : Color(0xFF00AEDB)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ))),
                  onPressed: formValidations.containsValue(false)
                      ? null
                      : () {
                          saveStepInputRepairing();
                        },
                  child: Text(
                    'Save Repairing',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
