// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, unnecessary_const, avoid_unnecessary_containers

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:e_cm/homepage/home/model/allusermodel.dart';
import 'package:e_cm/homepage/home/model/getstep6model.dart';
import 'package:e_cm/homepage/home/services/apifillnewenam.dart';
import 'package:e_cm/homepage/home/services/apifillnewenamget.dart';
import 'package:e_cm/homepage/home/services/getsemuauser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StepFillEnam extends StatefulWidget {
  const StepFillEnam({Key? key}) : super(key: key);

  @override
  _StepFillEnamState createState() => _StepFillEnamState();
}

class _StepFillEnamState extends State<StepFillEnam> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
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

  int _counter = 0;
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

  void _incrementCounter() {
    setState(() {
      if (_counter < _limitIncreamentH) {
        _counter++;
      } else {
        _counter = _counter;
      }
      resultLineStop();
      resultCostInHouse();
    });
  }

  void _decreamentCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      } else {
        _counter = _counter;
      }
      resultLineStop();
      resultCostInHouse();
    });
  }

  void resultLineStop() {
    setState(() {
      _lineStopH = _limitIncreamentH - _counter;
      _lineStopM = _limitIncreamentM - 0;
    });
  }

  void resultCostInHouse() {
    setState(() {
      if (_lineStopM < 30) {
        _newLineStopH = _lineStopH;
        _costInHouse = (_newLineStopH * _mp * 60000) + 30000;
      } else {
        _newLineStopH = _lineStopH + 1;
        _costInHouse = (_newLineStopH * _mp * 60000) + 30000;
      }
      print("===_newLineStopH ===");
      print(_newLineStopH);
    });
  }

  void resultCostOutHouse(String text) {
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

      print("===_newLineStopH ===");
      print(_costOutHouse);
    });
  }

  void resultHOutHouse(String text) {
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

      print("===_newLineStopH ===");
      print(_costOutHouse);
    });
  }

  void resultMpOutHouse(String text) {
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

      print("===_newLineStopH ===");
      print(_costOutHouse);
    });
  }

  getStep6() async {
    final SharedPreferences prefs = await _prefs;
    String? tokenUser = prefs.getString("tokenKey").toString();
    String ecmId = "11";
    String ecmitemId = "2";
    String userId = prefs.getString("idKeyUser").toString();
    try {
      var response = await getFillNewEnam(ecmId, userId, ecmitemId, tokenUser);
      print("======= getData step 6 =======");
      print(response['data']);
      setState(() {
        stepEnamModel = StepEnamModel.fromJson(response['data']);
        _limitIncreamentH = int.parse(stepEnamModel.hasilRepairH.toString());
        _limitIncreamentM = int.parse(stepEnamModel.hasilRepairM.toString());
        _mp = int.parse(stepEnamModel.mP.toString());
      });
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
    final SharedPreferences prefs = await _prefs;
    String? tokenUser = prefs.getString("tokenKey").toString();
    var response = await getUserAll(tokenUser);
    if (response['response']['status'] == 200) {
      setState(() {
        var data = response['data'] as List;
        _listAllUser = data.map((e) => AllUserModel.fromJson(e)).toList();
        print("===== list username =====");
        for (int i = 0; i < _listAllUser.length; i++) {
          print(_listAllUser[i].userName);
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

  postFillEnam() async {
    final SharedPreferences prefs = await _prefs;
    String newOutHouseCost = costOutHouseController.text.replaceAll(".", "");

    String? tokenUser = prefs.getString("tokenKey").toString();
    String ecmId = prefs.getString("idEcm").toString();
    String userId = prefs.getString("idKeyUser").toString();
    String userName = userNameController.text;
    String idea = ideaController.text;
    String check =
        stepEnamModel.checkH.toString() + ":" + stepEnamModel.checkM.toString();
    String repair = stepEnamModel.repairH.toString() +
        ":" +
        stepEnamModel.repairM.toString();
    String totalcr = stepEnamModel.hasilRepairH.toString() +
        ":" +
        stepEnamModel.hasilRepairM.toString();
    String breaks = _counter.toString();
    String lineStart = stepEnamModel.hasilRepairH.toString() +
        ":" +
        stepEnamModel.hasilRepairM.toString();
    String lineStop = _counter.toString() + ":00";
    String ttlLineStop = _lineStopH.toString() + ":" + _lineStopM.toString();
    String costH = _newLineStopH.toString();
    String costMp = stepEnamModel.mP.toString();
    String costTotal = _costInHouse.toString();
    String outHouseH = outHouseHController.text;
    String outHouseMp = outHouseMpController.text;
    String outHouseCost = newOutHouseCost.toString();
    String ttlOutHouse = _costOutHouse.toString();

    try {
      var response = await fillNewEnam(
          ecmId,
          userId,
          userName,
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
          costTotal,
          outHouseH,
          outHouseMp,
          outHouseCost,
          ttlOutHouse,
          tokenUser);

      var data = response['data'];
      print(data);
    } catch (e) {
      print("Something error");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllUserData();
    getStep6();
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
                "Improvement/Kaizen",
                style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              width: MediaQuery.of(context).size.width,
              child: Text(
                "Name",
                style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
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
                enabled: true,
                controller: userNameController,
                onTap: () {
                  setState(() {
                    isTapedUserName = !isTapedUserName;
                  });
                },
                style: const TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    suffixIcon: Icon(Icons.search),
                    hintText: 'User Name',
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
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF979C9E)),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _listAllUser.isEmpty ? 0 : _listAllUser.length,
                      itemBuilder: (context, i) {
                        return InkWell(
                            onTap: () async {
                              final prefs = await _prefs;
                              setState(() {
                                userNameController = TextEditingController(
                                    text: _listAllUser[i].userName);
                                isTapedUserName = !isTapedUserName;
                              });
                              // getMachineNumberbyId(_listAllUser[i].idMesin);
                              // print("id mesin: $machineIdSelected");
                            },
                            child: Container(
                                margin: EdgeInsets.only(bottom: 8, top: 8),
                                child: Text(
                                  (_listAllUser[i].userName).toString(),
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
              child: Text(
                "Idea",
                style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
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
                decoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: 'Type your idea',
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
                "Working Time",
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
                    width: 115,
                    child: Text(
                      "Check + Repair",
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
                        stepEnamModel.checkH.toString() + " H",
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
                        stepEnamModel.checkM.toString() + " M",
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
                        stepEnamModel.repairH.toString() + " H",
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
                        stepEnamModel.repairM.toString() + " M",
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
                        stepEnamModel.hasilRepairH.toString() + " H",
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
                        stepEnamModel.hasilRepairM.toString() + " M",
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
                  Text(
                    "Break Time (H)  : ",
                    style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                  Container(
                    width: 150,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF979C9E)),
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: IconButton(
                            onPressed: () {
                              _decreamentCounter();
                            },
                            icon: Icon(
                              Icons.remove,
                              color: Color(0xFF979C9E),
                            ),
                          ),
                        ),
                        Text("$_counter"),
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: IconButton(
                            onPressed: () {
                              _incrementCounter();
                            },
                            icon: Icon(
                              Icons.add,
                              color: Color(0xFF20519F),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
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
                        stepEnamModel.hasilRepairH.toString() + " H",
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
                        stepEnamModel.hasilRepairM.toString() + " M",
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
                        "0 M",
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
                        "$_lineStopH H",
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
                        "$_lineStopM M",
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
              child: Text(
                "Cost",
                style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: Text(
                "In-House M/P Cost (Rp)",
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
                        "$_newLineStopH H",
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
                        stepEnamModel.mP.toString() + " M/P",
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
                        "60.000",
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
                        "30.000",
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
                  "Total = Rp. " +
                      NumberFormat.currency(
                              locale: 'id', decimalDigits: 0, symbol: '')
                          .format(_costInHouse),
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
              child: Text(
                "Out-House (Rp)",
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
                    width: 60,
                    height: 40,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF979C9E)),
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
                                onChanged: (text) {
                                  resultHOutHouse(text);
                                },
                                controller: outHouseHController,
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
                    height: 40,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF979C9E)),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 20,
                            // height: 20,
                            child: TextFormField(
                                onChanged: (text) {
                                  resultMpOutHouse(text);
                                },
                                controller: outHouseMpController,
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
                    height: 40,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
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
                                onChanged: (text) {
                                  resultCostOutHouse(text);
                                },
                                controller: costOutHouseController,
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
            InkWell(
              onTap: () {
                postFillEnam();
              },
              child: Container(
                margin: const EdgeInsets.only(top: 4),
                width: MediaQuery.of(context).size.width,
                height: 40,
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF979C9E)),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Center(
                  child: Text(
                    "Total = Rp. " +
                        NumberFormat.currency(
                                locale: 'id', decimalDigits: 0, symbol: '')
                            .format(_costOutHouse),
                    style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 16,
                        color: Color(0xFF404446),
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
