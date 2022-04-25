// ignore_for_file: sized_box_for_whitespace, avoid_print, unnecessary_const, use_key_in_widget_constructors, prefer_const_constructors, prefer_is_empty, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:e_cm/baseurl/baseurl.dart';
import 'package:e_cm/homepage/home/component/function_header_stepper.dart';
import 'package:e_cm/homepage/home/fillnew/model/step_fill_satu_model.dart';
import 'package:e_cm/homepage/home/fillnew/stepfillnew/stepfilldua.dart';
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
import 'package:e_cm/util/shared_prefs_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:date_time_format/date_time_format.dart';

import '../../component/widget_fill_new.dart';
import '../../component/widget_line_stepper.dart';

class StepFillSatu extends StatefulWidget {
  const StepFillSatu({
    Key? key,
  }) : super(key: key);

  @override
  StepFillSatuState createState() => StepFillSatuState();
}

class StepFillSatuState extends State<StepFillSatu> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  StepFillSatuModel stepFillSatuModel = StepFillSatuModel();

  TextEditingController machineNameController = TextEditingController();
  TextEditingController machineNumberController = TextEditingController();
  TextEditingController teamMemberController = TextEditingController();
  TextEditingController factoryNameController = TextEditingController();
  TextEditingController factoryNameGroupController = TextEditingController();

  List<ClassificationModel> _listClassification = [];
  List<LocationModel> _listLocation = [];
  List<GroupAreaModel> _listGroupArea = [];
  List<MachineNameModel> _listMachineName = [];
  List<MachineNumberModel> _listMachineNumber = [];
  List<String> listTeamMember = [];
  List<MemberNameModel> listNamaMember = [];
  List<bool> warnaClassifications = [];
  Map<int, bool> mapClass = {};

  String token = SharedPrefsUtil.getTokenUser();
  String ecmIdEdit = SharedPrefsUtil.getEcmIdEdit();
  String ecmId = SharedPrefsUtil.getEcmId();
  String userId = SharedPrefsUtil.getIdUser();

  bool isTapedMachineName = false, isTappedMachineNumber = false;
  bool isBreakDown = false, isPreventive = false, isInformation = false;
  bool isTappedTeamMember = false,
      isTappedFactory = false,
      isTappedFactoryGroup = false;

  String dateSelected = 'DD/MM/YYYY';
  String locationSelected = "";
  String locationIdSelected = '';
  String locationIdGroupSelected = '';
  String machineSelected = '';
  String machineIdSelected = '';
  String machineNumberSelected = "";
  String machineDetailIdSelected = '';
  String classificationIdSelected = '';
  String members = '';
  String idMachineFromName = '';

  String namaKlasifikasiFromSession = '';

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

  void updateFillNewSatu() async {
    try {
      final result = await postStepSatuEdit(
          token,
          ecmIdEdit,
          classificationIdSelected,
          dateSelected,
          userId,
          listTeamMember,
          locationIdSelected,
          locationIdGroupSelected,
          machineIdSelected,
          machineDetailIdSelected);

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

        SharedPrefsUtil.setIdMesinRes(result['data']['id_machine'].toString());
      } else {
        Fluttertoast.showToast(
            msg: 'Kesalahan jaringan. Data gagal diperbarui.',
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

  // test call method from outside class (fillnew)
  void saveFillNewSatu() async {
    try {
      if (token.isNotEmpty &&
          classificationIdSelected.isNotEmpty &&
          dateSelected.isNotEmpty &&
          userId.isNotEmpty &&
          listTeamMember.isNotEmpty &&
          locationIdSelected.isNotEmpty &&
          locationIdGroupSelected.isNotEmpty &&
          machineIdSelected.isNotEmpty &&
          machineDetailIdSelected.isNotEmpty) {
        var result = await fillNewSatu(
            token,
            classificationIdSelected,
            dateSelected,
            userId,
            listTeamMember,
            locationIdSelected,
            locationIdGroupSelected,
            machineIdSelected,
            machineDetailIdSelected);

        SharedPrefsUtil.setEcmId(result['data']['id_ecm'].toString());
        SharedPrefsUtil.setIdMesinRes(result['data']['id_machine'].toString());

        print("ecm id from step 1: ..... " + SharedPrefsUtil.getEcmId());

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
          Get.to(StepFillDua());
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
    } catch (e) {
      print(e);
    }
  }

  void getDateFromDialog() async {
    // final prefs = await _prefs;
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
          // prefs.setString("tglStepSatu", dateSelected);
          // prefs.setString("dateBool", "1");
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
      // final SharedPreferences prefs = await _prefs;
      _listLocation = await locationService.getLocationData(token);
      return await locationService.getLocationData(token);
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<GroupAreaModel>> getListAreaGroup() async {
    try {
      _listGroupArea =
          await locationService.getAreaGroupList(token, locationIdSelected);
      return await locationService.getAreaGroupList(token, locationIdSelected);
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<MachineNameModel>> getMachineName() async {
    try {
      _listMachineName = await machineNameService.getMachineName(
          token, locationIdSelected, locationIdGroupSelected);
      print("data nama mesin: ");
      print(_listMachineName.length);
      return await machineNameService.getMachineName(
          token, locationIdSelected, locationIdGroupSelected);
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<MachineNumberModel>> getMachineNumberbyId() async {
    _listMachineNumber = await machineNumberService.getMachineNumber(
        idMachineFromName, locationIdSelected, locationIdGroupSelected, token);
    return await machineNumberService.getMachineNumber(
        idMachineFromName, locationIdSelected, locationIdGroupSelected, token);
    // print(_listMachineNumber);
  }

  Future<List<MemberNameModel>> getListMemberName() async {
    listNamaMember = await getDataMemberName(token, userId);
    return await getDataMemberName(token, userId);
  }

  void setFormStep1AfterChoosing() async {
    if ((ecmIdEdit.isNotEmpty || ecmIdEdit != "") ||
        (ecmId.isNotEmpty || ecmId != "")) {
      try {
        final result = await MyUrl().getData("ecm_step1_get?ecm_id=$ecmIdEdit");

        print("response from data step 1 edit");
        print("==========================================================");
        print(result);

        var dataStepSatu = result['data'];

        var dataTeamMember = dataStepSatu['team_member_id'] as List;
        dataTeamMember.map((e) => listTeamMember.add(e)).toList();

        setState(() {
          namaKlasifikasiFromSession = dataStepSatu['classification_name'];
          dateSelected = dataStepSatu['date'];
          teamMemberController.text = dataStepSatu['team_member'];
          factoryNameController.text = dataStepSatu['factory_name'];
          factoryNameGroupController.text = dataStepSatu['group_name'];
          machineNameController.text = dataStepSatu['machine_name'];
          machineNumberController.text = dataStepSatu['machinedetail_name'];

          classificationIdSelected =
              dataStepSatu['classification_id'].toString();

          locationIdSelected = dataStepSatu['factory'].toString();
          locationIdGroupSelected = dataStepSatu['group_factory'].toString();
          machineIdSelected = dataStepSatu['machine_id'].toString();
          machineDetailIdSelected = dataStepSatu['machinedetail_id'].toString();
        });
      } catch (e) {
        print(e);
      }
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

    // print("id ecm edit ${widget.ecmId}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF00AEDB),
        elevation: 1,
        title: Text(
          "E-CM Card",
          style: TextStyle(
              fontFamily: 'Rubik',
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () async {
              await confirmBackToHome(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  showCustomDialog(context);
                });
              },
              icon: Icon(
                Icons.info_outline,
                color: Colors.white,
              ))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StepperNumber(
                      numberStep: "1",
                      isFilled: true,
                    ),
                    LineStepper(),
                    StepperNumber(
                      numberStep: "2",
                      isFilled: false,
                    ),
                    LineStepper(),
                    StepperNumber(
                      numberStep: "3",
                      isFilled: false,
                    ),
                    LineStepper(),
                    StepperNumber(
                      numberStep: "4",
                      isFilled: false,
                    ),
                    LineStepper(),
                    StepperNumber(
                      numberStep: "5",
                      isFilled: false,
                    ),
                    LineStepper(),
                    StepperNumber(
                      numberStep: "6",
                      isFilled: false,
                    ),
                    LineStepper(),
                    StepperNumber(
                      numberStep: "7",
                      isFilled: false,
                    ),
                    LineStepper(),
                    StepperNumber(
                      numberStep: "8",
                      isFilled: false,
                    ),
                  ],
                ),
              ),

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
              // ini
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
                              return InkWell(
                                onTap: () async {
                                  final prefs = await _prefs;
                                  setState(() {
                                    mapClass.updateAll((key, value) => false);
                                    if (mapClass[i] != null) {
                                      mapClass[i] = true;
                                    }

                                    classificationIdSelected =
                                        _listClassification[i].id;

                                    SharedPrefsUtil.setNamaKlasifikasi(
                                        _listClassification[i].nama);

                                    // print("map values -> $mapClass");
                                    // prefs.setString("idClassification",
                                    //     _listClassification[i].id);
                                    // prefs.setString("namaKlasifikasi",
                                    //     _listClassification[i].nama);
                                    // prefs.setString("classBool", "1");
                                  });
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.27,
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
                                          offset: Offset(0,
                                              1), // changes position of shadow
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
                                          members =
                                              listNamaMember[i].name + ', ';
                                        });
                                        teamMemberController =
                                            TextEditingController(
                                                text: members);
                                        // listTeamMember.add(listNamaMember[i].id);
                                      } else {
                                        setState(() {
                                          members +=
                                              listNamaMember[i].name + ', ';
                                        });
                                        teamMemberController =
                                            TextEditingController(
                                                text: members);
                                        // listTeamMember.add(listNamaMember[i].id);
                                      }

                                      listTeamMember.add(listNamaMember[i].id);
                                      print(listTeamMember);
                                      // prefs.setStringList(
                                      //     "teamMember", listTeamMember);
                                      // prefs.setString("namaMember", members);

                                      // prefs.setString("teamMemberBool", "1");
                                      setState(() {
                                        isTappedTeamMember =
                                            !isTappedTeamMember;
                                      });
                                    } else {
                                      Fluttertoast.showToast(
                                          msg:
                                              'Tidak boleh pilih nama yang sama',
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
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: -5, horizontal: 10),
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
                                              text: _listLocation[i]
                                                  .valueFactory);
                                      isTappedFactory = !isTappedFactory;
                                    });
                                    // getMachineNumberbyId(machineIdSelected);
                                    // prefs.setString(
                                    //     "locationId", locationIdSelected);
                                    // prefs.setString("namaLokasi",
                                    //     _listLocation[i].valueFactory);
                                    // prefs.setString("locationBool", "1");
                                    // print("id lokasi: $locationIdSelected");

                                    // prefs.remove("locationIdGroup");
                                    // prefs.remove("machineId");
                                    // prefs.remove("machineDetailId");
                                    // prefs.remove("machineNameBool");
                                    // prefs.remove("machineDetailBool");
                                    // prefs.remove("namaGroupLokasi");
                                    // prefs.remove("namaMesin");
                                    // prefs.remove("nomorMesinDetail");

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
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: -5, horizontal: 10),
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
                                              text:
                                                  _listGroupArea[i].valueGroup);
                                      isTappedFactoryGroup =
                                          !isTappedFactoryGroup;
                                    });
                                    // getMachineNumberbyId(machineIdSelected);
                                    // prefs.setString("locationIdGroup",
                                    //     locationIdGroupSelected);
                                    // prefs.setString("namaGroupLokasi",
                                    //     _listGroupArea[i].valueGroup);
                                    // prefs.setString("locationGroupBool", "1");
                                    // print("id lokasi: $locationIdGroupSelected");

                                    // prefs.remove("machineId");
                                    // prefs.remove("machineDetailId");
                                    // prefs.remove("machineNameBool");
                                    // prefs.remove("machineDetailBool");
                                    // prefs.remove("namaMesin");
                                    // prefs.remove("nomorMesinDetail");

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
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: -5, horizontal: 10),
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
                                      // final prefs = await _prefs;
                                      // prefs.setString("machineId",
                                      //     _listMachineName[i].idMesin);
                                      // prefs.setString(
                                      //     "namaMesin", _listMachineName[i].nama);
                                      // prefs.setString("machineNameBool", "1");
                                      setState(() {
                                        idMachineFromName =
                                            _listMachineName[i].idMesin;
                                        machineNameController =
                                            TextEditingController(
                                                text: _listMachineName[i].nama);
                                        isTapedMachineName =
                                            !isTapedMachineName;
                                        machineIdSelected =
                                            _listMachineName[i].idMesin;
                                      });
                                      // prefs.remove("machineDetailId");
                                      // prefs.remove("machineDetailBool");
                                      // prefs.remove("nomorMesinDetail");

                                      machineNumberController.clear();
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15),
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
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: -5, horizontal: 10),
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
                                      // final prefs = await _prefs;
                                      // prefs.setString("machineDetailId",
                                      //     _listMachineNumber[i].id);
                                      // prefs.setString("nomorMesinDetail",
                                      //     _listMachineNumber[i].numberOfMachine);
                                      // prefs.setString("machineDetailBool", "1");

                                      setState(() {
                                        // idMachineFromName =
                                        //     _listMachineName[i].idMesin;
                                        machineNumberController =
                                            TextEditingController(
                                                text: _listMachineNumber[i]
                                                    .numberOfMachine);
                                        isTappedMachineNumber =
                                            !isTappedMachineNumber;
                                        machineDetailIdSelected =
                                            _listMachineNumber[i].id;
                                      });
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15),
                                      child: Text(_listMachineNumber[i]
                                          .numberOfMachine),
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
              Container(
                margin: EdgeInsets.only(top: 26),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        if (ecmIdEdit.isNotEmpty || ecmIdEdit != "") {
                          SharedPrefsUtil.clearEcmIdEdit();
                        }
                        Get.back();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: Color(0xFF00AEDB))),
                        child: Center(
                          child: Text(
                            "Batal",
                            style: TextStyle(
                                fontFamily: 'Rubik',
                                color: Color(0xFF00AEDB),
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => ecmIdEdit.isEmpty || ecmIdEdit == ""
                          ? saveFillNewSatu()
                          : updateFillNewSatu(),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Color(0xFF00AEDB)),
                        child: Center(
                          child: Text("Lanjut 2/8",
                              style: TextStyle(
                                  fontFamily: 'Rubik',
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400)),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
