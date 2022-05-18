// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:e_cm/baseurl/baseurl.dart';
import 'package:e_cm/homepage/home/component/dialog_progress.dart';
import 'package:e_cm/homepage/home/model/item_checking.dart';
import 'package:e_cm/homepage/home/model/part_model.dart';
import 'package:e_cm/homepage/home/services/api_fill_new_lima_insert.dart';
import 'package:e_cm/homepage/home/services/api_location_part_service.dart';
import 'package:e_cm/homepage/home/services/apifillnewempatget.dart';
import 'package:e_cm/util/shared_prefs_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormStepFilllima extends StatefulWidget {
  final bool? isUpdate;
  final String? idEcmItem;

  const FormStepFilllima({Key? key, this.isUpdate, this.idEcmItem})
      : super(key: key);

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
  TextEditingController usernameStepLima = TextEditingController();

  List<ItemChecking> _listData = [];
  List<PartModel> partsItem = <PartModel>[];

  String ecmId = SharedPrefsUtil.getEcmId();
  String ecmIdEdit = SharedPrefsUtil.getEcmIdEdit();
  String ecmItemId = SharedPrefsUtil.getIdEcmItem();
  String idUser = SharedPrefsUtil.getIdUser();
  String machineId = SharedPrefsUtil.getIdMesinRes();
  String idUserChecker = SharedPrefsUtil.getIdUserChecker();
  String tokenUser = SharedPrefsUtil.getTokenUser();

  String _username = "", itemNameStepLimaInsert = "";

  //set Bahasa
  String bahasa = "Bahasa Indonesia";

  String item_repairing = '';
  String validation_repair = '';
  String add_item = '';
  String item_repair = '';
  String item_name = '';
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
  String cancel = '', save = '', edit = '';

  bool bahasaSelected = false;

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
    // final prefs = await _prefs;

    // print(widget.idEcmItem);

    // var idUser = prefs.getString("idKeyUser").toString();

    // String itemNameStepLima = prefs.getString("itemNameStepLima") ?? "";
    // String noteStep5 = prefs.getString("noteStep5") ?? "";
    // String startTimeStep5 = prefs.getString("startTimeStep5") ?? "";
    // String endTimeStep5 = prefs.getString("endTimeStep5") ?? "";
    // String repairMade = prefs.getString("repairMade") ?? "";

    final result = await MyUrl().getData(
        "ecmstep5_getid?ecmitem_id=${widget.idEcmItem}&user_id=$idUser");

    print("Data item step 5 edit");
    print(result);

    var dataItemStepLima = result['data'][0];

    print(dataItemStepLima['part_nama']);

    formValidations.updateAll((key, value) => true);

    setState(() {
      if (dataItemStepLima['part_nama'] != null) {
        tecName = TextEditingController(text: dataItemStepLima['part_nama']);
      }

      if (dataItemStepLima['note'] != null &&
          dataItemStepLima['note'] == "ok") {
        noteOptions["ok"] = true;
        noteOptions["limit"] = false;
        noteOptions["ng"] = false;

        formValue["note"] = dataItemStepLima['note'];
      } else if (dataItemStepLima['note'] != null &&
          dataItemStepLima['note'] == "limit") {
        noteOptions["ok"] = false;
        noteOptions["limit"] = true;
        noteOptions["ng"] = false;
        formValue["note"] = dataItemStepLima['note'];
      } else if (dataItemStepLima['note'] != null &&
          dataItemStepLima['note'] == "ng") {
        noteOptions["ok"] = false;
        noteOptions["limit"] = false;
        noteOptions["ng"] = true;
        formValue["note"] = dataItemStepLima['note'];
      }

      if (dataItemStepLima['t_ecmitem_start'] != null) {
        startTimePickerController =
            TextEditingController(text: dataItemStepLima['t_ecmitem_start']);
        formValue["start"] = dataItemStepLima['t_ecmitem_start'];
      }

      if (dataItemStepLima['t_ecmitem_end'] != null) {
        endTimePickerController =
            TextEditingController(text: dataItemStepLima['t_ecmitem_end']);
        formValue["end"] = dataItemStepLima['t_ecmitem_end'];
      }

      if (dataItemStepLima['repair_made'] != null) {
        repairMadeController =
            TextEditingController(text: dataItemStepLima['repair_made']);
        formValue["repair"] = dataItemStepLima['repair_made'];
      }

      _username = SharedPrefsUtil.getUsername();
      usernameStepLima = TextEditingController(text: _username);
    });
  }

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
        item_name = dataLang['step_5']['item_name'];
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

        save = dataLang['step_5']['save'];
        edit = dataLang['step_5']['edit'];
      });
    }
  }

  void getLanguageId() async {
    var response = await rootBundle.loadString("assets/lang/lang-id.json");
    var dataLang = json.decode(response)['data'];

    if (mounted) {
      setState(() {});
      item_name = dataLang['step_5']['item_name'];
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

      save = dataLang['step_5']['save'];
      edit = dataLang['step_5']['edit'];
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

  void getStartTime() async {
    final prefs = await _prefs;
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
        if (endTimePickerController?.text != null &&
            _isEndTimeGreaterThanStart(
                endTimePickerController!.text, value!.format(context))) {
          Fluttertoast.showToast(
            msg: "Start time harus lebih kecil dari end time",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.white,
            fontSize: 16,
          );
          return;
        }

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
      if (startTimePickerController?.text != null &&
          !_isEndTimeGreaterThanStart(
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
            TextEditingController(text: value?.format(context));
        prefs.setString("endTimeStep5", value!.format(context));

        DateTime convertedValue =
            DateFormat("HH:mm").parse(value.format(context));
        DateFormat timeFormat = DateFormat("HH:mm:ss");
        formValue["end"] = timeFormat.format(convertedValue);
      });
    });
  }

  void saveStepInputRepairing() async {
    String idEcmNewOld = ecmId.isEmpty || ecmId == "" ? ecmIdEdit : ecmId;

    try {
      dialogProgressSendData(context);
      String resultMessage = "Data disimpan";

      print(machineId);
      var result = await fillNewLimaInsert(
          formValue["note"] ?? "-",
          formValue["start"] ?? "-",
          formValue["end"] ?? "-",
          formValue["repair"] ?? "-",
          idUserChecker,
          idEcmNewOld,
          machineId,
          itemNameStepLimaInsert,
          idUser,
          widget.idEcmItem ?? "0",
          tokenUser);

      print("result insert 5 -> $result");

      switch (result['response']['status']) {
        case 200:
          // prefs.setString("itemRepairBool", "1");
          Navigator.of(context)
            ..pop()
            ..pop(true);
          break;
        default:
          Navigator.of(context).pop(true);
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
    setState(() {
      // _username = prefs.getString("usernameKey") ?? "";
      _username = SharedPrefsUtil.getUsername();
      usernameStepLima = TextEditingController(text: _username);
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

  void timerGetDataStep4() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (timer.tick == 10 && _listData.isEmpty) {
        Fluttertoast.showToast(
            msg: "Data item gagal dimuat",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.white,
            fontSize: 16);
        Navigator.of(context).pop();
        timer.cancel();
      } else {
        timer.cancel();
      }
      // getStep4Data();
    });
  }

  void fetchLocationPartData() async {
    String id = ecmId.isEmpty || ecmId == "" ? ecmIdEdit : ecmId;
    var dataItem = await ApiLocationPartService.getPartLocations(id, tokenUser);

    if (mounted) {
      setState(() {
        partsItem = dataItem;
      });
    }

    print("data ecm id -> $id");
    print("data parts -> ${partsItem.length}");
  }

  static String _displayPartOption(ItemChecking option) =>
      option.partNama ?? "-";

  @override
  void initState() {
    super.initState();
    setBahasa();
    setLang();

    if (widget.isUpdate == true) {
      getItemStepLimaforUpdate();
      // timerGetDataStep4();
      // Future.delayed(Duration(seconds: 3), () => getStep4Data());
      // getUsernameSession();
    } else {
      // Future.delayed(Duration(seconds: 3), () => getStep4Data());
      timerGetDataStep4();
    }
    getUsernameSession();

    fetchLocationPartData();
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
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
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
                      : partsItem.isEmpty
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
                              height: 200,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: partsItem.length,
                                itemBuilder: (context, i) {
                                  return InkWell(
                                      onTap: () async {
                                        // final prefs = await _prefs;
                                        setState(() {
                                          tecName = TextEditingController(
                                              text: partsItem[i].mPartNama);
                                          formValidations["item"] = partsItem[i]
                                              .mPartNama
                                              .toString()
                                              .isNotEmpty;
                                          itemNameStepLimaInsert =
                                              partsItem[i].mPartNama.toString();
                                          itemNameTapped = !itemNameTapped;
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child:
                                            Text(partsItem[i].mPartNama ?? "-"),
                                      ));
                                },
                              ),
                            ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 10),
                    child: RichText(
                      text: TextSpan(
                        text: starttime,
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
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(0),
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                filled: true,
                                hintText: hm),
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
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(0),
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                filled: true,
                                hintText: hm),
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
                ],
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
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
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 10),
                    height: 40,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      // readOnly: true,
                      // showCursor: false,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 18),
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          filled: true,
                          suffixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                            size: 30,
                          ),
                          hintText: type_name),
                      maxLines: 1,
                      controller: usernameStepLima,
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
                    child: RichText(
                      text: TextSpan(
                        text: repair_made,
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
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: TextFormField(
                      controller: repairMadeController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: type_message,
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
                    margin: EdgeInsets.only(top: 10),
                    child: RichText(
                      text: TextSpan(
                        text: "Judgement",
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              color: Colors.transparent),
                          child: InkWell(
                            onTap: () async {
                              final prefs = await _prefs;
                              setState(() {
                                noteOptions["ok"] =
                                    !(noteOptions["ok"] ?? false);
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
                                          : Colors.grey,
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
                              noteOptions["limit"] =
                                  !(noteOptions["limit"] ?? false);
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
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
                    margin: EdgeInsets.only(top: 50),
                    height: 40,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                formValidations.containsValue(false)
                                    ? Colors.grey
                                    : Color(0xFF00AEDB)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ))),
                        // onPressed: () {
                        //   if (!formValidations.containsValue(false)) {
                        //     saveStepInputRepairing();
                        //   } else {}
                        // },
                        onPressed: () {
                          if (!formValidations.containsValue(false) &&
                              widget.isUpdate == true) {
                            saveStepInputRepairing();
                          } else if (!formValidations.containsValue(false)) {
                            saveStepInputRepairing();
                          } else {}
                        },
                        child: Text(
                          widget.isUpdate == true ? edit : save,
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
            )
          ],
        ),
      ),
    );
  }
}
