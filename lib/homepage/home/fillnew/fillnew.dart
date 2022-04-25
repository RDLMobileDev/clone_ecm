// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, avoid_print, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:e_cm/baseurl/baseurl.dart';
import 'package:e_cm/homepage/dashboard.dart';
import 'package:e_cm/homepage/home/component/widget_fill_new.dart';
import 'package:e_cm/homepage/home/component/widget_line_stepper.dart';
import 'package:e_cm/homepage/home/fillnew/interface/stepper_switch.dart';
import 'package:e_cm/homepage/home/fillnew/stepfillnew/stepfilldelapan.dart';
import 'package:e_cm/homepage/home/fillnew/stepfillnew/stepfilldua.dart';
import 'package:e_cm/homepage/home/fillnew/stepfillnew/stepfillempat.dart';
import 'package:e_cm/homepage/home/fillnew/stepfillnew/stepfillenam.dart';
import 'package:e_cm/homepage/home/fillnew/stepfillnew/stepfilllima.dart';
import 'package:e_cm/homepage/home/fillnew/stepfillnew/stepfillsatu.dart';
import 'package:e_cm/homepage/home/fillnew/stepfillnew/stepfilltiga.dart';
import 'package:e_cm/homepage/home/fillnew/stepfillnew/stepfilltujuh.dart';
import 'package:e_cm/homepage/home/model/summaryapprovemodel.dart';
import 'package:e_cm/homepage/home/services/api_remove_cache.dart';
import 'package:e_cm/homepage/home/services/remove_ecm_cancel_service.dart';
import 'package:e_cm/homepage/home/services/summaryapproveservice.dart';
import 'package:e_cm/homepage/home/view/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

var isStepSatuFill = true,
    isStepDuaFill = false,
    isStepTigaFill = false,
    isStepEmpatFill = false,
    isStepLimaFill = false,
    isStepEnamFill = false,
    isStepTujuhFill = false,
    isStepDelapanFill = false;

class FillNew extends StatefulWidget {
  final String? ecmId;
  const FillNew({Key? key, this.ecmId}) : super(key: key);

  @override
  _FillNewState createState() => _FillNewState();
}

class _FillNewState extends State<FillNew> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final storage = GetStorage();

  String bahasa = "Bahasa Indonesia";
  bool bahasaSelected = false;

  String next = '';
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
        next = dataLang['step_1']['next_two'];
        back = dataLang['step_4']['back'];
      });
    }
  }

  void getLanguageId() async {
    var response = await rootBundle.loadString("assets/lang/lang-id.json");
    var dataLang = json.decode(response)['data'];

    if (mounted) {
      setState(() {
        next = dataLang['step_1']['next_two'];
        back = dataLang['step_4']['back'];
      });
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

  // final StepFillSatu _stepFillSatu = StepFillSatu();
  // final StepFillDua _stepFillDua = StepFillDua();
  // final StepFillTiga _stepFillTiga = StepFillTiga();
  // final StepFillEnam _stepFillEnam = StepFillEnam();
  // final StepFillDelapan _stepFillDelapan = StepFillDelapan();

  // final List<GlobalKey<FormState>> _formKeys = [
  //   GlobalKey<FormState>(),
  //   GlobalKey<FormState>(),
  //   GlobalKey<FormState>(),
  //   GlobalKey<FormState>(),
  //   GlobalKey<FormState>(),
  //   GlobalKey<FormState>(),
  //   GlobalKey<FormState>(),
  //   GlobalKey<FormState>(),
  // ];

  // List<Step> get _steps => [
  //       Step(
  //         title: Text(''),
  //         content: Form(
  //             key: _formKeys[0],
  //             child: StepFillSatu(
  //               ecmId: widget.ecmId,
  //             )),
  //         isActive: _currentStep >= 0,
  //         // state: _currentStep >= 0
  //         //     ? StepState.complete
  //         //     : StepState.disabled,
  //       ),
  //       Step(
  //         title: Text(''),
  //         content: Form(key: _formKeys[1], child: StepFillDua()),
  //         isActive: _currentStep >= 1,
  //         // state: _currentStep >= 1
  //         //     ? StepState.complete
  //         //     : StepState.disabled,
  //       ),
  //       Step(
  //         title: Text(''),
  //         content: Form(key: _formKeys[2], child: StepFillTiga()),
  //         isActive: _currentStep >= 2,
  //         // state: _currentStep >= 2
  //         //     ? StepState.complete
  //         //     : StepState.disabled,
  //       ),
  //       Step(
  //         title: Text(''),
  //         content: Form(key: _formKeys[3], child: StepFillEmpat()),
  //         isActive: _currentStep >= 3,
  //         // state: _currentStep >= 3
  //         //     ? StepState.complete
  //         //     : StepState.disabled,
  //       ),
  //       Step(
  //         title: Text(''),
  //         content: Form(key: _formKeys[4], child: StepFillLima()),
  //         isActive: _currentStep >= 4,
  //         // state: _currentStep >= 4
  //         //     ? StepState.complete
  //         //     : StepState.disabled,
  //       ),
  //       Step(
  //         title: Text(''),
  //         content: Form(key: _formKeys[5], child: StepFillEnam()),
  //         isActive: _currentStep >= 5,
  //         // state: _currentStep >= 5
  //         //     ? StepState.complete
  //         //     : StepState.disabled,
  //       ),
  //       Step(
  //         title: Text(''),
  //         content: Form(key: _formKeys[6], child: StepFillTujuh()),
  //         isActive: _currentStep >= 6,
  //         // state: _currentStep >= 6
  //         //     ? StepState.complete
  //         //     : StepState.disabled,
  //       ),
  //       Step(
  //         title: Text(''),
  //         content: Form(key: _formKeys[7], child: StepFillDelapan()),
  //         isActive: _currentStep >= 7,
  //         // state: _currentStep >= 0
  //         //     ? StepState.complete
  //         //     : StepState.disabled,
  //       ),
  //     ];

  int _currentStep = 0;
  final int _stepTotal = 8;
  int _stepClicked = 1;
  String textNext = 'Next';

  tapped(int step) {
    print(step);
    setState(() => _currentStep = step);
  }

  // continued() async {
  //   final prefs = await _prefs;

  //   try {
  //     if (_currentStep == 0) {
  //       if (prefs.getString("classBool")!.isNotEmpty &&
  //           prefs.getString("dateBool")!.isNotEmpty &&
  //           prefs.getString("teamMemberBool")!.isNotEmpty &&
  //           prefs.getString("locationBool")!.isNotEmpty &&
  //           prefs.getString("machineNameBool")!.isNotEmpty &&
  //           prefs.getString("machineDetailBool")!.isNotEmpty) {
  //         widget.ecmId == null
  //             ? _stepFillSatu.getSaveFillSatu()
  //             : _stepFillSatu.getUpdateFillSatu();
  //         setState(() {
  //           _currentStep++;
  //           _stepClicked != 8 ? _stepClicked += 1 : null;
  //         });
  //       } else {
  //         Fluttertoast.showToast(
  //             msg: 'Form belum terisi semua',
  //             toastLength: Toast.LENGTH_SHORT,
  //             gravity: ToastGravity.BOTTOM,
  //             timeInSecForIosWeb: 2,
  //             fontSize: 16);
  //       }
  //     }

  //     if (_currentStep == 1) {
  //       if (prefs.getString("shiftBool")!.isNotEmpty &&
  //           prefs.getString("timeBool")!.isNotEmpty &&
  //           prefs.getString("ketikProblemBool")!.isNotEmpty &&
  //           prefs.getString("typeProblemBool")!.isNotEmpty &&
  //           prefs.getString("imageUploadBool")!.isNotEmpty) {
  //         _stepFillDua.getSaveFillDua();
  //         setState(() {
  //           _currentStep++;
  //           _stepClicked != 8 ? _stepClicked += 1 : null;
  //         });
  //       } else {
  //         Fluttertoast.showToast(
  //             msg: 'Form belum terisi semua',
  //             toastLength: Toast.LENGTH_SHORT,
  //             gravity: ToastGravity.BOTTOM,
  //             timeInSecForIosWeb: 2,
  //             fontSize: 16);
  //       }
  //     }

  //     if (_currentStep == 2) {
  //       if (prefs.getString("whyBool1")!.isNotEmpty &&
  //           prefs.getString("whyBool2")!.isNotEmpty) {
  //         _stepFillTiga.getSaveStepFillTiga();
  //         setState(() {
  //           _currentStep++;
  //           _stepClicked != 8 ? _stepClicked += 1 : null;
  //         });
  //       } else {
  //         Fluttertoast.showToast(
  //             msg: 'Form belum terisi semua',
  //             toastLength: Toast.LENGTH_SHORT,
  //             gravity: ToastGravity.BOTTOM,
  //             timeInSecForIosWeb: 2,
  //             fontSize: 16);
  //       }
  //     }

  //     if (_currentStep == 3) {
  //       String? itemStep4Bool = prefs.getString("itemStep4Bool");
  //       if (itemStep4Bool!.isNotEmpty && itemStep4Bool == "1") {
  //         setState(() {
  //           _currentStep++;
  //           _stepClicked != 8 ? _stepClicked += 1 : null;
  //         });
  //       }
  //     }

  //     if (_currentStep == 4) {
  //       String? itemRepairBool = prefs.getString("itemRepairBool");
  //       if (itemRepairBool!.isNotEmpty && itemRepairBool == "1") {
  //         setState(() {
  //           _currentStep++;
  //           _stepClicked != 8 ? _stepClicked += 1 : null;
  //         });
  //       }
  //     }

  //     if (_currentStep == 5) {
  //       // print("object step 6");
  //       // &&
  //       //     prefs.getString("outHouseHBool")!.isNotEmpty &&
  //       //     prefs.getString("outHouseMpBool")!.isNotEmpty &&
  //       //     prefs.getString("outHouseCostBool")!.isNotEmpty
  //       if (prefs.getString("breakTimeBool")!.isNotEmpty) {
  //         _stepFillEnam.getSaveFillEnam();
  //         setState(() {
  //           _currentStep++;
  //           _stepClicked != 8 ? _stepClicked += 1 : null;
  //         });
  //       } else {
  //         Fluttertoast.showToast(
  //             msg: 'Form belum terisi semua',
  //             toastLength: Toast.LENGTH_SHORT,
  //             gravity: ToastGravity.BOTTOM,
  //             timeInSecForIosWeb: 2,
  //             fontSize: 16);
  //       }
  //     }

  //     if (_currentStep == 6) {
  //       String? sparePartBool = prefs.getString("sparePartBool");
  //       if (sparePartBool!.isNotEmpty && sparePartBool == "1") {
  //         setState(() {
  //           _currentStep++;
  //           _stepClicked != 8 ? _stepClicked += 1 : null;
  //         });
  //       } else if (sparePartBool.isNotEmpty && sparePartBool == "0") {
  //         setState(() {
  //           _currentStep++;
  //           _stepClicked != 8 ? _stepClicked += 1 : null;
  //         });
  //       }
  //     }

  //     if (_currentStep == 7) {
  //       if ((prefs.getString("copyToBool")!.isNotEmpty &&
  //               prefs.getString("copyToBool") == "0") ||
  //           prefs.getString("copyToBool")!.isNotEmpty &&
  //               prefs.getString("copyToBool") == "1") {
  //         await _stepFillDelapan.getMethodPostStep();

  //         try {
  //           // successStep8();
  //           Timer.periodic(Duration(seconds: 10), (timer) async {
  //             if (timer.tick == 5) {
  //               removeStepCacheFillEcm();
  //               removeCacheFillEcm();
  //               Fluttertoast.showToast(
  //                   msg: 'Terjadi masalah jaringan, E-CM Card tidak disimpan',
  //                   toastLength: Toast.LENGTH_SHORT,
  //                   gravity: ToastGravity.BOTTOM,
  //                   timeInSecForIosWeb: 2,
  //                   fontSize: 16);
  //               Navigator.pushAndRemoveUntil(
  //                   context,
  //                   MaterialPageRoute(builder: (context) => Dashboard()),
  //                   ModalRoute.withName("/"));
  //               timer.cancel();
  //             }

  //             timer.cancel();
  //           });
  //         } catch (e) {
  //           showDialog<String>(
  //             context: context,
  //             builder: (BuildContext context) => AlertDialog(
  //               title: const Text('Timeout'),
  //               content: const Text(
  //                   'Jaringan anda bermasalah, apakah ingin mencoba ulang?'),
  //               actions: <Widget>[
  //                 TextButton(
  //                   onPressed: () => Navigator.of(context)
  //                     ..pop()
  //                     ..pop(true),
  //                   child: const Text('Kembali'),
  //                 ),
  //                 TextButton(
  //                   onPressed: () => continued(),
  //                   child: const Text('Kirim Ulang'),
  //                 ),
  //               ],
  //             ),
  //           );
  //         }
  //       }
  //     }
  //   } catch (e) {
  //     print("fill new error -> $e");
  //     if (_currentStep + 1 <= 6) {
  //       Fluttertoast.showToast(
  //           msg: 'Harap isi semua form di step ${_currentStep + 1}',
  //           toastLength: Toast.LENGTH_LONG,
  //           gravity: ToastGravity.BOTTOM,
  //           timeInSecForIosWeb: 2,
  //           backgroundColor: Colors.orangeAccent,
  //           textColor: Colors.white,
  //           fontSize: 16);
  //     }
  //   }
  // }

  // cancel() async {
  //   final prefs = await _prefs;
  //   _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  //   if (_stepClicked == 10) {
  //     setState(() => _stepClicked -= 2);
  //   } else if (_stepClicked == 2) {
  //     Navigator.of(context).pop();
  //   } else {
  //     setState(() => _stepClicked -= 1);
  //   }

  //   if (_currentStep != 7) {
  //     setState(() {
  //       textNext = 'Next';
  //     });
  //   }

  //   if (_currentStep == 6) {
  //     prefs.remove("copyToBool");
  //   }

  //   print("di: $_currentStep");
  //   print(_stepClicked);
  // }

  void cancelEcmRemoveData() async {
    final prefs = await _prefs;
    String tokenUser = prefs.getString("tokenKey") ?? "";
    String idEcm = prefs.getString("idEcm") ?? "";

    if ((tokenUser.isNotEmpty || tokenUser != "") &&
        (idEcm.isNotEmpty || idEcm != "")) {
      var response = await removeEcmCancelUser.removeEcmLast(tokenUser, idEcm);

      if (response['response']['status'] == 200) {
        removeStepCacheFillEcm();
        removeCacheFillEcm();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Dashboard()),
            ModalRoute.withName("/"));
      } else {
        removeStepCacheFillEcm();
        removeCacheFillEcm();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Dashboard()),
            ModalRoute.withName("/"));
      }
    } else {
      removeStepCacheFillEcm();
      removeCacheFillEcm();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Dashboard()),
          ModalRoute.withName("/"));
    }

    isStepSatuFill = true;
    isStepDuaFill = false;
    isStepTigaFill = false;
    isStepEmpatFill = false;
    isStepLimaFill = false;
    isStepEnamFill = false;
    isStepTujuhFill = false;
    isStepDelapanFill = false;
  }

  void removeDataGagalEcm() async {
    final prefs = await _prefs;

    String tokenUser = prefs.getString("tokenKey") ?? "";
    String idEcm = prefs.getString("idEcm") ?? "";
    await removeEcmCancelUser.removeEcmLast(tokenUser, idEcm);
    removeStepCacheFillEcm();
    removeCacheFillEcm();
  }

  Future confirmBackToHome() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.topRight,
                  child: Image.asset(
                    "assets/icons/X.png",
                    width: 20,
                  ),
                ),
              ),
              Container(
                child: Center(
                    child: Image.asset(
                  "assets/images/img_attendance_logout.png",
                  width: 150,
                )),
              ),
              Container(
                margin: EdgeInsets.only(top: 8),
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text(
                    "Konfirmasi",
                    style: TextStyle(
                        color: Color(0xFF404446),
                        fontFamily: 'Rubik',
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8, left: 16, right: 16),
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text(
                    "Anda yakin ingin membatalkan pengisian Form E-CM?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xFF404446),
                        fontFamily: 'Rubik',
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 20, right: 5),
                        width: 130,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Color(0xFF00AEDB)),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Center(
                          child: Text(
                            "Tidak",
                            style: TextStyle(
                                color: Color(0xFF00AEDB),
                                fontFamily: 'Rubik',
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        )),
                  ),
                  InkWell(
                    onTap: () {
                      cancelEcmRemoveData();
                    },
                    child: Container(
                        margin: EdgeInsets.only(top: 20),
                        width: 130,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Color(0xffcf0000),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Center(
                          child: Text(
                            "Ya",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Rubik',
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        )),
                  ),
                ],
              )
            ],
          );
        });
  }

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  @override
  void initState() {
    _stepClicked += 1;

    super.initState();
    setBahasa();
    setLang();

    removeDataGagalEcm();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await confirmBackToHome();
        return true;
      },
      child: Scaffold(
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
                await confirmBackToHome();
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
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StepperNumber(
                        numberStep: "1",
                        isFilled: isStepSatuFill,
                      ),
                      LineStepper(),
                      StepperNumber(
                        numberStep: "2",
                        isFilled: isStepDuaFill,
                      ),
                      LineStepper(),
                      StepperNumber(
                        numberStep: "3",
                        isFilled: isStepTigaFill,
                      ),
                      LineStepper(),
                      StepperNumber(
                        numberStep: "4",
                        isFilled: isStepEmpatFill,
                      ),
                      LineStepper(),
                      StepperNumber(
                        numberStep: "5",
                        isFilled: isStepLimaFill,
                      ),
                      LineStepper(),
                      StepperNumber(
                        numberStep: "6",
                        isFilled: isStepEnamFill,
                      ),
                      LineStepper(),
                      StepperNumber(
                        numberStep: "7",
                        isFilled: isStepTujuhFill,
                      ),
                      LineStepper(),
                      StepperNumber(
                        numberStep: "8",
                        isFilled: isStepDelapanFill,
                      ),
                    ],
                  ),
                ),
                Visibility(
                    visible: isStepSatuFill,
                    child: Container(
                        padding: EdgeInsets.all(15), child: StepFillSatu())),
                Visibility(
                    visible: isStepDuaFill,
                    child: Container(
                        padding: EdgeInsets.all(15), child: StepFillDua())),
                Visibility(
                    visible: isStepTigaFill,
                    child: Container(
                        padding: EdgeInsets.all(15), child: StepFillTiga())),
                Visibility(
                    visible: isStepEmpatFill,
                    child: Container(
                        padding: EdgeInsets.all(15), child: StepFillEmpat())),
                Visibility(
                    visible: isStepLimaFill,
                    child: Container(
                        padding: EdgeInsets.all(15), child: StepFillLima())),
                Visibility(
                    visible: isStepEnamFill,
                    child: Container(
                        padding: EdgeInsets.all(15), child: StepFillEnam())),
                Visibility(
                    visible: isStepTujuhFill,
                    child: Container(
                        padding: EdgeInsets.all(15), child: StepFillTujuh())),
                Visibility(
                    visible: isStepDelapanFill,
                    child: Container(
                        padding: EdgeInsets.all(15), child: StepFillDelapan())),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showCustomDialog(BuildContext context) => showDialog(
        builder: (context) => Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            height: 250,
            child: Stack(
              children: <Widget>[
                Container(
                  // color: Colors.redAccent,
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        "Informasi",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            "Simbol",
                            style: TextStyle(fontFamily: 'Rubik', fontSize: 12),
                          ),
                          Text(
                            "*",
                            style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 14,
                                color: Colors.redAccent),
                          ),
                          Text(
                            "(wajib diisi)",
                            style: TextStyle(fontFamily: 'Rubik', fontSize: 12),
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        height: 1,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.grey,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Rule line stop",
                          style: TextStyle(fontFamily: 'Rubik', fontSize: 12),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(left: 20),
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("1. > 10 menit = G/L wajib tanda tangan",
                                  style: TextStyle(
                                      fontFamily: 'Rubik', fontSize: 12)),
                              SizedBox(
                                height: 4,
                              ),
                              Text("2.  > 15 menit = C/L wajib tanda tangan",
                                  style: TextStyle(
                                      fontFamily: 'Rubik', fontSize: 12)),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                  "3. > 20 menit = MGR wajib tanda tangan + cost > Juta",
                                  style: TextStyle(
                                      fontFamily: 'Rubik', fontSize: 12)),
                              SizedBox(
                                height: 4,
                              ),
                              Text("4.  > 40 menit = GM wajib tanda tangan",
                                  style: TextStyle(
                                      fontFamily: 'Rubik', fontSize: 12)),
                            ],
                          )),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, right: 10),
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  // color: Colors.greenAccent,
                  alignment: Alignment.topRight,
                  child: InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Icon(Icons.clear_rounded)),
                ),
              ],
            ),
          ),
        ),
        context: context,
        barrierDismissible: false,
      );
}
