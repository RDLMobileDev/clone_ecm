// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:convert';
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
import 'package:e_cm/util/shared_prefs_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StepFillEmpatInput extends StatefulWidget {
  const StepFillEmpatInput({Key? key, this.ecmItemId}) : super(key: key);
  final String? ecmItemId;

  @override
  _StepFillEmpatInputState createState() => _StepFillEmpatInputState();
}

class _StepFillEmpatInputState extends State<StepFillEmpatInput> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  TextEditingController? endTimePickController;
  TextEditingController? startTimePickController;
  TextEditingController tecItem = TextEditingController();
  TextEditingController tecStandard = TextEditingController();
  TextEditingController tecActual = TextEditingController();
  TextEditingController tecName = TextEditingController();
  TextEditingController tecMemberName = TextEditingController();

  List<PartModel> parts = <PartModel>[];
  List<AllUserModel> _users = <AllUserModel>[];

  var selectedPart;
  var selectedUser;

  String tokenUser = SharedPrefsUtil.getTokenUser();
  String idUser = SharedPrefsUtil.getIdUser();
  String userName = SharedPrefsUtil.getIdUserChecker();
  String userNameField = SharedPrefsUtil.getNameUserChecker();
  String ecmItemId = SharedPrefsUtil.getIdEcmItem();
  String ecmId = SharedPrefsUtil.getEcmId();
  String ecmIdEdit = SharedPrefsUtil.getEcmIdEdit();
  String idMachineRes = SharedPrefsUtil.getIdMesinRes();

  String _initialPartName = "Type Item Name";
  String _initialUser = "Type Name";

  bool isTappedNameItem = false, tapMemberName = false;

  String bahasa = "Bahasa Indonesia";
  bool bahasaSelected = false;

  String item_name = "",
      type_item_name = "",
      standard = "",
      type_standard = "",
      actual = "",
      type_actual = "",
      start_time = "",
      end_time = "",
      hm = "",
      name = "",
      save = "",
      edit = "";

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
    String idItemEcmEdit = widget.ecmItemId ?? "0";
    try {
      var result = await getIdFillNewEmpat(idItemEcmEdit, idUser, tokenUser);
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
            tecMemberName = TextEditingController(text: _users[0].userName);

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
    String ecmIdData = ecmId.isEmpty || ecmId == "" ? ecmIdEdit : ecmId;
    parts = await ApiLocationPartService.getPartLocations(ecmIdData, tokenUser);
    print("data ecm id -> $ecmIdData");
    print("data parts -> $parts");
  }

  void fetchAllUser() async {
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
    // String tokenUser = prefs.getString("tokenKey") ?? "";
    String idMachineRes = SharedPrefsUtil.getIdMesinRes();

    // print(ecmId);

    String resultMessage = "Data disimpan";

    try {
      var result = await fillNewEmpatInsert(
          // tokenUser,
          ecmId,
          idMachineRes,
          tecName.text,
          formValue["standard"] ?? "-",
          formValue["actual"] ?? "-",
          formValue["note"] ?? "-",
          startTimePickController!.text,
          endTimePickController!.text,
          idUser,
          formValue["name"] ?? "-");

      print(result);

      switch (result['response']['status']) {
        case 200:
          print(result['data']['t_ecmitem_id'].toString());

          SharedPrefsUtil.setIdEcmItem(
              result['data']['t_ecmitem_id'].toString());

          // prefs.setString(
          //     "idEcmItem", result['data']['t_ecmitem_id'].toString());

          // prefs.setString("itemStep4Bool", "1");

          // print(result['data']['t_ecmitem_id'].toString());

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

  void updateStepInputChecking() async {
    String ecmIdNewOrEdit = ecmId.isEmpty || ecmId == "" ? ecmIdEdit : ecmId;
    String idEcmItemEdit = widget.ecmItemId ?? "0";
    try {
      String resultMessage = "Data diperbarui";
      var result = await fillNewEmpatUpdate(
          ecmIdNewOrEdit,
          idMachineRes,
          tecName.text,
          tecStandard.text,
          tecActual.text,
          formValue["note"] ?? "-",
          formValue["start"] ?? "00:00",
          formValue["end"] ?? "00:00",
          idUser,
          formValue["name"] ?? "-",
          idEcmItemEdit,
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
        item_name = dataLang['step_4']['item_name'];
        type_item_name = dataLang['step_4']['type_name'];
        standard = dataLang['step_4']['standard'];
        type_standard = dataLang['step_4']['type_standard'];
        actual = dataLang['step_4']['actual'];
        type_actual = dataLang['step_4']['type_actual'];
        start_time = dataLang['step_4']['starttime'];
        end_time = dataLang['step_4']['end_time'];
        hm = dataLang['step_4']['hm'];
        name = dataLang['step_4']['name'];
        save = dataLang['step_4']['save'];
        edit = dataLang['step_4']['edit'];
      });
    }
  }

  void getLanguageId() async {
    var response = await rootBundle.loadString("assets/lang/lang-id.json");
    var dataLang = json.decode(response)['data'];

    if (mounted) {
      setState(() {});
      item_name = dataLang['step_4']['item_name'];
      type_item_name = dataLang['step_4']['type_name'];
      standard = dataLang['step_4']['standard'];
      type_standard = dataLang['step_4']['type_standard'];
      actual = dataLang['step_4']['actual'];
      type_actual = dataLang['step_4']['type_actual'];
      start_time = dataLang['step_4']['starttime'];
      end_time = dataLang['step_4']['end_time'];
      hm = dataLang['step_4']['hm'];
      name = dataLang['step_4']['name'];
      save = dataLang['step_4']['save'];
      edit = dataLang['step_4']['edit'];
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

  @override
  void initState() {
    super.initState();
    fetchLocationPartData();
    fetchAllUser();

    setBahasa();
    setLang();

    if ((widget.ecmItemId ?? "").isNotEmpty) {
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
                    text: item_name,
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
                      hintText: type_item_name),
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
                    text: standard,
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
                      hintText: type_standard),
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
                    text: actual,
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
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 18),
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      filled: true,
                      hintText: type_actual),
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
                    text: start_time,
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
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            fillColor: Colors.white,
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            filled: true,
                            hintText: hm),
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
                    text: end_time,
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
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            fillColor: Colors.white,
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            filled: true,
                            hintText: hm),
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
                    text: name,
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
                            onTap: () async {
                              final prefs = await _prefs;
                              setState(() {
                                tecMemberName = TextEditingController(
                                    text: _users[i].userFullName);
                                formValidations["name"] =
                                    _users[i].userFullName!.isNotEmpty;
                                formValue["name"] = _users[i].userId!;

                                SharedPrefsUtil.setIdUserChecker(
                                    _users[i].userId!);

                                SharedPrefsUtil.setNameUserChecker(
                                    _users[i].userFullName!);

                                // prefs.setString(
                                //     "idUserChecker", _users[i].userId!);
                                // prefs.setString(
                                //     "userStep4", _users[i].userFullName!);
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
                            if (ecmIdEdit.isNotEmpty || ecmIdEdit != "") {
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
                      ecmIdEdit.isEmpty || ecmIdEdit == "" ? save : edit,
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
