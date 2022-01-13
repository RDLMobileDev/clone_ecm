// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_constructors

import 'dart:async';
import 'dart:io';

import 'package:e_cm/homepage/home/model/allusermodel.dart';
import 'package:e_cm/homepage/home/model/item_checking_detail.dart';
import 'package:e_cm/homepage/home/model/part_model.dart';
import 'package:e_cm/homepage/home/services/api_get_user_byid.dart';
import 'package:e_cm/homepage/home/services/api_location_part_service.dart';
import 'package:e_cm/homepage/home/services/apifillnewempatgetbyid.dart';
import 'package:e_cm/homepage/home/services/apifillnewempatinsert.dart';
import 'package:e_cm/homepage/home/services/apifillnewempatupdate.dart';
import 'package:e_cm/homepage/home/services/getsemuauser.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  TextEditingController? endTimePickController;
  TextEditingController? startTimePickController;
  TextEditingController tecItem = TextEditingController();
  TextEditingController tecStandard = TextEditingController();
  TextEditingController tecActual = TextEditingController();
  TextEditingController tecName = TextEditingController();
  TextEditingController tecMemberName = TextEditingController();

  List<PartModel> parts = <PartModel>[];
  var selectedPart;
  List<AllUserModel> _users = <AllUserModel>[];
  var selectedUser;

  bool isTappedNameItem = false, tapMemberName = false;

  String _initialPartName = "Type Item Name";
  String _initialUser = "Type Name";

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

  Map<String, String> formValue = {
    "item": "",
    "standard": "",
    "actual": "",
    "note": "",
    "start": "",
    "end": "",
    "name": ""
  };

  final DateTime now = DateTime.now();

  bool _isEndTimeGreaterThanStart(String start, String end) {
    DateFormat format = DateFormat("HH:mm");
    DateTime parsedStart = format.parse(start);
    DateTime parsedEnd = format.parse(end);
    return parsedStart.isBefore(parsedEnd);
  }

  Future<bool> _loadingAction() async {
    //replace the below line of code with your login request
    Future.delayed(const Duration(seconds: 3));

    return true;
  }

  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.greenAccent,
        textColor: Colors.white,
        fontSize: 16);
  }

  void getEndTime() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(
                // Using 24-Hour format
                alwaysUse24HourFormat: true),
            // If you want 12-Hour format, just change alwaysUse24HourFormat to false or remove all the builder argument
            child: child!);
      },
    ).then((value) {
      if (formValidations["start"] == false) {
        showToast("Silahkan atur start time terlebih dahulu");
        return;
      }

      if (!_isEndTimeGreaterThanStart(
          startTimePickController!.text, value!.format(context))) {
        showToast("End time harus lebih besar dari start time");
        return;
      }
      setState(() {
        formValidations["end"] = true;
        endTimePickController =
            TextEditingController(text: value.format(context));

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
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(
                // Using 24-Hour format
                alwaysUse24HourFormat: true),
            // If you want 12-Hour format, just change alwaysUse24HourFormat to false or remove all the builder argument
            child: child!);
      },
    ).then((value) {
      setState(() {
        if (endTimePickController?.text != null &&
            _isEndTimeGreaterThanStart(
                endTimePickController!.text, value!.format(context))) {
          showToast("Start time harus lebih kecil dari end time");
          return;
        }

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
    final prefs = await _prefs;
    String idUser = prefs.getString("idKeyUser").toString();
    String tokenUser = prefs.getString("tokenKey") ?? "";

    try {
      var result =
          await getIdFillNewEmpat(widget.ecmItemId!, idUser, tokenUser);
      print("Data step 4 for update");
      print(result);

      switch (result['response']['status']) {
        case 200:
          var data = (result['data'] as List)
              .map((e) => ItemCheckingDetail.fromJson(e))
              .toList();
          setState(() {
            tecName = TextEditingController(text: data[0].partNama);
            formValue = {
              "item": data[0].partNama ?? "-",
              "standard": data[0].partStandard ?? "-",
              "actual": data[0].actual ?? "-",
              "note": data[0].note ?? "-",
              "start": data[0].tEcmitemStart ?? "-",
              "end": data[0].tEcmitemEnd ?? "-",
              "name": data[0].userName ?? "-",
            };

            _initialPartName = data[0].partNama ?? "-";
            getUserNameById(data[0].userName ?? "-", tokenUser).then((value) {
              if (value['response']['status'] != 200) {
                Fluttertoast.showToast(
                    msg: "Username tidak ditemukan",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 2,
                    backgroundColor: Colors.greenAccent,
                    textColor: Colors.white,
                    fontSize: 16);
                return;
              }

              setState(() {
                formValue['name'] = value['data']['id'].toString();
                _initialUser = value['data']['username'] ?? "-";
              });
            });

            tecItem = TextEditingController(text: formValue["item"]);
            tecStandard = TextEditingController(text: formValue["standard"]);
            tecActual = TextEditingController(text: formValue["actual"]);
            startTimePickController =
                TextEditingController(text: formValue["start"]);
            endTimePickController =
                TextEditingController(text: formValue["end"]);

            switch (formValue["note"]) {
              case "ok":
                noteOptions["ok"] = true;
                break;
              case "limit":
                noteOptions["limit"] = true;
                break;
              case "ng":
                noteOptions["ng"] = true;
                break;
            }

            formValidations.updateAll((key, value) => true);
          });
          break;
        default:
          Fluttertoast.showToast(
              msg: "Data item checking tidak ditemukan",
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
    String idUser = prefs.getString("idKeyUser").toString();
    try {
      var result = await getUserAll(tokenUser, idUser);

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
    final prefs = await _prefs;
    var ecmId = prefs.getString("idEcm");
    var idUser = prefs.getString("idKeyUser").toString();
    // String tokenUser = prefs.getString("tokenKey") ?? "";
    var idMachineRes = prefs.getString("id_machine_res");

    print(ecmId);

    String resultMessage = "Data disimpan";
    var result = await fillNewEmpatInsert(
        // tokenUser,
        ecmId!,
        idMachineRes!,
        tecName.text,
        formValue["standard"]!,
        formValue["actual"]!,
        formValue["note"]!,
        startTimePickController!.text,
        endTimePickController!.text,
        idUser,
        formValue["name"]!);

    print(result);

    switch (result['response']['status']) {
      case 200:
        print(result['data']['t_ecmitem_id'].toString());
        prefs.setString("idEcmItem", result['data']['t_ecmitem_id'].toString());

        prefs.setString("itemStep4Bool", "1");
        print(result['data']['t_ecmitem_id'].toString());
        Navigator.of(context)
          ..pop()
          ..pop(true);
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

    try {} catch (e) {
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

  void updateStepInputChecking() async {
    final prefs = await SharedPreferences.getInstance();
    var ecmId = prefs.getString("idEcm");
    var idUser = prefs.getString("idKeyUser").toString();
    var idMachineRes = prefs.getString("id_machine_res");
    // var idEcmItem = prefs.getString("idEcmItem");
    String tokenUser = prefs.getString("tokenKey") ?? "";

    try {
      String resultMessage = "Data diperbarui";
      var result = await fillNewEmpatUpdate(
          ecmId!,
          idMachineRes!,
          tecName.text,
          tecStandard.text,
          tecActual.text,
          formValue["note"] ?? "-",
          formValue["start"] ?? "00:00",
          formValue["end"] ?? "00:00",
          idUser,
          formValue["name"] ?? "-",
          ecmItemId!,
          tokenUser);

      print("hasil update step 4");
      print(result);

      // print("response update -> $result");

      switch (result['response']['status']) {
        case 200:
          Navigator.of(context)
            ..pop()
            ..pop(true);
          break;
        default:
          resultMessage = "Data item checking gagal diperbarui";
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

    print(widget.ecmItemId);

    if (ecmItemId != null) {
      getStepEmpatData();
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
            Navigator.of(context).pop(true);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop(false);
          return true;
        },
        child: Container(
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
                height: 60,
                margin: const EdgeInsets.only(top: 10),
                child: TextField(
                  maxLength: 50,
                  controller: tecName,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 18),
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      filled: true,
                      hintText: 'Type item name'),
                  maxLines: 1,
                  onChanged: (value) {
                    formValidations["item"] = value.isNotEmpty;
                  },
                  onTap: () {
                    setState(() {
                      isTappedNameItem = !isTappedNameItem;
                    });
                  },
                ),
              ),
              isTappedNameItem == false
                  ? Container()
                  : parts.isEmpty
                      ? Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Center(
                            child: Column(
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(
                                  height: 4,
                                ),
                                Text("Memuat nama item")
                              ],
                            ),
                          ),
                        )
                      : Container(
                          width: MediaQuery.of(context).size.width,
                          height: 150,
                          child: ListView(
                            shrinkWrap: true,
                            children: parts.map((e) {
                              return InkWell(
                                onTap: () {
                                  print(e.mPartNama);
                                  setState(() {
                                    tecName = TextEditingController(
                                        text: e.mPartNama);
                                    formValidations["item"] =
                                        e.mPartNama!.isNotEmpty;
                                    isTappedNameItem = !isTappedNameItem;
                                  });
                                },
                                child: Container(
                                    height: 30, child: Text(e.mPartNama!)),
                              );
                            }).toList(),
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
                height: 60,
                margin: const EdgeInsets.only(top: 10),
                child: TextField(
                  maxLength: 50,
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
                height: 60,
                margin: EdgeInsets.only(top: 10),
                child: TextField(
                  maxLength: 50,
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
                    text: 'Judgement ',
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
                          noteOptions["limit"] =
                              !(noteOptions["limit"] ?? false);
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
                child: TextFormField(
                  controller: tecMemberName,
                  readOnly: true,
                  onTap: () {
                    setState(() {
                      tapMemberName = !tapMemberName;
                    });
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)))),
                ),
              ),
              tapMemberName == false
                  ? Container()
                  : Container(
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _users.length,
                        itemBuilder: (context, i) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                tecMemberName = TextEditingController(
                                    text: _users[i].userFullName);
                                formValidations["name"] =
                                    _users[i].userFullName!.isNotEmpty;
                                formValue["name"] = _users[i].userId!;
                                tapMemberName = !tapMemberName;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(_users[i].userFullName!),
                            ),
                          );
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
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ))),
                    onPressed: formValidations.containsValue(false)
                        ? null
                        : () async {
                            if (ecmItemId != null) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: null,
                                        strokeWidth: 2,
                                      ),
                                    );
                                  });
                              await _loadingAction();
                              updateStepInputChecking();
                              return;
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: null,
                                        strokeWidth: 2,
                                      ),
                                    );
                                  });
                              await _loadingAction();
                              saveStepInputChecking();
                            }

                            // Navigator.pop(context, true);
                            // Navigator.of(context).pop();
                          },
                    child: Text(
                      ecmItemId == null ? 'Save Checking' : "Update Checking",
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
      ),
    );
  }
}
