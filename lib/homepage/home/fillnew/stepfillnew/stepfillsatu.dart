// ignore_for_file: sized_box_for_whitespace, avoid_print, unnecessary_const, use_key_in_widget_constructors, prefer_const_constructors, prefer_is_empty, prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:e_cm/homepage/home/fillnew/model/step_fill_satu_model.dart';
import 'package:e_cm/homepage/home/model/classificationmodel.dart';
import 'package:e_cm/homepage/home/model/groupareamodel.dart';
import 'package:e_cm/homepage/home/model/locationmodel.dart';
import 'package:e_cm/homepage/home/model/machinenamemodel.dart';
import 'package:e_cm/homepage/home/model/machinenumbermodel.dart';
import 'package:e_cm/homepage/home/model/membername.dart';
import 'package:e_cm/homepage/home/services/apifillnewsatu.dart';
import 'package:e_cm/homepage/home/services/classificationservice.dart';
import 'package:e_cm/homepage/home/services/locationservice.dart';
import 'package:e_cm/homepage/home/services/machinenameservice.dart';
import 'package:e_cm/homepage/home/services/machinenumberservice.dart';
import 'package:e_cm/homepage/home/services/membernameservice.dart';
import 'package:e_cm/homepage/notification/model/response_review_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:date_time_format/date_time_format.dart';

class StepFillSatu extends StatefulWidget {
  final String? ecmId;
  final StepFillSatuState stepFillSatuState = StepFillSatuState();

  void getSaveFillSatu() {
    // print("tes step 1");
    stepFillSatuState.saveFillNewSatu();
  }

  void getUpdateFillSatu() {
    stepFillSatuState.updateFillNewSatu();
  }

  StepFillSatu({Key? key, this.ecmId}) : super(key: key);

  @override
  StepFillSatuState createState() => StepFillSatuState();
}

class StepFillSatuState extends State<StepFillSatu> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  StepFillSatuModel stepFillSatuModel = StepFillSatuModel();

  String bahasa = "Bahasa Indonesia";
  bool bahasaSelected = false;

  String classification = '';
  String b_m = '';
  String p_m = '';
  String i_m = '';
  String tanggal = '';

  String hbt = '';
  String t_m = '';
  String selectmember = '';
  String factory = '';
  String select_factory = '';
  String select_factory_group = '';
  String group_area = '';
  String select_group_area = '';

  String machine_name = '';
  String type_machine = '';
  String machine_number = '';
  String type_machine_number = '';
  String cancel = '';
  String next_two = '';

  String filterTeamMember = "";

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
        classification = dataLang['step_1']['classification'];
        b_m = dataLang['step_1']['b_m'];
        p_m = dataLang['step_1']['p_m'];
        i_m = dataLang['step_1']['i_m'];
        tanggal = dataLang['step_1']['tanggal'];
        hbt = dataLang['step_1']['hbt'];
        t_m = dataLang['step_1']['t_m'];
        selectmember = dataLang['step_1']['selectmember'];
        factory = dataLang['step_1']['factory'];
        select_factory = dataLang['step_1']['select_factory'];
        select_factory_group = dataLang['step_1']['select_factory_group'];

        group_area = dataLang['step_1']['group_area'];
        select_group_area = dataLang['step_1']['select_group_area'];
        machine_name = dataLang['step_1']['machine_name'];
        type_machine = dataLang['step_1']['type_machine'];
        machine_number = dataLang['step_1']['machine_number'];
        type_machine_number = dataLang['step_1']['type_machine_number'];
        cancel = dataLang['step_1']['cancel'];
        next_two = dataLang['step_1']['next_two'];
      });
    }
  }

  void getLanguageId() async {
    var response = await rootBundle.loadString("assets/lang/lang-id.json");
    var dataLang = json.decode(response)['data'];

    if (mounted) {
      setState(() {
        classification = dataLang['step_1']['classification'];
        b_m = dataLang['step_1']['b_m'];
        p_m = dataLang['step_1']['p_m'];
        i_m = dataLang['step_1']['i_m'];
        tanggal = dataLang['step_1']['tanggal'];
        hbt = dataLang['step_1']['hbt'];
        t_m = dataLang['step_1']['t_m'];
        selectmember = dataLang['step_1']['selectmember'];
        factory = dataLang['step_1']['factory'];
        select_factory = dataLang['step_1']['select_factory'];
        select_factory_group = dataLang['step_1']['select_factory_group'];

        group_area = dataLang['step_1']['group_area'];
        select_group_area = dataLang['step_1']['select_group_area'];
        machine_name = dataLang['step_1']['machine_name'];
        type_machine = dataLang['step_1']['type_machine'];
        machine_number = dataLang['step_1']['machine_number'];
        type_machine_number = dataLang['step_1']['type_machine_number'];
        cancel = dataLang['step_1']['cancel'];
        next_two = dataLang['step_1']['next_two'];
      });
    }
  }

  void clearText() async {
    final prefs = await _prefs;
    teamMemberController.clear();

    setState(() {
      members = "";
      listTeamMember.clear();
      prefs.remove("teamMember");
      prefs.remove("namaMember");
    });
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

  TextEditingController machineNameController = TextEditingController();
  TextEditingController machineNumberController = TextEditingController();
  TextEditingController teamMemberController = TextEditingController();
  TextEditingController factoryNameController = TextEditingController();
  TextEditingController factoryNameGroupController = TextEditingController();

  bool isTapedMachineName = false, isTappedMachineNumber = false;
  bool isBreakDown = false, isPreventive = false, isInformation = false;
  bool isTappedTeamMember = false,
      isTappedFactory = false,
      isTappedFactoryGroup = false;

  String dateSelected = 'DD/MM/YYYY';
  String? locationSelected;
  String locationIdSelected = '';
  String locationIdGroupSelected = '';
  String machineSelected = '';
  String machineIdSelected = '';
  String? machineNumberSelected;
  String machineDetailIdSelected = '';
  String classificationIdSelected = '';
  String members = '';
  String idMachineFromName = '';

  String namaKlasifikasiFromSession = '';

  List<ClassificationModel> _listClassification = [];
  List<LocationModel> _listLocation = [];
  List<GroupAreaModel> _listGroupArea = [];
  List<MachineNameModel> _listMachineName = [];
  List<MachineNumberModel> _listMachineNumber = [];
  List<String> listTeamMember = [];
  List<MemberNameModel> listNamaMember = [];
  List<bool> warnaClassifications = [];
  Map<int, bool> mapClass = {};

  void updateFillNewSatu() async {
    print("update ecm step 1");
    final prefs = await _prefs;
    print(prefs.getString("ecmIdEdit"));
    // print("from prefs: ${prefs.getString("idClassification")}");

    var idClass = prefs.getString("idClassification") ?? "";
    var tglStepSatu = prefs.getString("tglStepSatu") ?? "";

    // var teamMember = prefs.getString("teamMember");

    List<String>? teamId = prefs.getStringList("teamMember") ?? [];
    var locationId = prefs.getString("locationId") ?? "";
    var locationIdGroup = prefs.getString("locationIdGroup") ?? "";
    var machineId = prefs.getString("machineId") ?? "";
    var machineDetailId = prefs.getString("machineDetailId") ?? "";

    String tokenUser = prefs.getString("tokenKey").toString();
    String idUser = prefs.getString("idKeyUser").toString();

    print(locationId);
    print(locationIdGroup);
    print(machineId);
    print(machineDetailId);

    try {
      if (tokenUser != "" &&
          idClass != "" &&
          tglStepSatu != "" &&
          idUser != "" &&
          teamId.length != 0 &&
          locationId != "" &&
          locationIdGroup != "" &&
          machineId != "" &&
          machineDetailId != "") {
        var result = await postStepSatuEdit(
            tokenUser,
            prefs.getString("ecmIdEdit") ?? "0",
            idClass,
            tglStepSatu,
            idUser,
            teamId,
            locationId,
            locationIdGroup,
            machineId,
            machineDetailId);

        print("response edit step 1");
        print(result);

        // print(result['data']['id_ecm']);
        // prefs.setString("idEcm", result['data']['id_ecm'].toString());
        prefs.setString(
            "id_machine_res", result['data']['id_machine'].toString());

        if (result['response']['status'] == 200) {
          Fluttertoast.showToast(
              msg: 'Data step 1 diperbarui',
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
      } else {
        Fluttertoast.showToast(
            msg: 'Data tidak disimpan, cek semua input field',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.white,
            fontSize: 16);
      }
    } on SocketException catch (e) {
      print(e);
    } on TimeoutException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  // test call method from outside class (fillnew)
  void saveFillNewSatu() async {
    print("save satuuu");
    final prefs = await _prefs;
    // print("from prefs: ${prefs.getString("idClassification")}");

    var idClass = prefs.getString("idClassification") ?? "";
    var tglStepSatu = prefs.getString("tglStepSatu") ?? "";

    // var teamMember = prefs.getString("teamMember");

    List<String>? teamId = prefs.getStringList("teamMember") ?? [];
    var locationId = prefs.getString("locationId") ?? "";
    var locationIdGroup = prefs.getString("locationIdGroup") ?? "";
    var machineId = prefs.getString("machineId") ?? "";
    var machineDetailId = prefs.getString("machineDetailId") ?? "";

    String tokenUser = prefs.getString("tokenKey").toString();
    String idUser = prefs.getString("idKeyUser").toString();

    print(locationId);
    print(locationIdGroup);
    print(machineId);
    print(machineDetailId);

    try {
      if (tokenUser != "" &&
          idClass != "" &&
          tglStepSatu != "" &&
          idUser != "" &&
          teamId.length != 0 &&
          locationId != "" &&
          locationIdGroup != "" &&
          machineId != "" &&
          machineDetailId != "") {
        var result = await fillNewSatu(tokenUser, idClass, tglStepSatu, idUser,
            teamId, locationId, locationIdGroup, machineId, machineDetailId);

        print(result['response']['status']);
        print(result['data']['id_ecm']);
        prefs.setString("idEcm", result['data']['id_ecm'].toString());
        prefs.setString(
            "id_machine_res", result['data']['id_machine'].toString());

        print(
            "ecm id from step 1: ..... " + prefs.getString("idEcm").toString());

        if (result['response']['status'] == 200) {
          Fluttertoast.showToast(
              msg: 'Data step 1 disimpan',
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
      } else {
        Fluttertoast.showToast(
            msg: 'Data tidak disimpan, cek semua input field',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.white,
            fontSize: 16);
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
            lastDate: DateTime(2030))
        .then((value) {
      if (value != null) {
        DateTime _fromDate = DateTime.now();
        _fromDate = value;
        final String date = _fromDate.format("Y-m-d");

        // String date = _fromDate.format("Y-m-d");
        setState(() {
          dateSelected = date;
          prefs.setString("tglStepSatu", dateSelected);
          prefs.setString("dateBool", "1");
        });
        print(dateSelected);
      }
    });
  }

  Future<List<ClassificationModel>> getClassificationData() async {
    if (_listClassification.isNotEmpty) {
      return await classificationService.getClassificationData();
    }
    _listClassification = await classificationService.getClassificationData();

    print("is list classification empty ? ${_listClassification.isEmpty}");
    for (int i = 0; i < _listClassification.length; i++) {
      warnaClassifications.add(false);
      mapClass[i] = false;

      if (namaKlasifikasiFromSession == _listClassification[i].nama) {
        print(_listClassification[i].nama);
        mapClass[i] = true;
      }
    }

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

  Future<List<GroupAreaModel>> getListAreaGroup() async {
    try {
      final SharedPreferences prefs = await _prefs;
      String? tokenUser = prefs.getString("tokenKey").toString();
      String idLokasi = prefs.getString("locationId") ?? "";
      print(idLokasi);
      _listGroupArea =
          await locationService.getAreaGroupList(tokenUser, idLokasi);
      return await locationService.getAreaGroupList(tokenUser, idLokasi);
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<MachineNameModel>> getMachineName() async {
    try {
      final SharedPreferences prefs = await _prefs;
      String? tokenUser = prefs.getString("tokenKey").toString();
      String idGroupArea = prefs.getString("locationIdGroup") ?? "";
      String idLokasi = prefs.getString("locationId") ?? "";
      _listMachineName = await machineNameService.getMachineName(
          tokenUser, idLokasi, idGroupArea);
      print("data nama mesin: ");
      print(_listMachineName.length);
      return await machineNameService.getMachineName(
          tokenUser, idLokasi, idGroupArea);
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<MachineNumberModel>> getMachineNumberbyId() async {
    final SharedPreferences prefs = await _prefs;
    String? tokenUser = prefs.getString("tokenKey").toString();
    String idGroupArea = prefs.getString("locationIdGroup") ?? "";
    String idLokasi = prefs.getString("locationId") ?? "";
    _listMachineNumber = await machineNumberService.getMachineNumber(
        idMachineFromName, idLokasi, idGroupArea, tokenUser);
    return await machineNumberService.getMachineNumber(
        idMachineFromName, idLokasi, idGroupArea, tokenUser);
    // print(_listMachineNumber);
  }

  Future<List<MemberNameModel>> getListMemberName() async {
    final SharedPreferences prefs = await _prefs;
    String tokenUser = prefs.getString("tokenKey").toString();
    String idUser = prefs.getString("idKeyUser") ?? "";
    listNamaMember = await getDataMemberName(tokenUser, idUser);
    return await getDataMemberName(tokenUser, idUser);
  }

  void setFormStep1AfterChoosing() async {
    final prefs = await _prefs;

    print("id ecm for edit: ${widget.ecmId}");

    String tokenUser = prefs.getString("tokenKey").toString();

    String? namaKlasifikasi = prefs.getString("namaKlasifikasi");
    String? tglStepSatu = prefs.getString("tglStepSatu");
    String? namaMember = prefs.getString("namaMember");
    String? namaLokasi = prefs.getString("namaLokasi");
    String? namaGroupLokasi = prefs.getString("namaGroupLokasi");
    String? namaMesin = prefs.getString("namaMesin");
    String? nomorMesin = prefs.getString("nomorMesinDetail");

    if (namaKlasifikasi != null &&
        tglStepSatu != null &&
        namaMember != null &&
        namaLokasi != null &&
        namaGroupLokasi != null &&
        namaMesin != null &&
        nomorMesin != null) {
      setState(() {
        namaKlasifikasiFromSession = namaKlasifikasi;
        dateSelected = tglStepSatu;
        teamMemberController = TextEditingController(text: namaMember);
        factoryNameController = TextEditingController(text: namaLokasi);
        factoryNameGroupController =
            TextEditingController(text: namaGroupLokasi);
        machineNameController = TextEditingController(text: namaMesin);
        machineNumberController = TextEditingController(text: nomorMesin);
      });
    } else if (widget.ecmId != null) {
      prefs.setString("ecmIdEdit", widget.ecmId ?? "0");
      var result = await getStepSatuDataForEdit(widget.ecmId ?? "0", tokenUser);

      if (result['response']['status'] == 200) {
        var dataEcmStep1 = result['data'];
        if (dataEcmStep1 != null) {
          // set data preference untuk data update step 1

          // prefs.setString("classBool", "1");
          // prefs.setString("dateBool", "1");
          // prefs.setString("teamMemberBool", "1");
          // prefs.setString("locationBool", "1");
          // prefs.setString("machineNameBool", "1");
          // prefs.setString("machineDetailBool", "1");

          // listTeamMember =
          //     List<String>.from(dataEcmStep1['team_member_id'] as List);

          // prefs.setString(
          //     "idClassification", dataEcmStep1['classification_id'].toString());
          // prefs.setString("tglStepSatu", dataEcmStep1['date']);
          // prefs.setStringList("teamMember", listTeamMember);
          // prefs.setString("locationId", dataEcmStep1['factory'].toString());
          // prefs.setString(
          //     "locationIdGroup", dataEcmStep1['group_factory'].toString());
          // prefs.setString("machineId", dataEcmStep1['machine_id'].toString());
          // prefs.setString(
          //     "machineDetailId", dataEcmStep1['machinedetail_id'].toString());

          setState(() {
            namaKlasifikasiFromSession = dataEcmStep1['classification_name'];
            dateSelected = dataEcmStep1['date'];
            teamMemberController =
                TextEditingController(text: dataEcmStep1['team_member']);
            factoryNameController =
                TextEditingController(text: dataEcmStep1['factory_name']);
            factoryNameGroupController =
                TextEditingController(text: dataEcmStep1['group_name']);
            machineNameController =
                TextEditingController(text: dataEcmStep1['machine_name']);
            machineNumberController =
                TextEditingController(text: dataEcmStep1['machinedetail_name']);
          });
        }
      }
    }
  }

  void getStep1DataForEdit() async {
    final prefs = await _prefs;
    String tokenUser = prefs.getString("tokenKey").toString();
    var result = await getStep1Data(widget.ecmId!, tokenUser);

    if (result['response']['status'] == 200) {
      setState(() {
        stepFillSatuModel = StepFillSatuModel.fromJson(result['data']);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setFormStep1AfterChoosing();
    getClassificationData();
    getListLocation();
    getListAreaGroup();
    getMachineName();
    setBahasa();
    setLang();

    print("id ecm edit ${widget.ecmId}");
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
                child: RichText(
                  text: TextSpan(
                    text: classification,
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
                )),
            Container(
              margin: const EdgeInsets.only(top: 8),
              width: MediaQuery.of(context).size.width,
              height: 70,
              child: FutureBuilder(
                future: getClassificationData(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text("Memuat Klasifikasi"),
                    );
                  }

                  return _listClassification.isEmpty
                      ? Container(
                          child: Center(
                            child: Text("No data classifications"),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: _listClassification.length,
                          itemBuilder: (context, i) {
                            // if (namaKlasifikasiFromSession ==
                            //     _listClassification[i].nama) {
                            //   print(_listClassification[i].nama);
                            //   mapClass[i] = true;
                            // }

                            return InkWell(
                              onTap: () async {
                                final prefs = await _prefs;
                                setState(() {
                                  mapClass.updateAll((key, value) => false);
                                  if (mapClass[i] != null) {
                                    mapClass[i] = true;
                                  }

                                  print("map values -> $mapClass");
                                  prefs.setString("idClassification",
                                      _listClassification[i].id);
                                  prefs.setString("namaKlasifikasi",
                                      _listClassification[i].nama);
                                  prefs.setString("classBool", "1");
                                });
                                // Fluttertoast.showToast(
                                //     msg:
                                //         'Anda memilih ${_listClassification[i].nama}',
                                //     toastLength: Toast.LENGTH_LONG,
                                //     gravity: ToastGravity.BOTTOM,
                                //     timeInSecForIosWeb: 2,
                                //     backgroundColor: Colors.greenAccent,
                                //     textColor: Colors.white,
                                //     fontSize: 16);
                                // print(prefs.getString("idClassification"));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.27,
                                height: 50,
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    border: Border.all(
                                        color: mapClass[i] == false
                                            ? Colors.white
                                            : Color(0xFF00AEDB)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                        offset: Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ]),
                                child: Center(
                                  child: Text(
                                    _listClassification[i].nama,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'Rubik',
                                        color: mapClass[i] == false
                                            ? Color(0xFF404446)
                                            : Color(0xFF00AEDB),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: RichText(
                text: TextSpan(
                  text: tanggal,
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
                    Container(
                      child: Row(
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
                        ],
                      ),
                    ),
                    const SizedBox(
                        width: 40,
                        height: 40,
                        child: Icon(Icons.arrow_drop_down))
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  child: RichText(
                    text: TextSpan(
                      text: t_m,
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
                    onTap: () {
                      clearText();
                    },
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          color: Colors.red.shade100,
                          border: Border.all(color: Colors.black12),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "Hapus Team Member",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            color: Colors.red,
                            fontSize: 10,
                            fontWeight: FontWeight.w400),
                      ),
                    )),
              ],
            ),
            TextFormField(
              controller: teamMemberController,
              showCursor: true,
              readOnly: true,
              onTap: () {
                setState(() {
                  isTappedTeamMember = !isTappedTeamMember;
                  print(teamMemberController);
                });
              },
              onEditingComplete: () async {},
              style: const TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: const Color(0xFF979C9E))),
                  suffixIcon: Icon(Icons.search),
                  hintText: 'Pilih member',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: -5, horizontal: 10),
                  hintStyle: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 14,
                      fontWeight: FontWeight.w400)),
            ),
            isTappedTeamMember == false
                ? Container()
                : Container(
                    margin: const EdgeInsets.only(top: 5),
                    width: MediaQuery.of(context).size.width,
                    height: 180,
                    child: FutureBuilder(
                      future: getListMemberName(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: Text("Memuat member"),
                          );
                        }

                        return ListView.builder(
                          shrinkWrap: true,
                          // physics: NeverScrollableScrollPhysics(),
                          itemCount: listNamaMember.isEmpty
                              ? 0
                              : listNamaMember.length,
                          itemBuilder: (context, i) {
                            return InkWell(
                              onTap: () async {
                                final prefs = await _prefs;
                                if (listTeamMember.length != 6) {
                                  if (!listTeamMember
                                      .contains(listNamaMember[i].id)) {
                                    if (members.isEmpty) {
                                      setState(() {
                                        members = listNamaMember[i].name + ', ';
                                      });
                                      teamMemberController =
                                          TextEditingController(text: members);
                                      // listTeamMember.add(listNamaMember[i].id);
                                    } else {
                                      setState(() {
                                        members +=
                                            listNamaMember[i].name + ', ';
                                      });
                                      teamMemberController =
                                          TextEditingController(text: members);
                                      // listTeamMember.add(listNamaMember[i].id);
                                    }

                                    listTeamMember.add(listNamaMember[i].id);
                                    print(listTeamMember);
                                    prefs.setStringList(
                                        "teamMember", listTeamMember);
                                    prefs.setString("namaMember", members);

                                    prefs.setString("teamMemberBool", "1");
                                    setState(() {
                                      isTappedTeamMember = !isTappedTeamMember;
                                    });
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: 'Tidak boleh pilih nama yang sama',
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 2,
                                        backgroundColor: Colors.greenAccent,
                                        textColor: Colors.white,
                                        fontSize: 16);
                                  }
                                } else {
                                  Fluttertoast.showToast(
                                      msg: 'Member maksimal 6',
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 2,
                                      backgroundColor: Colors.greenAccent,
                                      textColor: Colors.white,
                                      fontSize: 16);
                                }
                              },
                              child: Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(listNamaMember[i].name)),
                            );
                          },
                        );
                      },
                    ),
                  ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: RichText(
                text: TextSpan(
                  text: factory,
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
            TextFormField(
              readOnly: true,
              showCursor: true,
              controller: factoryNameController,
              onTap: () {
                setState(() {
                  isTappedFactory = !isTappedFactory;
                });
              },
              style: const TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF979C9E))),
                  hintText: select_factory,
                  suffixIcon: Icon(Icons.arrow_drop_down),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: -5, horizontal: 10),
                  hintStyle: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 14,
                      fontWeight: FontWeight.w400)),
            ),
            isTappedFactory == false
                ? Container()
                : Container(
                    margin: const EdgeInsets.only(top: 16),
                    width: MediaQuery.of(context).size.width,
                    height: 180,
                    child: FutureBuilder(
                      future: getListLocation(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: Text("Memuat data factory"),
                          );
                        }

                        return ListView.builder(
                          // physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _listLocation.length,
                          itemBuilder: (context, i) {
                            return InkWell(
                                onTap: () async {
                                  final prefs = await _prefs;
                                  setState(() {
                                    locationIdSelected =
                                        _listLocation[i].enumId;
                                    factoryNameController =
                                        TextEditingController(
                                            text:
                                                _listLocation[i].valueFactory);
                                    isTappedFactory = !isTappedFactory;
                                  });
                                  // getMachineNumberbyId(machineIdSelected);
                                  prefs.setString(
                                      "locationId", locationIdSelected);
                                  prefs.setString("namaLokasi",
                                      _listLocation[i].valueFactory);
                                  prefs.setString("locationBool", "1");
                                  print("id lokasi: $locationIdSelected");

                                  prefs.remove("locationIdGroup");
                                  prefs.remove("machineId");
                                  prefs.remove("machineDetailId");
                                  prefs.remove("machineNameBool");
                                  prefs.remove("machineDetailBool");
                                  prefs.remove("namaGroupLokasi");
                                  prefs.remove("namaMesin");
                                  prefs.remove("nomorMesinDetail");

                                  factoryNameGroupController.clear();
                                  machineNameController.clear();
                                  machineNumberController.clear();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(_listLocation[i].valueFactory),
                                ));
                          },
                        );
                      },
                    ),
                  ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: RichText(
                text: TextSpan(
                  text: group_area,
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
            TextFormField(
              showCursor: true,
              readOnly: true,
              controller: factoryNameGroupController,
              onTap: () {
                setState(() {
                  isTappedFactoryGroup = !isTappedFactoryGroup;
                });
              },
              style: const TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF979C9E))),
                  hintText: select_factory_group,
                  suffixIcon: Icon(Icons.arrow_drop_down),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: -5, horizontal: 10),
                  hintStyle: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 14,
                      fontWeight: FontWeight.w400)),
            ),
            isTappedFactoryGroup == false
                ? Container()
                : Container(
                    width: MediaQuery.of(context).size.width,
                    height: 180,
                    child: FutureBuilder(
                      future: getListAreaGroup(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: Text("Memuat data factory group"),
                          );
                        }

                        return ListView.builder(
                          // physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _listGroupArea.length,
                          itemBuilder: (context, i) {
                            return InkWell(
                                onTap: () async {
                                  final prefs = await _prefs;
                                  setState(() {
                                    locationIdGroupSelected =
                                        _listGroupArea[i].enumId;
                                    factoryNameGroupController =
                                        TextEditingController(
                                            text: _listGroupArea[i].valueGroup);
                                    isTappedFactoryGroup =
                                        !isTappedFactoryGroup;
                                  });
                                  // getMachineNumberbyId(machineIdSelected);
                                  prefs.setString("locationIdGroup",
                                      locationIdGroupSelected);
                                  prefs.setString("namaGroupLokasi",
                                      _listGroupArea[i].valueGroup);
                                  prefs.setString("locationGroupBool", "1");
                                  print("id lokasi: $locationIdGroupSelected");

                                  prefs.remove("machineId");
                                  prefs.remove("machineDetailId");
                                  prefs.remove("machineNameBool");
                                  prefs.remove("machineDetailBool");
                                  prefs.remove("namaMesin");
                                  prefs.remove("nomorMesinDetail");

                                  machineNameController.clear();
                                  machineNumberController.clear();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(_listGroupArea[i].valueGroup),
                                ));
                          },
                        );
                      },
                    ),
                  ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: RichText(
                text: TextSpan(
                  text: machine_name,
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
            TextFormField(
              readOnly: true,
              showCursor: true,
              controller: machineNameController,
              onTap: () {
                setState(() {
                  isTapedMachineName = !isTapedMachineName;
                });
              },
              onChanged: (value) async {
                final prefs = await _prefs;
                // prefs.setString("machineId", value);
                prefs.setString("machineNameBool", "1");
              },
              style: const TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF979C9E))),
                  hintText: type_machine,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: -5, horizontal: 10),
                  hintStyle: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 14,
                      fontWeight: FontWeight.w400)),
            ),
            isTapedMachineName == false
                ? Container()
                : Container(
                    width: MediaQuery.of(context).size.width,
                    height: 180,
                    padding: EdgeInsets.all(8),
                    child: FutureBuilder(
                      future: getMachineName(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            // physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _listMachineName.length,
                            itemBuilder: (context, i) {
                              return InkWell(
                                  onTap: () async {
                                    final prefs = await _prefs;
                                    prefs.setString("machineId",
                                        _listMachineName[i].idMesin);
                                    prefs.setString(
                                        "namaMesin", _listMachineName[i].nama);
                                    prefs.setString("machineNameBool", "1");
                                    setState(() {
                                      idMachineFromName =
                                          _listMachineName[i].idMesin;
                                      machineNameController =
                                          TextEditingController(
                                              text: _listMachineName[i].nama);
                                      isTapedMachineName = !isTapedMachineName;
                                    });
                                    prefs.remove("machineDetailId");
                                    prefs.remove("machineDetailBool");
                                    prefs.remove("nomorMesinDetail");

                                    machineNumberController.clear();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: Text(_listMachineName[i].nama),
                                  ));
                            },
                          );
                        }

                        return Center(
                          child: Text("Memuat nama mesin"),
                        );
                      },
                    ),
                  ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: RichText(
                text: TextSpan(
                  text: 'Nomor Mesin ',
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
            TextFormField(
              readOnly: true,
              showCursor: true,
              controller: machineNumberController,
              onTap: () {
                setState(() {
                  isTappedMachineNumber = !isTappedMachineNumber;
                });
              },
              onChanged: (value) async {
                final prefs = await _prefs;
                // prefs.setString("machineDetailId", value);
                prefs.setString("machineDetailBool", "1");
              },
              style: const TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF979C9E))),
                  hintText: type_machine_number,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: -5, horizontal: 10),
                  hintStyle: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 14,
                      fontWeight: FontWeight.w400)),
            ),
            isTappedMachineNumber == false
                ? Container()
                : Container(
                    width: MediaQuery.of(context).size.width,
                    height: 180,
                    padding: EdgeInsets.all(8),
                    child: FutureBuilder(
                      future: getMachineNumberbyId(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            // physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _listMachineNumber.length,
                            itemBuilder: (context, i) {
                              return InkWell(
                                  onTap: () async {
                                    final prefs = await _prefs;
                                    prefs.setString("machineDetailId",
                                        _listMachineNumber[i].id);
                                    prefs.setString("nomorMesinDetail",
                                        _listMachineNumber[i].numberOfMachine);
                                    prefs.setString("machineDetailBool", "1");
                                    setState(() {
                                      // idMachineFromName =
                                      //     _listMachineName[i].idMesin;
                                      machineNumberController =
                                          TextEditingController(
                                              text: _listMachineNumber[i]
                                                  .numberOfMachine);
                                      isTappedMachineNumber =
                                          !isTappedMachineNumber;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: Text(
                                        _listMachineNumber[i].numberOfMachine),
                                  ));
                            },
                          );
                        }

                        return Center(
                          child: Text("Memuat nomor mesin"),
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
