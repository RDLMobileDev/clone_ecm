// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, unnecessary_const, avoid_unnecessary_containers

import 'dart:convert';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:e_cm/homepage/home/fillnew/fillnew.dart';
import 'package:e_cm/homepage/home/model/allusermodel.dart';
import 'package:e_cm/homepage/home/model/getstep6model.dart';
import 'package:e_cm/homepage/home/model/vendorstep6model.dart';
import 'package:e_cm/homepage/home/services/apifillnewenam.dart';
import 'package:e_cm/homepage/home/services/apifillnewenamget.dart';
import 'package:e_cm/homepage/home/services/getsemuauser.dart';
import 'package:e_cm/util/shared_prefs_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StepFillEnam extends StatefulWidget {
  final _StepFillEnamState stepFillEnamState = _StepFillEnamState();

  void getSaveFillEnam() {
    stepFillEnamState.postFillEnam();
  }

  @override
  _StepFillEnamState createState() => _StepFillEnamState();
}

class _StepFillEnamState extends State<StepFillEnam> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  TextEditingController vendorPriceController = TextEditingController();
  TextEditingController breakHoursController = TextEditingController();
  TextEditingController breakMinutesController = TextEditingController();

  String tokenUser = SharedPrefsUtil.getTokenUser();
  String ecmId = SharedPrefsUtil.getEcmId();
  String ecmIdEdit = SharedPrefsUtil.getEcmIdEdit();
  String ecmitemId = SharedPrefsUtil.getIdEcmItem();
  String userId = SharedPrefsUtil.getIdUser();

  String bahasa = "Bahasa Indonesia";
  bool bahasaSelected = false;
  bool isTapVendor = false;
  bool breakTimeFill = false;

  String improvement = '';
  String name = '';
  String type_name = '';
  String idea = '';

  String type_idea = '';
  String working_time = '';
  String repair = '';
  String breaktime = '';

  String bm = '';
  String in_house = '';
  String cost = 'Cost';
  String out_house = '';

  String idUsernameIdea = '-';

  String prefLineStopH = '0',
      prefLineStopM = '0',
      prefNewLineStop = '0',
      prefInhouseM = '',
      prefInHouse = '',
      prefVendor = '',
      prefOutHouse = '0',
      adminCost = '0';
  bool btnCheck = false;
  String back = '';

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
        improvement = dataLang['step_6']['improvement'];
        name = dataLang['step_6']['name'];
        type_name = dataLang['step_6']['type_name'];
        idea = dataLang['step_6']['idea'];
        type_idea = dataLang['step_6']['type_idea'];
        working_time = dataLang['step_6']['working_time'];
        repair = dataLang['step_6']['repair'];
        breaktime = dataLang['step_6']['breaktime'];
        bm = dataLang['step_6']['bm'];
        in_house = dataLang['step_6']['in_house'];
        cost = dataLang['step_6']['cost'];
        out_house = dataLang['step_6']['out_house'];
        back = dataLang['step_6']['back'];
      });
    }
  }

  void getLanguageId() async {
    var response = await rootBundle.loadString("assets/lang/lang-id.json");
    var dataLang = json.decode(response)['data'];

    if (mounted) {
      setState(() {});
      improvement = dataLang['step_6']['improvement'];
      name = dataLang['step_6']['name'];
      type_name = dataLang['step_6']['type_name'];
      idea = dataLang['step_6']['idea'];
      type_idea = dataLang['step_6']['type_idea'];
      working_time = dataLang['step_6']['working_time'];
      repair = dataLang['step_6']['repair'];
      breaktime = dataLang['step_6']['breaktime'];
      bm = dataLang['step_6']['bm'];
      in_house = dataLang['step_6']['in_house'];
      cost = dataLang['step_6']['cost_'];
      out_house = dataLang['step_6']['out_house'];
      back = dataLang['step_6']['back'];
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

  void clearText() async {
    final prefs = await _prefs;
    userNameController.clear();

    // setState(() {
    //   members = "";
    //   listTeamMember.clear();
    //   prefs.remove("teamMember");
    //   prefs.remove("namaMember");
    // });
  }

  List<AllUserModel> _listAllUser = [];
  String userSelected = '';
  TextEditingController userNameController = TextEditingController();
  TextEditingController ideaController = TextEditingController();
  TextEditingController breakController = TextEditingController();
  TextEditingController costOutHouseController = TextEditingController();
  TextEditingController outHouseHController = TextEditingController();
  TextEditingController outHouseMpController = TextEditingController();
  bool isTapedUserName = false;
  StepEnamModel stepEnamModel = StepEnamModel();

  List<VendorStep6Model> listVendor = [];

  int _counter = 0;
  int _counterMinutes = 45;
  int _limitIncreamentH = 0;
  int _limitIncreamentM = 0;
  int _lineStopH = 0;
  int _newLineStopH = 0;
  int _lineStopM = 0;
  int _mp = 0;
  int _costInHouse = 0;
  int _costOutHouse = 0;
  // Future<List<AllUserModel>> getAllUserData() async {
  //   try {
  //     final SharedPreferences prefs = await _prefs;
  //     String? tokenUser = prefs.getString("tokenKey").toString();
  //     _listAllUser =
  //         (await allUserService.getAllUser(tokenUser)).cast<AllUserModel>();
  //     // return await allUserService.getUserData(tokenUser);
  //     print(_listAllUser);
  //     return (await allUserService.getAllUser(tokenUser)).cast<AllUserModel>();
  //   } catch (e) {
  //     print(e);
  //     return [];
  //   }
  // }

  void _incrementCounter(String value) async {
    final SharedPreferences prefs = await _prefs;
    if (value.isNotEmpty) {
      setState(() {
        // if (_counter <= _limitIncreamentH - 1) {
        _counter = int.parse(value);
        if (_counter > _limitIncreamentH) {
          Fluttertoast.showToast(
              msg: "Tidak bisa melebihi limit",
              backgroundColor: Colors.redAccent,
              textColor: Colors.white);
        } else {
          _lineStopH = _limitIncreamentH - _counter;
          resultCostInHouse();
        }

        // } else {
        //   _counter = _counter;
        // }
        // resultLineStop();
      });
      prefs.setString("breaks", _counter.toString());
      prefs.setString("breakHours", _counter.toString());
    } else {
      setState(() {
        _counter = 0;
        _lineStopH = _limitIncreamentH;
        resultCostInHouse();
        // if (_counter <= _limitIncreamentH - 1) {
        //   _counter = 0;
        // } else {
        //   _counter = _counter;
        // }
        // resultLineStop();
        // resultCostInHouse();
      });
      prefs.setString("breaks", _counter.toString());
      prefs.setString("breakHours", _counter.toString());
    }
  }

  void _decreamentCounter() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      if (_counter > 0) {
        _counter--;
      } else {
        _counter = _counter;
      }
      resultLineStop();
      resultCostInHouse();
    });
    prefs.setString("breaks", _counter.toString());
    prefs.setString("breakHours", _counter.toString());
  }

  void _incrementCounterMinutes(String value) async {
    final SharedPreferences prefs = await _prefs;
    if (value.isNotEmpty) {
      setState(() {
        _counterMinutes = int.parse(value);
        if (_counterMinutes < 60) {
          if (_counterMinutes > _limitIncreamentM) {
            _lineStopH = _lineStopH - 1;
            _lineStopM = (_limitIncreamentM + 60) - _counterMinutes;
            resultCostInHouse();
          } else {
            _lineStopM = _limitIncreamentM - _counterMinutes;
            resultCostInHouse();
          }
        } else {
          Fluttertoast.showToast(
              msg: "Tidak bisa melebihi 59 menit",
              backgroundColor: Colors.redAccent,
              textColor: Colors.white);
        }

        // if (_counterMinutes < _limitIncreamentM - 1) {
        //   _counterMinutes++;
        // } else {
        //   _counterMinutes = _counterMinutes;
        // }
        // if (_limitIncreamentM == 0) {
        //   if (_counterMinutes < 60 && _counter <= _limitIncreamentH - 1) {
        //     _counterMinutes = int.parse(value);
        //     if (_counterMinutes == 60) {
        //       _counter = _counter + int.parse(value);
        //       _counterMinutes = 0;
        //     }
        //   } else {
        //     _counterMinutes = _counterMinutes;
        //   }
        // } else if (_limitIncreamentM != 0) {
        //   if (_counter < _limitIncreamentH ||
        //       _counterMinutes < _limitIncreamentM) {
        //     if (_counterMinutes == 60) {
        //       _counterMinutes = 0;
        //       _counter += int.parse(value);
        //     }

        //     _counterMinutes += int.parse(value);
        //   } else {
        //     _counterMinutes = _counterMinutes;
        //   }
        // }
        // resultLineStop();
        // resultCostInHouse();
      });
      prefs.setString("breaks", _counter.toString());
      prefs.setString("breakMinutes", _counterMinutes.toString());
    } else {
      setState(() {
        _counterMinutes = 0;
        _lineStopM = _limitIncreamentM;
        resultCostInHouse();
      });
      prefs.setString("breaks", _counter.toString());
      prefs.setString("breakMinutes", _counterMinutes.toString());
    }
  }

  void hitungLineStop() async {
    final SharedPreferences prefs = await _prefs;
    // _incrementCounter(value);
    // decre
    setState(() {
      if (breakHoursController.text.isNotEmpty &&
          breakMinutesController.text.isNotEmpty) {
        setState(() {
          // if (_counter <= _limitIncreamentH - 1) {
          _counter = int.parse(breakHoursController.text);
          if (_counter > _limitIncreamentH) {
            _lineStopH = 1;

            Fluttertoast.showToast(
                msg: "Tidak bisa melebihi Work Time",
                backgroundColor: Colors.redAccent,
                textColor: Colors.white);
          } else {
            _lineStopH = _limitIncreamentH - _counter;
            resultCostInHouse();
          }

          if (breakMinutesController.text.isEmpty) {
            _counterMinutes = 0;
          } else {
            _counterMinutes = int.parse(breakMinutesController.text);
          }
          if (_counterMinutes < 60) {
            if (_counterMinutes > _limitIncreamentM) {
              if (_counter == _limitIncreamentH &&
                  _counterMinutes > _limitIncreamentM) {
                _lineStopH = _lineStopH;
              } else {
                _lineStopH = _lineStopH - 1;
              }
              _lineStopM = (_limitIncreamentM + 60) - _counterMinutes;
              resultCostInHouse();
            } else {
              _lineStopM = _limitIncreamentM - _counterMinutes;
              resultCostInHouse();
            }
          } else {
            Fluttertoast.showToast(
                msg: "Tidak bisa melebihi 59 menit",
                backgroundColor: Colors.redAccent,
                textColor: Colors.white);
          }
          // } else {
          //   _counter = _counter;
          // }
          // resultLineStop();
          breakTimeFill = true;
        });
        // prefs.setString("breaks", _counter.toString());
        // prefs.setString("breakHours", _counter.toString());
        // prefs.setString("breaks", _counter.toString());
        // prefs.setString("breakMinutes", _counterMinutes.toString());
        // prefs.setString("lineStopH", _lineStopH.toString());
        // prefs.setString("lineStopM", _lineStopM.toString());
        // prefs.setString("breakTimeBool", "1");
        // prefs.setString(
        //     "ttlLineStop", _lineStopH.toString() + ":" + _lineStopM.toString());
      } else if (breakHoursController.text == "0" &&
          breakMinutesController.text == "0") {
        setState(() {
          _counter = 0;
          _lineStopH = _limitIncreamentH;
          resultCostInHouse();
          _counterMinutes = 0;
          _lineStopM = _limitIncreamentM;
          resultCostInHouse();
          // if (_counter <= _limitIncreamentH - 1) {
          //   _counter = 0;
          // } else {
          //   _counter = _counter;
          // }
          // resultLineStop();
          // resultCostInHouse();
          breakTimeFill = true;
        });
        // prefs.setString("breaks", _counter.toString());
        // prefs.setString("breakHours", _counter.toString());
        // prefs.setString("breaks", _counter.toString());
        // prefs.setString("breakMinutes", _counterMinutes.toString());

        // prefs.setString("lineStopH", _newLineStopH.toString());
        // prefs.setString("lineStopM", _lineStopM.toString());
        // prefs.setString("breakTimeBool", "1");
        // prefs.setString(
        //     "ttlLineStop", _lineStopH.toString() + ":" + _lineStopM.toString());
      } else {
        Fluttertoast.showToast(
            msg: 'Waktu istirahat masih kosong',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.white,
            fontSize: 16);
        prefs.remove("breakTimeBool");
      }
      print(_lineStopH);
      print(_lineStopM);
    });
  }

  void _decreamentCounterMinutes() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      if (_counterMinutes > 0) {
        _counterMinutes--;
      } else {
        _counterMinutes = _counterMinutes;
      }
      resultLineStop();
      resultCostInHouse();
    });
    prefs.setString("breaks", _counter.toString());
    prefs.setString("breakMinutes", _counterMinutes.toString());
  }

  void resultLineStop() {
    setState(() {
      if (_counterMinutes > 0 && _counter == _limitIncreamentH - 1) {
        _lineStopH = 0;
      } else {
        _lineStopH = _limitIncreamentH - _counter;
      }

      if (_limitIncreamentM == 0) {
        _lineStopM = 60 - _counterMinutes;
        if (_lineStopM == 60) {
          // _lineStopH = 0;
          _lineStopM = 0;
        }
      } else if (_limitIncreamentM != 0) {
        _lineStopM = _limitIncreamentM - _counterMinutes;
      }
    });
  }

  void resultCostInHouse() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      // if (_lineStopM < 30) {
      //   _newLineStopH = _lineStopH;
      //   _costInHouse = (_newLineStopH * _mp * 60000) + 30000;
      // } else {
      //   _newLineStopH = _lineStopH + 1;
      //   _costInHouse = (_newLineStopH * _mp * 60000) + 30000;
      // }
      _newLineStopH = _lineStopH * 60;
      _costInHouse = ((_newLineStopH + _lineStopM) * 1000) +
          int.parse(stepEnamModel.adminCost ?? "0");
      prefs.setString("costInHouse", _costInHouse.toString());
      prefs.setString("newLineStopH", (_newLineStopH + _lineStopM).toString());
      print("===_newLineStopH ===");
      print(_newLineStopH);
    });
  }

  void resultCostOutHouse(String text) async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      if (outHouseHController.text == '' ||
          outHouseMpController.text == '' ||
          text == '') {
        int outH = 0;
        int outMp = 0;
        int outCost = 0;

        _costOutHouse = outH * outMp * outCost;
      } else {
        String newOutHouseCost = text.replaceAll(".", "");
        int outH = int.parse(outHouseHController.text);
        int outMp = int.parse(outHouseMpController.text);
        int outCost = int.parse(newOutHouseCost);

        _costOutHouse = outH * outMp * outCost;
      }
      prefs.setString(
          "ttlCostOutHouse", _costOutHouse.toString().replaceAll(".", ""));
      print("===costOutHouse ===");
      print(_costOutHouse);
    });
  }

  void resultHOutHouse(String text) async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      if (text == '' ||
          outHouseMpController.text == '' ||
          costOutHouseController.text == '') {
        int outH = 0;
        int outMp = 0;
        int outCost = 0;

        _costOutHouse = outH * outMp * outCost;
      } else {
        String newOutHouseCost =
            costOutHouseController.text.replaceAll(".", "");
        int outH = int.parse(text);
        int outMp = int.parse(outHouseMpController.text);
        int outCost = int.parse(newOutHouseCost);

        _costOutHouse = outH * outMp * outCost;
      }
      prefs.setString(
          "ttlCostOutHouse", _costOutHouse.toString().replaceAll(".", ""));
      print("===costOutHouse ===");
      print(_costOutHouse);
    });
  }

  void resultMpOutHouse(String text) async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      if (outHouseHController.text == '' ||
          text == '' ||
          costOutHouseController.text == '') {
        int outH = 0;
        int outMp = 0;
        int outCost = 0;

        _costOutHouse = outH * outMp * outCost;
      } else {
        String newOutHouseCost =
            costOutHouseController.text.replaceAll(".", "");
        int outH = int.parse(outHouseHController.text);
        int outMp = int.parse(text);
        int outCost = int.parse(newOutHouseCost);

        _costOutHouse = outH * outMp * outCost;
      }
      prefs.setString(
          "ttlCostOutHouse", _costOutHouse.toString().replaceAll(".", ""));
      print("===costOutHouse ===");
      print(_costOutHouse);
    });
  }

  getStep6() async {
    String ecmIdEditOrNew = ecmId.isEmpty || ecmId == "" ? ecmIdEdit : ecmId;
    List<VendorStep6Model> listVendorTemp = [];
    try {
      var response =
          await getFillNewEnam(ecmIdEditOrNew, userId, ecmitemId, tokenUser);
      print("======= getData step 6 =======");
      print(response['data']);

      if (response['data'] != null) {
        setState(() {
          stepEnamModel = StepEnamModel.fromJson(response['data']);
          _limitIncreamentH = int.parse(stepEnamModel.hasilRepairH.toString());
          _limitIncreamentM = int.parse(stepEnamModel.hasilRepairM.toString());
          _mp = int.parse(stepEnamModel.mP.toString());
          // costOutHouseController =
          //     TextEditingController(text: stepEnamModel.outHouseRp);

          // prefs.setString("outHouseCost", costOutHouseController.text);
        });

        for (int i = 0; i < response['data']['outhouse'].length; i++) {
          var dataVendor = VendorStep6Model(
              vendorName: response['data']['outhouse'][i]['m_vendor_name'],
              vendorPrice:
                  response['data']['outhouse'][i]['m_vendor_harga'].toString());
          listVendorTemp.add(dataVendor);
        }

        setState(() {
          listVendor = listVendorTemp;
        });

        String minuteCheck = stepEnamModel.checkM.toString().length == 1
            ? "0" + stepEnamModel.checkM.toString()
            : stepEnamModel.checkM.toString();
        String minuteRepair = stepEnamModel.repairM.toString().length == 1
            ? "0" + stepEnamModel.repairM.toString()
            : stepEnamModel.repairM.toString();
        String minuteTotalCr = stepEnamModel.hasilRepairM.toString().length == 1
            ? "0" + stepEnamModel.hasilRepairM.toString()
            : stepEnamModel.hasilRepairM.toString();
        String minuteLineStart = "0" + stepEnamModel.hasilRepairM.toString();
      } else {
        Fluttertoast.showToast(
            msg: 'Tidak ada data dari step 4 dan 5',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.white,
            fontSize: 16);
      }
    } catch (e) {
      setState(() {
        Fluttertoast.showToast(
            msg: 'Periksa jaringan internet anda',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.white,
            fontSize: 16);
      });
    }
  }

  Future<List<AllUserModel>> getAllUserData() async {
    print("id user step 6: " + userId);
    var response = await getUserAll(tokenUser, userId);
    if (response['response']['status'] == 200) {
      setState(() {
        var data = response['data'] as List;
        _listAllUser = data.map((e) => AllUserModel.fromJson(e)).toList();
        print("===== list username =====");
        for (int i = 0; i < _listAllUser.length; i++) {
          print(_listAllUser[i].userFullName);
        }
        print("===== || =====");
      });
    } else {
      setState(() {
        Fluttertoast.showToast(
            msg: 'Periksa jaringan internet anda',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.white,
            fontSize: 16);
      });
    }
    return _listAllUser;
  }

  void postFillEnam() async {
    String ecmIdEditOrNew = ecmId.isEmpty || ecmId == "" ? ecmIdEdit : ecmId;
    String minuteTotalCr = stepEnamModel.hasilRepairM.toString().length == 1
        ? "0" + stepEnamModel.hasilRepairM.toString()
        : stepEnamModel.hasilRepairM.toString();

    String minuteRepair = stepEnamModel.repairM.toString().length == 1
        ? "0" + stepEnamModel.repairM.toString()
        : stepEnamModel.repairM.toString();

    String minuteCheck = stepEnamModel.checkM.toString().length == 1
        ? "0" + stepEnamModel.checkM.toString()
        : stepEnamModel.checkM.toString();

    String tokenUser = SharedPrefsUtil.getTokenUser();
    String idEcm = SharedPrefsUtil.getEcmId();
    String idUser = SharedPrefsUtil.getIdUser();
    // idUsernameIdea
    String idea = ideaController.text.isEmpty ? "-" : ideaController.text;
    String check = stepEnamModel.checkH.toString() + ":" + minuteCheck;
    String repair = stepEnamModel.repairH.toString() + ":" + minuteRepair;
    String totalcr =
        stepEnamModel.hasilRepairH.toString() + ":" + minuteTotalCr;
    String breaks = _counter.toString();
    String lineStart = stepEnamModel.hasilRepairH.toString() +
        ":" +
        stepEnamModel.hasilRepairM.toString();
    String lineStop = _counter.toString() + ":00";
    String ttlLineStop = "0";
    String costH = _newLineStopH.toString();
    String costMp = stepEnamModel.mP.toString();
    String costInHouse = _costInHouse.toString();
    String outHouseH =
        outHouseHController.text.isEmpty ? "0" : outHouseHController.text;
    String outHouseMp =
        outHouseMpController.text.isEmpty ? "0" : outHouseMpController.text;
    String outHouseCost =
        costOutHouseController.text.isEmpty ? "0" : costOutHouseController.text;
    String ttlCostOutHouse = _costOutHouse.toString().replaceAll(".", "");

    try {
      var result = await fillNewEnam(
          ecmIdEditOrNew,
          idUser,
          idUsernameIdea,
          idea,
          check,
          repair,
          totalcr,
          breaks,
          lineStart,
          lineStop,
          ttlLineStop,
          costH,
          costMp,
          costInHouse,
          outHouseH,
          outHouseMp,
          outHouseCost,
          ttlCostOutHouse,
          tokenUser);

      if (result['response']['status'] == 200) {
        Fluttertoast.showToast(
          msg: 'Data step 6 disimpan',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.greenAccent,
        );

        isStepEnamFill.value = false;
        isStepTujuhFill.value = true;
      } else {
        print(result);
        Fluttertoast.showToast(
          msg: 'Data step 6 gagal disimpan',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.greenAccent,
        );
      }
    } catch (e) {
      print(e);
      print("Something error");
    }
  }

  void setFormValueStep6AfterChoosing() async {
    final prefs = await _prefs;

    String namaImprovement = prefs.getString("namaImprovement") ?? "";
    String idea = prefs.getString("idea") ?? "";
    String breakHours = prefs.getString("breakHours") ?? "";
    String breakMinutes = prefs.getString("breakMinutes") ?? "";
    String lineStopH = prefs.getString("lineStopH") ?? "";
    String lineStopM = prefs.getString("lineStopM") ?? "";
    String newLineStopH = prefs.getString("newLineStopH") ?? "";
    String costInHouse = prefs.getString("costInHouse") ?? "";
    String outHouseH = prefs.getString("outHouseH") ?? "";
    String outHouseMp = prefs.getString("outHouseMp") ?? "";
    String outHouseCost = prefs.getString("outHouseCost") ?? "";
    String ttlCostOutHouse = prefs.getString("ttlCostOutHouse") ?? "";
    String vendorName = prefs.getString("vendorName") ?? "";

    print("asdkjghfbwui");
    print(adminCost);
    print(ttlCostOutHouse);

    if ((breakHours.isNotEmpty || breakHours != "") &&
        (breakMinutes.isNotEmpty || breakMinutes != "")) {
      setState(() {
        userNameController = TextEditingController(text: namaImprovement);
        ideaController = TextEditingController(text: idea);
        breakHoursController = TextEditingController(text: breakHours);
        breakMinutesController = TextEditingController(text: breakMinutes);
        prefLineStopH = lineStopH;
        prefLineStopM = lineStopM;
        prefNewLineStop = newLineStopH;
        adminCost = costInHouse;
        vendorPriceController = TextEditingController(text: vendorName);
        costOutHouseController = TextEditingController(text: outHouseCost);
        outHouseHController = TextEditingController(text: outHouseH);
        outHouseMpController = TextEditingController(text: outHouseMp);
        prefOutHouse = ttlCostOutHouse;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllUserData();
    getStep6();
    setBahasa();
    setLang();
    setFormValueStep6AfterChoosing();
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
                improvement,
                style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  child: RichText(
                    text: TextSpan(
                      text: name,
                      style: TextStyle(
                          fontFamily: 'Rubik',
                          color: Color(0xFF404446),
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                      children: const <TextSpan>[
                        // TextSpan(
                        //     text: '*',
                        //     style: TextStyle(
                        //         fontFamily: 'Rubik',
                        //         fontSize: 16,
                        //         color: Colors.red,
                        //         fontWeight: FontWeight.w400)),
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
                        "Hapus Nama",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            color: Colors.red,
                            fontSize: 10,
                            fontWeight: FontWeight.w400),
                      ),
                    )),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.all(5),
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF979C9E)),
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: TextFormField(
                showCursor: true,
                readOnly: true,
                controller: userNameController,
                onTap: () {
                  setState(() {
                    // print(prefs.getString("userName"));
                    isTapedUserName = !isTapedUserName;
                  });
                },
                style: const TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    suffixIcon: Icon(Icons.search),
                    hintText: type_name,
                    contentPadding: const EdgeInsets.only(top: 5, left: 5),
                    hintStyle: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
              ),
            ),
            isTapedUserName == true
                ? Container(
                    margin: EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    height: 180,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF979C9E)),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: ListView.builder(
                      shrinkWrap: true,
                      // physics: NeverScrollableScrollPhysics(),
                      itemCount: _listAllUser.isEmpty ? 0 : _listAllUser.length,
                      itemBuilder: (context, i) {
                        return InkWell(
                            onTap: () async {
                              setState(() {
                                idUsernameIdea =
                                    _listAllUser[i].userId.toString();
                                userNameController = TextEditingController(
                                    text: _listAllUser[i].userFullName);
                                isTapedUserName = !isTapedUserName;
                              });

                              // final SharedPreferences prefs = await _prefs;
                              // prefs.setString("userName",
                              //     _listAllUser[i].userId.toString());
                              // prefs.setString("namaImprovement",
                              //     _listAllUser[i].userFullName!);
                              // prefs.setString("userNameBool", "1");
                              // setState(() {
                              //   userNameController = TextEditingController(
                              //       text: _listAllUser[i].userFullName);
                              // });
                              // getMachineNumberbyId(_listAllUser[i].idMesin);
                              // print("id mesin: $machineIdSelected");
                            },
                            child: Container(
                                margin: EdgeInsets.only(bottom: 8, top: 8),
                                child: Text(
                                  (_listAllUser[i].userFullName).toString(),
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
              width: MediaQuery.of(context).size.width,
              child: RichText(
                text: TextSpan(
                  text: idea,
                  style: TextStyle(
                      fontFamily: 'Rubik',
                      color: Color(0xFF404446),
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                  children: const <TextSpan>[
                    // TextSpan(
                    //     text: '*',
                    //     style: TextStyle(
                    //         fontFamily: 'Rubik',
                    //         fontSize: 16,
                    //         color: Colors.red,
                    //         fontWeight: FontWeight.w400)),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF979C9E)),
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: TextFormField(
                controller: ideaController,
                style: const TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                maxLines: 5,
                decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: type_idea,
                    contentPadding: const EdgeInsets.only(top: 5, left: 5),
                    hintStyle: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 24),
              width: MediaQuery.of(context).size.width,
              child: Text(
                working_time,
                style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Container(
                    child: Text(
                      repair,
                      style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 44,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF979C9E)),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                      child: Text(
                        stepEnamModel.checkH.toString() == "null"
                            ? "0 H"
                            : stepEnamModel.checkH.toString() + " H",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            color: Color(0xFF979C9E),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Container(
                    width: 44,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF979C9E)),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                      child: Text(
                        stepEnamModel.checkM.toString() == "null"
                            ? "0 M"
                            : stepEnamModel.checkM.toString() + " M",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            color: Color(0xFF979C9E),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text(
                        "+",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            color: Color(0xFF979C9E),
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Container(
                    width: 44,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF979C9E)),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                      child: Text(
                        stepEnamModel.repairH.toString() == "null"
                            ? "0 H"
                            : stepEnamModel.repairH.toString() + " H",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            color: Color(0xFF979C9E),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Container(
                    width: 44,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF979C9E)),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                      child: Text(
                        stepEnamModel.repairM.toString() == "null"
                            ? "0 M"
                            : stepEnamModel.repairM.toString() + " M",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            color: Color(0xFF979C9E),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text(
                        "=",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            color: Color(0xFF979C9E),
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Container(
                    width: 44,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF979C9E)),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                      child: Text(
                        stepEnamModel.hasilRepairH.toString() == "null"
                            ? "0 H"
                            : stepEnamModel.hasilRepairH.toString() + " H",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            color: Color(0xFF979C9E),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Container(
                    width: 44,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF979C9E)),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                      child: Text(
                        stepEnamModel.hasilRepairM.toString() == "null"
                            ? "0 M"
                            : stepEnamModel.hasilRepairM.toString() + " M",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            color: Color(0xFF979C9E),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: breaktime,
                      style: TextStyle(
                          fontFamily: 'Rubik',
                          color: Color(0xFF404446),
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                      children: const <TextSpan>[
                        TextSpan(
                            text: ' (H)',
                            style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w400)),
                        TextSpan(
                            text: ' *',
                            style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 16,
                                color: Colors.red,
                                fontWeight: FontWeight.w400)),
                        TextSpan(
                            text: ':',
                            style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 4),
                    child: TextFormField(
                      controller: breakHoursController,
                      keyboardType: TextInputType.number,
                      maxLength: 2,
                      // onChanged: (value) async {
                      //   _incrementCounter(value);

                      //   String minuteLineStop =
                      //       _lineStopM.toString().length == 1
                      //           ? "0" + _lineStopM.toString()
                      //           : _lineStopM.toString();
                      //   final SharedPreferences prefs = await _prefs;
                      //   prefs.setString(
                      //       "lineStop", _counter.toString() + ":00");
                      //   prefs.setString("ttlLineStop",
                      //       _lineStopH.toString() + ":" + minuteLineStop);
                      //   prefs.setString("costH", _newLineStopH.toString());
                      //   prefs.setString("costMp", stepEnamModel.mP.toString());
                      //   prefs.setString("costTotal", _costInHouse.toString());
                      //   prefs.setString("breakHours", value);
                      //   prefs.setString("breakTimeBool", "1");
                      // },
                      decoration: InputDecoration(
                        counter: Offstage(),
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent),
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                  )
                  // Container(
                  //   width: 150,
                  //   height: 40,
                  //   decoration: BoxDecoration(
                  //       border: Border.all(color: Color(0xFF979C9E)),
                  //       borderRadius: BorderRadius.all(Radius.circular(40))),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       SizedBox(
                  //         width: 40,
                  //         height: 40,
                  //         child: IconButton(
                  //           onPressed: () async {
                  //             _decreamentCounter();
                  //             String minuteLineStop =
                  //                 _lineStopM.toString().length == 1
                  //                     ? "0" + _lineStopM.toString()
                  //                     : _lineStopM.toString();
                  //             final SharedPreferences prefs = await _prefs;
                  //             prefs.setString(
                  //                 "lineStop", _counter.toString() + ":00");
                  //             prefs.setString("ttlLineStop",
                  //                 _lineStopH.toString() + ":" + minuteLineStop);
                  //             prefs.setString(
                  //                 "costH", _newLineStopH.toString());
                  //             prefs.setString(
                  //                 "costMp", stepEnamModel.mP.toString());
                  //             prefs.setString(
                  //                 "costTotal", _costInHouse.toString());
                  //             prefs.setString("breakTimeBool", "1");
                  //           },
                  //           icon: Icon(
                  //             Icons.remove,
                  //             color: _counter == 0
                  //                 ? Color(0xFF979C9E)
                  //                 : Color(0xFF20519F),
                  //           ),
                  //         ),
                  //       ),
                  //       Text("$_counter"),
                  //       SizedBox(
                  //         width: 40,
                  //         height: 40,
                  //         child: IconButton(
                  //           onPressed: () async {
                  //             _incrementCounter();

                  //             String minuteLineStop =
                  //                 _lineStopM.toString().length == 1
                  //                     ? "0" + _lineStopM.toString()
                  //                     : _lineStopM.toString();
                  //             final SharedPreferences prefs = await _prefs;
                  //             prefs.setString(
                  //                 "lineStop", _counter.toString() + ":00");
                  //             prefs.setString("ttlLineStop",
                  //                 _lineStopH.toString() + ":" + minuteLineStop);
                  //             prefs.setString(
                  //                 "costH", _newLineStopH.toString());
                  //             prefs.setString(
                  //                 "costMp", stepEnamModel.mP.toString());
                  //             prefs.setString(
                  //                 "costTotal", _costInHouse.toString());
                  //             prefs.setString("breakTimeBool", "1");
                  //           },
                  //           icon: Icon(
                  //             Icons.add,
                  //             color: Color(0xFF20519F),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        breaktime + " (M)",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(" *",
                          style: TextStyle(
                              color: Colors.red,
                              fontFamily: 'Rubik',
                              fontSize: 16,
                              fontWeight: FontWeight.w400)),
                      Text(":",
                          style: TextStyle(
                              fontFamily: 'Rubik',
                              fontSize: 16,
                              fontWeight: FontWeight.w400))
                    ],
                  ),
                  Container(
                    width: 150,
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 4),
                    child: TextFormField(
                      controller: breakMinutesController,
                      keyboardType: TextInputType.number,
                      maxLength: 2,
                      // onChanged: (value) async {
                      //   _incrementCounterMinutes(value);
                      //   String minuteLineStop =
                      //       _lineStopM.toString().length == 1
                      //           ? "0" + _lineStopM.toString()
                      //           : _lineStopM.toString();
                      //   final SharedPreferences prefs = await _prefs;
                      //   prefs.setString(
                      //       "lineStop", _counter.toString() + ":00");
                      //   prefs.setString("ttlLineStop",
                      //       _lineStopH.toString() + ":" + minuteLineStop);
                      //   prefs.setString("costH", _newLineStopH.toString());
                      //   prefs.setString("costMp", stepEnamModel.mP.toString());
                      //   prefs.setString("costTotal", _costInHouse.toString());
                      //   prefs.setString("breakMinutes", value);
                      //   prefs.setString("breakTimeBool", "1");
                      // },
                      decoration: InputDecoration(
                        counter: Offstage(),
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent),
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                  )
                  // Container(
                  //   width: 150,
                  //   height: 40,
                  //   decoration: BoxDecoration(
                  //       border: Border.all(color: Color(0xFF979C9E)),
                  //       borderRadius: BorderRadius.all(Radius.circular(40))),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       SizedBox(
                  //         width: 40,
                  //         height: 40,
                  //         child: IconButton(
                  //           onPressed: () async {
                  //             _decreamentCounterMinutes();
                  //             String minuteLineStop =
                  //                 _lineStopM.toString().length == 1
                  //                     ? "0" + _lineStopM.toString()
                  //                     : _lineStopM.toString();
                  //             final SharedPreferences prefs = await _prefs;
                  //             prefs.setString(
                  //                 "lineStop", _counter.toString() + ":00");
                  //             prefs.setString("ttlLineStop",
                  //                 _lineStopH.toString() + ":" + minuteLineStop);
                  //             prefs.setString(
                  //                 "costH", _newLineStopH.toString());
                  //             prefs.setString(
                  //                 "costMp", stepEnamModel.mP.toString());
                  //             prefs.setString(
                  //                 "costTotal", _costInHouse.toString());
                  //             prefs.setString("breakTimeBool", "1");
                  //           },
                  //           icon: Icon(
                  //             Icons.remove,
                  //             color: _counterMinutes == 0
                  //                 ? Color(0xFF979C9E)
                  //                 : Color(0xFF20519F),
                  //           ),
                  //         ),
                  //       ),
                  //       Text("$_counterMinutes"),
                  //       SizedBox(
                  //         width: 40,
                  //         height: 40,
                  //         child: IconButton(
                  //           onPressed: () async {
                  //             _incrementCounterMinutes();

                  //             String minuteLineStop =
                  //                 _lineStopM.toString().length == 1
                  //                     ? "0" + _lineStopM.toString()
                  //                     : _lineStopM.toString();
                  //             final SharedPreferences prefs = await _prefs;
                  //             prefs.setString(
                  //                 "lineStop", _counter.toString() + ":00");
                  //             prefs.setString("ttlLineStop",
                  //                 _lineStopH.toString() + ":" + minuteLineStop);
                  //             prefs.setString(
                  //                 "costH", _newLineStopH.toString());
                  //             prefs.setString(
                  //                 "costMp", stepEnamModel.mP.toString());
                  //             prefs.setString(
                  //                 "costTotal", _costInHouse.toString());
                  //             prefs.setString("breakTimeBool", "1");
                  //           },
                  //           icon: Icon(
                  //             Icons.add,
                  //             color: Color(0xFF20519F),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // )
                ],
              ),
            ),
            InkWell(
              onTap: () async {
                hitungLineStop();
                String minuteLineStop = _lineStopM.toString().length == 1
                    ? "0" + _lineStopM.toString()
                    : _lineStopM.toString();
                final SharedPreferences prefs = await _prefs;
                prefs.setString("lineStop", _counter.toString() + ":00");

                prefs.setString("costH", _newLineStopH.toString());
                prefs.setString("costMp", stepEnamModel.mP.toString());
                // prefs.setString("costTotal", _costInHouse.toString());
                prefs.setString("breakHours", breakHoursController.text);
                prefs.setString("breakMinutes", breakMinutesController.text);

                setFormValueStep6AfterChoosing();
              },
              child: Container(
                margin: EdgeInsets.only(top: 10),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 150,
                    height: 50,
                    // padding: EdgeInsets.symmetric(horizontal: 60, vertical: 4),
                    child: Center(
                      child: Text(
                        "Hitung Line Stop",
                        style:
                            TextStyle(color: Colors.white, fontFamily: 'Rubik'),
                      ),
                    ),
                    //   child: TextFormField(
                    //     controller: breakHoursController,
                    //     keyboardType: TextInputType.number,
                    //     maxLength: 2,
                    //     onChanged: (value) async {
                    //       _incrementCounter(value);

                    //       String minuteLineStop =
                    //           _lineStopM.toString().length == 1
                    //               ? "0" + _lineStopM.toString()
                    //               : _lineStopM.toString();
                    //       final SharedPreferences prefs = await _prefs;
                    //       prefs.setString(
                    //           "lineStop", _counter.toString() + ":00");
                    //       prefs.setString("ttlLineStop",
                    //           _lineStopH.toString() + ":" + minuteLineStop);
                    //       prefs.setString("costH", _newLineStopH.toString());
                    //       prefs.setString("costMp", stepEnamModel.mP.toString());
                    //       prefs.setString("costTotal", _costInHouse.toString());
                    //       prefs.setString("breakHours", value);
                    //       prefs.setString("breakTimeBool", "1");
                    //     },
                    //     decoration: InputDecoration(
                    //       counter: Offstage(),
                    //       contentPadding: EdgeInsets.symmetric(vertical: 8),
                    //       border: OutlineInputBorder(borderSide: BorderSide.none),
                    //     ),
                    //   ),
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        // border: Border.all(color: Colors.blueAccent),
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Container(
                    width: 115,
                    child: Text(
                      "Line Stop",
                      style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Text(
                    ":",
                    style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 44,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF979C9E)),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                      child: Text(
                        stepEnamModel.hasilRepairH.toString() == "null"
                            ? "0 H"
                            : stepEnamModel.hasilRepairH.toString() + " H",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            color: Color(0xFF979C9E),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Container(
                    width: 44,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF979C9E)),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                      child: Text(
                        stepEnamModel.hasilRepairM.toString() == "null"
                            ? "0 M"
                            : stepEnamModel.hasilRepairM.toString() + " M",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            color: Color(0xFF979C9E),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text(
                        "-",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            color: Color(0xFF979C9E),
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Container(
                    width: 44,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF979C9E)),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                      child: Text(
                        "$_counter H",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            color: Color(0xFF979C9E),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Container(
                    width: 44,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF979C9E)),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                      child: Text(
                        "$_counterMinutes M",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            color: Color(0xFF979C9E),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text(
                        "=",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            color: Color(0xFF979C9E),
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Container(
                    width: 44,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF979C9E)),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                      child: Text(
                        _lineStopH == 0 ? "$prefLineStopH H" : "$_lineStopH H",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            color: Color(0xFF979C9E),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Container(
                    width: 44,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF979C9E)),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                      child: Text(
                        _lineStopM == 0 ? "$prefLineStopM M" : "$_lineStopM M",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            color: Color(0xFF979C9E),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                margin: const EdgeInsets.only(top: 24),
                width: MediaQuery.of(context).size.width,
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 16,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: cost,
                          style: TextStyle(color: Color(0xFF404446))),
                      TextSpan(
                          text: ' * ', style: TextStyle(color: Colors.red)),
                      TextSpan(
                          text: ':',
                          style: TextStyle(color: Color(0xFF404446))),
                    ],
                  ),
                )),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: Text(
                in_house,
                style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 44,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF979C9E)),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                      child: Text(
                        _newLineStopH == 0
                            ? "$prefNewLineStop  H"
                            : "${_newLineStopH + _lineStopM} M",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 14,
                            color: Color(0xFF979C9E),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text(
                        "X",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            color: Color(0xFF979C9E),
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Container(
                    width: 50,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF979C9E)),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                      child: Text(
                        stepEnamModel.mP.toString() == "null"
                            ? "0 M/P"
                            : stepEnamModel.mP.toString() + " M/P",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 14,
                            color: Color(0xFF979C9E),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text(
                        "X",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            color: Color(0xFF979C9E),
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Container(
                    width: 67,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF979C9E)),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                      child: Text(
                        stepEnamModel.inHouseCost ?? "0",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 14,
                            color: Color(0xFF979C9E),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text(
                        "+",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            color: Color(0xFF979C9E),
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Container(
                    width: 67,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF979C9E)),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                      child: Text(
                        stepEnamModel.adminCost ?? "0",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 14,
                            color: Color(0xFF979C9E),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(top: 4),
              width: MediaQuery.of(context).size.width,
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF979C9E)),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Center(
                child: Text(
                  adminCost == "" || adminCost.isEmpty || adminCost == "0"
                      ? "Total = Rp. " +
                          NumberFormat.currency(
                                  locale: 'id', decimalDigits: 0, symbol: '')
                              .format(_costInHouse)
                      : "Total = Rp. " +
                          NumberFormat.currency(
                                  locale: 'id', decimalDigits: 0, symbol: '')
                              .format(int.parse(adminCost)),
                  style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 16,
                      color: Color(0xFF404446),
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 16,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                        text: out_house,
                        style: TextStyle(color: Color(0xFF404446))),
                    // TextSpan(text: ' * ', style: TextStyle(color: Colors.red)),
                    TextSpan(
                        text: ':', style: TextStyle(color: Color(0xFF404446))),
                  ],
                ),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(top: 16, bottom: 10),
                height: 40,
                child: TextFormField(
                  controller: vendorPriceController,
                  readOnly: true,
                  showCursor: true,
                  onTap: () {
                    setState(() {
                      isTapVendor = !isTapVendor;
                    });
                  },
                  decoration: InputDecoration(
                      hintText: "Pilih vendor",
                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                      suffixIcon: Icon(Icons.arrow_drop_down),
                      border: OutlineInputBorder()),
                )),
            isTapVendor == false
                ? Container()
                : Container(
                    height: 150,
                    padding: EdgeInsets.all(8),
                    child: ListView(
                      shrinkWrap: true,
                      children: listVendor.map((e) {
                        return InkWell(
                            onTap: () async {
                              // final prefs = await _prefs;
                              setState(() {
                                vendorPriceController =
                                    TextEditingController(text: e.vendorName);
                                costOutHouseController =
                                    TextEditingController(text: e.vendorPrice);
                                // prefs.setString("outHouseCost", e.vendorPrice!);
                                // prefs.setString("vendorName", e.vendorName!);
                                isTapVendor = !isTapVendor;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(e.vendorName!),
                            ));
                      }).toList(),
                    ),
                  ),
            Container(
              margin: const EdgeInsets.only(top: 4),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 60,
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 20,
                            // height: 20,
                            child: TextFormField(
                                maxLength: 2,
                                onChanged: (text) async {
                                  resultHOutHouse(text);
                                  // final prefs = await _prefs;
                                  // prefs.setString("outHouseH", text);
                                  // prefs.setString("outHouseHBool", "1");
                                  // setFormValueStep6AfterChoosing();
                                },
                                controller: outHouseHController,
                                keyboardType: TextInputType.number,
                                style: const TextStyle(
                                    fontFamily: 'Rubik',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                                decoration: const InputDecoration(
                                    counter: Offstage(),
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    hintText: '0',
                                    hintStyle: TextStyle(
                                        fontFamily: 'Rubik',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400))),
                          ),
                          Text(
                            " H",
                            style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text(
                        "X",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            color: Color(0xFF979C9E),
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Container(
                    width: 80,
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 20,
                            // height: 20,
                            child: TextFormField(
                                maxLength: 2,
                                onChanged: (text) async {
                                  resultMpOutHouse(text);
                                  // final SharedPreferences prefs = await _prefs;
                                  // prefs.setString("outHouseMp", text);
                                  // prefs.setString("outHouseMpBool", "1");
                                  // setFormValueStep6AfterChoosing();
                                },
                                controller: outHouseMpController,
                                keyboardType: TextInputType.number,
                                style: const TextStyle(
                                    fontFamily: 'Rubik',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                                decoration: const InputDecoration(
                                    counter: Offstage(),
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    hintText: '0',
                                    hintStyle: TextStyle(
                                        fontFamily: 'Rubik',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400))),
                          ),
                          Text(
                            " M/P",
                            style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text(
                        "X",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            color: Color(0xFF979C9E),
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Container(
                    width: 140,
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        border: Border.all(color: Color(0xFF979C9E)),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Rp. ",
                            style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          Container(
                            width: 70,
                            // height: 20,
                            child: TextFormField(
                                onChanged: (text) async {
                                  resultCostOutHouse(text);
                                  final SharedPreferences prefs = await _prefs;
                                  prefs.setString(
                                      "outHouseCost", text.replaceAll(".", ""));
                                  prefs.setString("outHouseCostBool", "1");
                                },
                                controller: costOutHouseController,
                                readOnly: true,
                                maxLength: 9,
                                inputFormatters: <TextInputFormatter>[
                                  CurrencyTextInputFormatter(
                                    locale: 'IDN',
                                    decimalDigits: 0,
                                    symbol: '',
                                  ),
                                ],
                                keyboardType: TextInputType.number,
                                style: const TextStyle(
                                    fontFamily: 'Rubik',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                                decoration: const InputDecoration(
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    counterText: "",
                                    hintText: '0',
                                    hintStyle: TextStyle(
                                        fontFamily: 'Rubik',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400))),
                          ),
                          Text(
                            " /H",
                            style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(top: 4),
              width: MediaQuery.of(context).size.width,
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF979C9E)),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Center(
                child: Text(
                  prefOutHouse == "" ||
                          prefOutHouse.isEmpty ||
                          prefOutHouse == "0"
                      ? "Total = Rp. " +
                          NumberFormat.currency(
                                  locale: 'id', decimalDigits: 0, symbol: '')
                              .format(_costOutHouse)
                      : "Total = Rp. " +
                          NumberFormat.currency(
                                  locale: 'id', decimalDigits: 0, symbol: '')
                              .format(int.parse(prefOutHouse)),
                  style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 16,
                      color: Color(0xFF404446),
                      fontWeight: FontWeight.w700),
                ),
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
                      isStepEnamFill.value = false;
                      isStepLimaFill.value = true;
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          border: Border.all(color: Color(0xFF00AEDB))),
                      child: Center(
                        child: Text(
                          "Kembali",
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
                    onTap: () {
                      if (breakTimeFill == true) {
                        postFillEnam();
                      } else {
                        Fluttertoast.showToast(
                            msg: 'Waktu istirahat masih kosong',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 2,
                            backgroundColor: Colors.greenAccent,
                            textColor: Colors.white,
                            fontSize: 16);
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Color(0xFF00AEDB)),
                      child: Center(
                        child: Text("Lanjut 7/8",
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
    );
  }
}
