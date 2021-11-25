// ignore_for_file: sized_box_for_whitespace, avoid_print, unnecessary_const, use_key_in_widget_constructors, prefer_const_constructors

import 'dart:async';
import 'dart:io';

import 'package:e_cm/homepage/home/model/classificationmodel.dart';
import 'package:e_cm/homepage/home/model/locationmodel.dart';
import 'package:e_cm/homepage/home/model/machinenamemodel.dart';
import 'package:e_cm/homepage/home/model/machinenumbermodel.dart';
import 'package:e_cm/homepage/home/services/apifillnewsatu.dart';
import 'package:e_cm/homepage/home/services/classificationservice.dart';
import 'package:e_cm/homepage/home/services/locationservice.dart';
import 'package:e_cm/homepage/home/services/machinenameservice.dart';
import 'package:e_cm/homepage/home/services/machinenumberservice.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:date_time_format/date_time_format.dart';

class StepFillSatu extends StatefulWidget {
  final StepFillSatuState stepFillSatuState = StepFillSatuState();

  void getSaveFillSatu() {
    stepFillSatuState.saveFillNewSatu();
  }

  @override
  StepFillSatuState createState() => StepFillSatuState();
}

class StepFillSatuState extends State<StepFillSatu> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  TextEditingController? machineNameController;
  TextEditingController teamMemberController = TextEditingController();

  bool isTapedMachineName = false;
  bool isBreakDown = false, isPreventive = false, isInformation = false;

  String dateSelected = 'DD/MM/YYYY';
  String? locationSelected;
  String locationIdSelected = '';
  String machineSelected = '';
  String machineIdSelected = '';
  String? machineNumberSelected;
  String machineDetailIdSelected = '';
  String classificationIdSelected = '';

  List<ClassificationModel> _listClassification = [];
  List<LocationModel> _listLocation = [];
  List<MachineNameModel> _listMachineName = [];
  List<MachineNumberModel> _listMachineNumber = [];
  List<String> listTeamMember = [];

  // test call method from outside class (fillnew)
  void saveFillNewSatu() async {
    final prefs = await _prefs;
    // print("from prefs: ${prefs.getString("idClassification")}");

    var idClass = prefs.getString("idClassification");
    var tglStepSatu = prefs.getString("tglStepSatu");

    // var teamMember = prefs.getString("teamMember");

    List<String>? teamId = prefs.getStringList("teamMember");
    var locationId = prefs.getString("locationId");
    var machineId = prefs.getString("machineId");
    var machineDetailId = prefs.getString("machineDetailId");

    String? tokenUser = prefs.getString("tokenKey").toString();
    String? idUser = prefs.getString("idKeyUser").toString();

    try {
      var result = await fillNewSatu(tokenUser, idClass!, tglStepSatu!, idUser,
          teamId!, locationId!, machineId!, machineDetailId!);

      print(result['response']['status']);
      prefs.setString("idEcm", result['data']['id_ecm'].toString());

      if (result['response']['status'] == 200) {
        Fluttertoast.showToast(
            msg: 'Data disimpan',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.white,
            fontSize: 16);
        print(result);
      } else {
        Fluttertoast.showToast(
            msg: 'Kesalahan jaringan. Data gagal disimpan.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.white,
            fontSize: 16);
        print(result);
      }
    } on SocketException catch (e) {
      print(e);
    } on TimeoutException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  void getDateFromDialog() async {
    final prefs = await _prefs;
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1990),
            lastDate: DateTime(2022))
        .then((value) {
      if (value != null) {
        DateTime _fromDate = DateTime.now();
        _fromDate = value;
        final String date = _fromDate.format("Y-m-d");

        // String date = _fromDate.format("Y-m-d");
        setState(() {
          dateSelected = date;
          prefs.setString("tglStepSatu", dateSelected);
        });
        print(dateSelected);
      }
    });
  }

  Future<List<ClassificationModel>> getClassificationData() async {
    _listClassification = await classificationService.getClassificationData();
    return await classificationService.getClassificationData();
  }

  Future<List<LocationModel>> getListLocation() async {
    try {
      final SharedPreferences prefs = await _prefs;
      String? tokenUser = prefs.getString("tokenKey").toString();
      _listLocation = await locationService.getLocationData(tokenUser);
      return await locationService.getLocationData(tokenUser);
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<void> getMachineName(String idLocation) async {
    final SharedPreferences prefs = await _prefs;
    String? tokenUser = prefs.getString("tokenKey").toString();
    _listMachineName =
        await machineNameService.getMachineName(idLocation, tokenUser);
  }

  Future<List<MachineNumberModel>> getMachineNumberbyId(
      String idMachine) async {
    final SharedPreferences prefs = await _prefs;
    String? tokenUser = prefs.getString("tokenKey").toString();
    _listMachineNumber =
        await machineNumberService.getMachineNumber(idMachine, tokenUser);
    return await machineNumberService.getMachineNumber(idMachine, tokenUser);
    // print(_listMachineNumber);
  }

  @override
  void initState() {
    getClassificationData();
    getListLocation();
    super.initState();
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
              child: const Text(
                "Classification",
                style: TextStyle(
                    fontFamily: 'Rubik',
                    color: Color(0xFF404446),
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 8),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () async {
                      final prefs = await _prefs;
                      setState(() {
                        isBreakDown = true;
                        isPreventive = false;
                        isInformation = false;
                        classificationIdSelected = '1';
                        prefs.setString(
                            "idClassification", classificationIdSelected);
                      });
                      print(classificationIdSelected);
                    },
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          side: isBreakDown == false
                              ? BorderSide.none
                              : BorderSide(color: Color(0xFF00AEDB))),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        width: MediaQuery.of(context).size.width * 0.26,
                        child: Center(
                          child: Text(
                            "Breakdown Maintenance",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Rubik',
                                color: isBreakDown == false
                                    ? Color(0xFF404446)
                                    : Color(0xFF00AEDB),
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final prefs = await _prefs;
                      setState(() {
                        isBreakDown = false;
                        isPreventive = true;
                        isInformation = false;
                        classificationIdSelected = '2';
                        prefs.setString(
                            "idClassification", classificationIdSelected);
                      });
                      print(classificationIdSelected);
                    },
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          side: isPreventive == false
                              ? BorderSide.none
                              : BorderSide(color: Color(0xFF00AEDB))),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        width: MediaQuery.of(context).size.width * 0.26,
                        child: Center(
                          child: Text(
                            "Preventive Maintenance",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Rubik',
                                color: isPreventive == false
                                    ? Color(0xFF404446)
                                    : Color(0xFF00AEDB),
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final prefs = await _prefs;
                      setState(() {
                        isBreakDown = false;
                        isPreventive = false;
                        isInformation = true;
                        classificationIdSelected = '3';
                        prefs.setString(
                            "idClassification", classificationIdSelected);
                      });
                      print(classificationIdSelected);
                    },
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          side: isInformation == false
                              ? BorderSide.none
                              : BorderSide(color: Color(0xFF00AEDB))),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        width: MediaQuery.of(context).size.width * 0.26,
                        child: Center(
                          child: Text(
                            "Information Maintenance",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Rubik',
                                color: isInformation == false
                                    ? Color(0xFF404446)
                                    : Color(0xFF00AEDB),
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: RichText(
                text: TextSpan(
                  text: 'Date ',
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
            InkWell(
              onTap: () => getDateFromDialog(),
              child: Container(
                margin: const EdgeInsets.only(top: 4),
                padding: const EdgeInsets.all(5),
                height: 40,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFF979C9E)),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const SizedBox(
                        width: 40,
                        height: 40,
                        child: Icon(Icons.calendar_today)),
                    Text(
                      dateSelected,
                      style: const TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                        width: 40,
                        height: 40,
                        child: Icon(Icons.arrow_drop_down))
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: RichText(
                text: TextSpan(
                  text: 'Team Member ',
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
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.all(5),
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF979C9E)),
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: TextFormField(
                controller: teamMemberController,
                onEditingComplete: () async {
                  final prefs = await _prefs;
                  if (teamMemberController.text.isNotEmpty) {
                    listTeamMember.add(teamMemberController.text);
                    print(listTeamMember);
                  }
                  prefs.setStringList("teamMember", listTeamMember);
                },
                style: const TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    suffixIcon: Icon(Icons.search),
                    hintText: 'Type name',
                    contentPadding: const EdgeInsets.only(top: 5, left: 5),
                    hintStyle: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: RichText(
                text: TextSpan(
                  text: 'Location ',
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
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.all(5),
              width: MediaQuery.of(context).size.width,
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF979C9E)),
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: FutureBuilder(
                future: getListLocation(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return DropdownButton(
                      underline:
                          DropdownButtonHideUnderline(child: Container()),
                      isExpanded: true,
                      items: _listLocation
                          .map((value) => DropdownMenuItem(
                                value: value.nama,
                                child: Text(value.nama),
                                onTap: () async {
                                  final prefs = await _prefs;
                                  setState(() {
                                    locationIdSelected = value.id;
                                  });
                                  getMachineName(value.id);
                                  // getMachineNumberbyId(machineIdSelected);
                                  prefs.setString(
                                      "locationId", locationIdSelected);
                                  print("id lokasi: $locationIdSelected");
                                },
                              ))
                          .toList(),
                      value: locationSelected,
                      hint: const Text('Select factory'),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            locationSelected = value as String;
                          });
                        }
                      },
                    );
                  }

                  return Center(
                    child: Text('Loading location...'),
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: RichText(
                text: TextSpan(
                  text: 'Machine Name ',
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
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.all(5),
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF979C9E)),
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: TextFormField(
                controller: machineNameController,
                onTap: () {
                  setState(() {
                    isTapedMachineName = !isTapedMachineName;
                  });
                },
                style: const TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    suffixIcon: Icon(Icons.search),
                    hintText: 'Type machine',
                    contentPadding: const EdgeInsets.only(top: 5, left: 5),
                    hintStyle: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
              ),
            ),
            isTapedMachineName == true
                ? Container(
                    margin: EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF979C9E)),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _listMachineName.isEmpty
                          ? 0
                          : _listMachineName.length,
                      itemBuilder: (context, i) {
                        return InkWell(
                            onTap: () async {
                              final prefs = await _prefs;
                              setState(() {
                                machineNameController = TextEditingController(
                                    text: _listMachineName[i].nama);
                                machineIdSelected = _listMachineName[i].idMesin;
                                isTapedMachineName = !isTapedMachineName;
                              });
                              prefs.setString("machineId", machineIdSelected);
                              // getMachineNumberbyId(_listMachineName[i].idMesin);
                              print("id mesin: $machineIdSelected");
                            },
                            child: Container(
                                margin: EdgeInsets.only(bottom: 8, top: 8),
                                child: Text(
                                  _listMachineName[i].nama,
                                  style: TextStyle(
                                      fontFamily: 'Rubik',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                )));
                      },
                    ),
                  )
                : Container(),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: RichText(
                text: TextSpan(
                  text: 'Machine Number ',
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
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.all(5),
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF979C9E)),
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: FutureBuilder(
                future: getMachineNumberbyId(machineIdSelected),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text("Loading Machine Number..."),
                    );
                  }

                  return DropdownButton(
                    underline: DropdownButtonHideUnderline(child: Container()),
                    isExpanded: true,
                    items: _listMachineNumber
                        .map((data) => DropdownMenuItem(
                            onTap: () async {
                              final prefs = await _prefs;
                              setState(() {
                                machineDetailIdSelected = data.id;
                              });
                              prefs.setString(
                                  "machineDetailId", machineDetailIdSelected);
                              print(
                                  "mesin detail id: $machineDetailIdSelected");
                            },
                            value: data.numberOfMachine,
                            child: Text(data.numberOfMachine,
                                style: TextStyle(
                                    fontFamily: 'Rubik',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400))))
                        .toList(),
                    value: machineNumberSelected,
                    hint: const Text('- Machine selected -'),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          machineNumberSelected = value.toString();
                        });
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
