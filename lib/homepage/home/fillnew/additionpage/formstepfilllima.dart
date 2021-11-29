// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace

import 'dart:async';
import 'dart:io';

import 'package:e_cm/homepage/home/services/api_fill_new_lima_insert.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormStepFilllima extends StatefulWidget {
  const FormStepFilllima({Key? key}) : super(key: key);

  @override
  _FormStepFilllimaState createState() => _FormStepFilllimaState();
}

class _FormStepFilllimaState extends State<FormStepFilllima> {
  TextEditingController? startTimePickerController;
  TextEditingController? endTimePickerController;
  final TextEditingController tecItem = TextEditingController();
  final TextEditingController tecName = TextEditingController();

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

  void getStartTime() {
    showTimePicker(
            context: context,
            initialTime: TimeOfDay(hour: now.hour, minute: now.minute))
        .then((value) {
      setState(() {
        formValidations["start"] = true;
        startTimePickerController =
            TextEditingController(text: value!.format(context));

        DateTime convertedValue =
            DateFormat("HH:mm").parse(value.format(context));
        DateFormat timeFormat = DateFormat("HH:mm:ss");
        formValue["start"] = timeFormat.format(convertedValue);
      });
    });
  }

  void getEndTime() {
    showTimePicker(
            context: context,
            initialTime: TimeOfDay(hour: now.hour, minute: now.minute))
        .then((value) {
      setState(() {
        formValidations["end"] = true;
        endTimePickerController =
            TextEditingController(text: value!.format(context));

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
              child: TextField(
                controller: tecItem,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 18),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    filled: true,
                    hintText: 'Type Item Name'),
                maxLines: 1,
                onChanged: (value) {
                  setState(() {
                    formValidations["item"] = value.isNotEmpty;

                    formValue["item"] = value;
                  });
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
                      onTap: () {
                        setState(() {
                          noteOptions["ok"] = !(noteOptions["ok"] ?? false);
                          noteOptions["limit"] = false;
                          noteOptions["ng"] = false;

                          formValidations["note"] =
                              noteOptions.containsValue(true);
                          formValue["note"] = "ok";
                        });
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
                    onTap: () {
                      setState(() {
                        noteOptions["limit"] = !(noteOptions["limit"] ?? false);
                        noteOptions["ok"] = false;
                        noteOptions["ng"] = false;

                        formValidations["note"] =
                            noteOptions.containsValue(true);
                        formValue["note"] = "limit";
                      });
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
                    onTap: () {
                      setState(() {
                        noteOptions["ng"] = !(noteOptions["ng"] ?? false);
                        noteOptions["limit"] = false;
                        noteOptions["ok"] = false;

                        formValidations["note"] =
                            noteOptions.containsValue(true);
                        formValue["note"] = "ng";
                      });
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
                controller: tecName,
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
                onChanged: (value) {
                  setState(() {
                    formValidations["repair"] = value.isNotEmpty;

                    formValue["repair"] = value;
                  });
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
