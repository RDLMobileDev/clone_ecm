// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_constructors

import 'dart:async';
import 'dart:io';

import 'package:e_cm/homepage/home/model/allusermodel.dart';
import 'package:e_cm/homepage/home/model/part_model.dart';
import 'package:e_cm/homepage/home/services/api_location_part_service.dart';
import 'package:e_cm/homepage/home/services/apifillnewempatinsert.dart';
import 'package:e_cm/homepage/home/services/getsemuauser.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:collection/collection.dart';

class StepFillEmpatInput extends StatefulWidget {
  const StepFillEmpatInput({Key? key, this.ecmItemId}) : super(key: key);
  final String? ecmItemId;

  @override
  _StepFillEmpatInputState createState() =>
      _StepFillEmpatInputState(ecmItemId: ecmItemId);
}

class _StepFillEmpatInputState extends State<StepFillEmpatInput> {
  final String? ecmItemId;
  _StepFillEmpatInputState({this.ecmItemId});

  TextEditingController? endTimePickController;
  TextEditingController? startTimePickController;
  final TextEditingController tecItem = TextEditingController();
  final TextEditingController tecStandard = TextEditingController();
  final TextEditingController tecActual = TextEditingController();
  final TextEditingController tecName = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  List<PartModel> parts = <PartModel>[];
  var selectedPart;
  List<AllUserModel> _users = <AllUserModel>[];
  var selectedUser;

  Map<String, bool> noteOptions = {"ok": false, "limit": false, "ng": false};

  Map<String, bool> formValidations = {
    "item": false,
    "standard": false,
    "actual": false,
    "note": false,
    "start": false,
    "end": false,
    "name": false,
  };

  Map<String, dynamic> formValue = {
    "item": "",
    "standard": "",
    "actual": "",
    "note": "",
    "start": "",
    "end": "",
    "name": AllUserModel(),
  };

  final DateTime now = DateTime.now();

  void getEndTime() {
    showTimePicker(
            context: context,
            initialTime: TimeOfDay(hour: now.hour, minute: now.minute))
        .then((value) {
      setState(() {
        formValidations["end"] = true;
        endTimePickController =
            TextEditingController(text: value!.format(context));

        DateTime convertedValue =
            DateFormat("HH:mm").parse(value.format(context));
        DateFormat timeFormat = DateFormat("HH:mm:ss");
        formValue["end"] = timeFormat.format(convertedValue);
      });
    });
  }

  void getStartTime() {
    showTimePicker(
            context: context,
            initialTime: TimeOfDay(hour: now.hour, minute: now.minute))
        .then((value) {
      setState(() {
        formValidations["start"] = true;
        startTimePickController =
            TextEditingController(text: value!.format(context));

        DateTime convertedValue =
            DateFormat("HH:mm").parse(value.format(context));
        DateFormat timeFormat = DateFormat("HH:mm:ss");
        formValue["start"] = timeFormat.format(convertedValue);
      });
    });
  }

  void getStepEmpatData() async {
    final prefs = await SharedPreferences.getInstance();
    var idUser = prefs.getString("idKeyUser").toString();
    String tokenUser = prefs.getString("tokenKey") ?? "";
  }

  void fetchLocationPartData() async {
    var prefs = await _prefs;
    String ecmId = prefs.getString("idEcm") ?? "";
    String tokenUser = prefs.getString("tokenKey") ?? "";

    parts = await ApiLocationPartService.getPartLocations(ecmId, tokenUser);
    print("data ecm id -> $ecmId");
    print("data parts -> $parts");
  }

  void fetchAllUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tokenUser = prefs.getString("tokenKey").toString();

    try {
      var result = await getUserAll(tokenUser);

      print(result);

      switch (result['response']['status']) {
        case 200:
          var data = result['data'] as List;
          _users = data.map((e) => AllUserModel.fromJson(e)).toList();
          break;
        default:
          Fluttertoast.showToast(
              msg: 'Gagal mendapat daftar member',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.greenAccent,
              textColor: Colors.white,
              fontSize: 16);
          break;
      }
    } catch (e) {
      print("exception user occured -> $e");
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

  void saveStepInputChecking() async {
    final prefs = await SharedPreferences.getInstance();
    var ecmId = prefs.getString("idEcm");
    var idUser = prefs.getString("idKeyUser").toString();
    String tokenUser = prefs.getString("tokenKey") ?? "";

    try {
      String resultMessage = "Data disimpan";
      var result = await fillNewEmpatInsert(
        token: tokenUser,
        ecmId: ecmId,
        userId: idUser,
        fullName: (formValue["name"] as AllUserModel).userFullName,
        partId: formValue["item"],
        actual: formValue["actual"],
        note: formValue["note"],
        start: formValue["start"],
        end: formValue["end"],
      );

      print(resultMessage);

      switch (result['response']['status']) {
        case 200:
          prefs.setString(
              "idEcmItem", result['data']['t_ecmitem_id'].toString());
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

  static String _displayPartOption(PartModel option) => option.mPartNama ?? "-";

  static String _displayUserOption(AllUserModel option) =>
      option.userFullName ?? "-";

  @override
  void initState() {
    super.initState();
    fetchLocationPartData();
    fetchAllUser();
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
            Navigator.of(context).pop(false);
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
              // ignore: prefer_const_constructors
              child: RichText(
                text: TextSpan(
                  text: 'Item Name ',
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
            Container(
              width: MediaQuery.of(context).size.width,
              height: 40,
              margin: const EdgeInsets.only(top: 10),
              child: InputDecorator(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 18),
                  fillColor: Colors.white,
                  focusedBorder: InputBorder.none,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  filled: true,
                ),
                child: Autocomplete<PartModel>(
                  displayStringForOption: _displayPartOption,
                  optionsBuilder: (TextEditingValue tev) {
                    if (tev.text == '') {
                      return const Iterable<PartModel>.empty();
                    }

                    return parts.where((element) => element
                        .toString()
                        .contains(tev.text.toString().toLowerCase()));
                  },
                  onSelected: (item) {
                    setState(() {
                      formValue["item"] = item.mPartId.toString();
                    });
                  },
                  fieldViewBuilder: (context, textEditingController, focusNode,
                      onFieldSubmitted) {
                    return TextFormField(
                      controller: textEditingController,
                      focusNode: focusNode,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: "Type Item Name",
                      ),
                      onFieldSubmitted: (String value) {
                        onFieldSubmitted();
                        setState(() {
                          formValidations["item"] = value.isNotEmpty;
                          formValue["item"] = parts
                              .firstWhere((element) =>
                                  value.contains(element.mPartNama ?? "-"))
                              .mPartId
                              .toString();
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          formValidations["item"] = value.isNotEmpty;
                          formValue["item"] = parts
                              .firstWhere(
                                  (element) =>
                                      value.contains(element.mPartNama ?? "-"),
                                  orElse: () => PartModel())
                              .mPartId
                              .toString();
                        });
                      },
                    );
                  },
                  optionsViewBuilder: (context, onSelected, options) {
                    return Align(
                      alignment: Alignment.topLeft,
                      child: Material(
                        elevation: 4.0,
                        child: SizedBox(
                          height: 200.0,
                          child: ListView.builder(
                            padding: const EdgeInsets.all(8.0),
                            itemCount: options.length,
                            itemBuilder: (BuildContext context, int index) {
                              final String option =
                                  options.elementAt(index).mPartNama ?? "-";
                              return GestureDetector(
                                onTap: () {
                                  onSelected(options.elementAt(index));
                                  formValue["item"] = options
                                      .elementAt(index)
                                      .mPartId
                                      .toString();
                                },
                                child: ListTile(
                                  title: Text(option),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 10),
              child: RichText(
                text: TextSpan(
                  text: 'Standard ',
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
            Container(
              width: MediaQuery.of(context).size.width,
              height: 40,
              margin: const EdgeInsets.only(top: 10),
              child: TextField(
                controller: tecStandard,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 18),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    filled: true,
                    hintText: 'Type Standard'),
                maxLines: 1,
                onChanged: (value) {
                  setState(() {
                    formValidations["standard"] = value.isNotEmpty;

                    formValue["standard"] = value;
                  });
                },
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 10),
              child: RichText(
                text: TextSpan(
                  text: 'Actual ',
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
            Container(
              width: MediaQuery.of(context).size.width,
              height: 40,
              margin: EdgeInsets.only(top: 10),
              child: TextField(
                controller: tecActual,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 18),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    filled: true,
                    hintText: 'Type Actual'),
                maxLines: 1,
                onChanged: (value) {
                  setState(() {
                    formValidations["actual"] = value.isNotEmpty;
                    formValue["actual"] = value;
                  });
                },
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 10),
              child: RichText(
                text: TextSpan(
                  text: 'Note ',
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
                        // ignore: prefer_const_literals_to_create_immutables
                        children: <Widget>[
                          Icon(
                            Icons.change_history_outlined,
                            color: (noteOptions["limit"] ?? false)
                                ? Color(0xFF00AEDB)
                                : Colors.grey,
                            size: 20,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Limit',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Rubik',
                              color: (noteOptions["limit"] ?? false)
                                  ? Color(0xFF00AEDB)
                                  : Colors.black,
                            ),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Icon(
                            Icons.close,
                            color: (noteOptions["ng"] ?? false)
                                ? Color(0xFF00AEDB)
                                : Colors.grey,
                            size: 20,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'N/G',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Rubik',
                              color: (noteOptions["ng"] ?? false)
                                  ? Color(0xFF00AEDB)
                                  : Colors.black,
                            ),
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
              child: RichText(
                text: TextSpan(
                  text: 'Start Time ',
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
                      controller: startTimePickController,
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
                    child: Icon(Icons.arrow_drop_down, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 10),
              child: RichText(
                text: TextSpan(
                  text: 'End Time ',
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
                      controller: endTimePickController,
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
                    child: Icon(Icons.arrow_drop_down, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 10),
              child: RichText(
                text: TextSpan(
                  text: 'Name ',
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
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 10),
              height: 40,
              child: InputDecorator(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 18),
                  fillColor: Colors.white,
                  focusedBorder: InputBorder.none,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  filled: true,
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                    size: 30,
                  ),
                ),
                child: Autocomplete<AllUserModel>(
                  displayStringForOption: _displayUserOption,
                  optionsBuilder: (TextEditingValue tev) {
                    if (tev.text == '') {
                      return const Iterable<AllUserModel>.empty();
                    }
                    return _users.where((element) => element
                        .toString()
                        .contains(tev.text.toString().toLowerCase()));
                  },
                  onSelected: (item) {
                    setState(() {
                      formValue["name"] = item;
                    });
                  },
                  fieldViewBuilder: (context, textEditingController, focusNode,
                      onFieldSubmitted) {
                    return TextFormField(
                      controller: textEditingController,
                      focusNode: focusNode,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: "Type Name",
                      ),
                      onFieldSubmitted: (String value) {
                        onFieldSubmitted();
                        setState(() {
                          formValidations["name"] = value.isNotEmpty;
                          formValue["name"] = _users.firstWhere((element) =>
                              value.contains(element.userFullName ?? "-"));
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          formValidations["name"] = value.isNotEmpty;
                          formValue["name"] = _users.firstWhere(
                              (element) =>
                                  value.contains(element.userFullName ?? "-"),
                              orElse: () => AllUserModel());
                        });
                      },
                    );
                  },
                  optionsViewBuilder: (context, onSelected, options) {
                    return Align(
                      alignment: Alignment.topLeft,
                      child: Material(
                        elevation: 4.0,
                        child: SizedBox(
                          height: 200.0,
                          child: ListView.builder(
                            padding: const EdgeInsets.all(8.0),
                            itemCount: options.length,
                            itemBuilder: (BuildContext context, int index) {
                              final String option =
                                  options.elementAt(index).userFullName ?? "-";
                              return GestureDetector(
                                onTap: () {
                                  onSelected(options.elementAt(index));
                                  formValue["name"] = options.elementAt(index);
                                },
                                child: ListTile(
                                  title: Text(option),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
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
                          saveStepInputChecking();
                        },
                  child: Text(
                    'Save Checking',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
