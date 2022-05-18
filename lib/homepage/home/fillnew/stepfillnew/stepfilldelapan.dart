// ignore_for_file: sized_box_for_whitespace, unnecessary_const, avoid_unnecessary_containers

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:e_cm/homepage/dashboard.dart';
import 'package:e_cm/homepage/home/component/function_header_stepper.dart';
import 'package:e_cm/homepage/home/component/widget_fill_new.dart';
import 'package:e_cm/homepage/home/component/widget_line_stepper.dart';
import 'package:e_cm/homepage/home/fillnew/fillnew.dart';
import 'package:e_cm/homepage/home/model/summaryapprovemodel.dart';
// import 'package:e_cm/homepage/home/fillnew/additionpage/approvestepdelapan.dart';
import 'package:e_cm/homepage/home/services/api_remove_cache.dart';
import 'package:e_cm/homepage/home/services/apifillnewdelapan.dart';
import 'package:e_cm/homepage/home/services/remove_ecm_cancel_service.dart';
import 'package:e_cm/homepage/home/services/summaryapproveservice.dart';
import 'package:e_cm/homepage/home/view/home.dart';
import 'package:e_cm/util/shared_prefs_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StepFillDelapan extends StatefulWidget {
  StepFillDelapan({Key? key}) : super(key: key);

  final StepFillDelapanState stepFillDelapanState = StepFillDelapanState();

  getMethodPostStep() async {
    // var res = await stepFillDelapanState.postStepDelapan();
  }

  @override
  StepFillDelapanState createState() => StepFillDelapanState();
}

class StepFillDelapanState extends State<StepFillDelapan> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  List<SummaryApproveModel> _listSummaryApproval = [];

  int isClicked = 0;

  String tokenUser = SharedPrefsUtil.getTokenUser();
  String ecmId = SharedPrefsUtil.getEcmId();
  String ecmIdEdit = SharedPrefsUtil.getEcmIdEdit();

  String? copyToGroup;
  String engineerTo = '', productTo = '', othersTo = '';

  String bahasa = "Bahasa Indonesia";
  bool bahasaSelected = false;

  String copy_to = "";
  String engineer = "";
  String product = "";
  String others = "";
  String thankyou = "";
  String validation = "";
  String view_summary = "";
  String summary = "";
  String bm = "";
  String ecm_approved = "";
  String done = "";

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
        copy_to = dataLang['step_8']['copy_to'];
        engineer = dataLang['step_8']['engineer'];
        product = dataLang['step_8']['product'];
        others = dataLang['step_8']['others'];
        thankyou = dataLang['step_8']['thankyou'];
        validation = dataLang['step_8']['validation'];
        view_summary = dataLang['step_8']['view_summary'];
        summary = dataLang['step_8']['summary'];
        bm = dataLang['step_8']['bm'];
        ecm_approved = dataLang['step_8']['ecm_approved'];
        done = dataLang['step_8']['done'];
      });
    }
  }

  void getLanguageId() async {
    var response = await rootBundle.loadString("assets/lang/lang-id.json");
    var dataLang = json.decode(response)['data'];

    if (mounted) {
      setState(() {
        copy_to = dataLang['step_8']['copy_to'];
        engineer = dataLang['step_8']['engineer'];
        product = dataLang['step_8']['product'];
        others = dataLang['step_8']['others'];
        thankyou = dataLang['step_8']['thankyou'];
        validation = dataLang['step_8']['validation'];
        view_summary = dataLang['step_8']['view_summary'];
        summary = dataLang['step_8']['summary'];
        bm = dataLang['step_8']['bm'];
        ecm_approved = dataLang['step_8']['ecm_approved'];
        done = dataLang['step_8']['done'];
      });
    }
  }

  void setLang() async {
    final prefs = await _prefs;
    prefs.setString("copyToBool", "0");
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

  setCopyTo() {
    print("Engineer");
    print(engineerTo);
    print("Product");
    print(productTo);
    print("Others");
    print(othersTo);
  }

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  Future _isLoading() async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return _listSummaryApproval.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(
                    value: null,
                    strokeWidth: 2,
                  ),
                )
              : SimpleDialog(
                  children: [
                    InkWell(
                      onTap: () {
                        // isStepSatuFill = true;
                        // isStepDuaFill = false;
                        // isStepTigaFill = false;
                        // isStepEmpatFill = false;
                        // isStepLimaFill = false;
                        // isStepEnamFill = false;
                        // isStepTujuhFill = false;
                        // isStepDelapanFill = false;

                        SharedPrefsUtil.clearEcmId();
                        SharedPrefsUtil.clearEcmIdEdit();
                        Get.off(const Dashboard());

                        // Navigator.pushAndRemoveUntil(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => Dashboard()),
                        //     ModalRoute.withName("/"));
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
                        "assets/icons/done.png",
                        width: 150,
                      )),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      width: MediaQuery.of(context).size.width,
                      child: const Center(
                        child: Text(
                          "Terimakasih",
                          style: TextStyle(
                              color: Color(0xFF404446),
                              fontFamily: 'Rubik',
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(top: 8, left: 16, right: 16),
                      width: MediaQuery.of(context).size.width,
                      child: const Center(
                        child: Text(
                          "Formulir Anda telah disimpan dan menunggu untuk disetujui",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(0xFF404446),
                              fontFamily: 'Rubik',
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        // final prefs = await _prefs;
                        // prefs.remove("idEcm");
                        SharedPrefsUtil.clearEcmId();

                        if (_listSummaryApproval.isNotEmpty) {
                          print("data approve");
                          print(_listSummaryApproval);
                          summaryPopup();
                        } else {
                          print(_listSummaryApproval);
                        }
                      },
                      child: Container(
                          margin: EdgeInsets.only(top: 20, left: 16, right: 16),
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Color(0xFF00AEDB),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Center(
                            child: Text(
                              "Lihat Ringkasan",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Rubik',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          )),
                    )
                  ],
                );
        });
  }

  Future<void> successStep8() async {
    // final prefs = await _prefs;
    // String idUser = prefs.getString("idKeyUser").toString();
    // String tokenUser = prefs.getString("tokenKey").toString();
    // String idEcm = prefs.getString("idEcm").toString();

    String idUser = SharedPrefsUtil.getIdUser();
    String idEcmSendtoApi = ecmId.isEmpty || ecmId == "" ? ecmIdEdit : ecmId;

    print("id ecm edit atau baru: $idEcmSendtoApi");

    try {
      _listSummaryApproval = await summaryApproveService.getSummaryApproveName(
          tokenUser, idEcmSendtoApi, idUser);

      print(_listSummaryApproval[0].lineStopJam);
      // removeStepCacheFillEcm();
      // removeCacheFillEcm();

      _isLoading();
    } catch (e) {
      print(e);
      // removeStepCacheFillEcm();
      // removeCacheFillEcm();
      // setStateIfMounted(() {
      //   Navigator.pushAndRemoveUntil(
      //       context,
      //       MaterialPageRoute(builder: (context) => Dashboard()),
      //       ModalRoute.withName("/"));
      // });

      Get.off(const Dashboard());
    }
  }

  void summaryPopup() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            children: [
              InkWell(
                onTap: () async {
                  // final prefs = await _prefs;
                  // prefs.remove("idEcm");
                  // Navigator.pushAndRemoveUntil(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => Dashboard()),
                  //     ModalRoute.withName("/"));

                  SharedPrefsUtil.clearEcmId();
                  SharedPrefsUtil.clearEcmIdEdit();

                  Get.off(const Dashboard());
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 16, right: 16),
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.topRight,
                  child: Image.asset(
                    "assets/icons/X.png",
                    width: 20,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 16, right: 16),
                width: MediaQuery.of(context).size.width,
                child: const Center(
                  child: Text(
                    "Ringkasan",
                    style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF404446)),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 16, right: 16),
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
                decoration: const BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: Color(0xFFCDCFD0)))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Text(
                      "BM",
                      style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF404446)),
                    ),
                    Text(
                      "${_listSummaryApproval[0].lineStopJam}H ${_listSummaryApproval[0].lineStopMenit}M",
                      style: const TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF404446)),
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 16, right: 16),
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: const BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: Color(0xFFCDCFD0)))),
                child: const Text(
                  "E-CM harus disetujui oleh",
                  style: TextStyle(
                      color: Color(0xFF404446),
                      fontFamily: 'Rubik',
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 16, right: 16),
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: const BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: Color(0xFFCDCFD0)))),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _listSummaryApproval.length,
                  itemBuilder: (context, i) {
                    if (_listSummaryApproval[i].nama != "null") {
                      return Container(
                        margin: EdgeInsets.only(bottom: 5),
                        child: Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          _listSummaryApproval[i].foto),
                                      fit: BoxFit.fill)),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                                "${_listSummaryApproval[i].nama} - ${_listSummaryApproval[i].role}")
                          ],
                        ),
                      );
                    }

                    return Container();
                  },
                ),
              ),
              InkWell(
                onTap: () async {
                  // final prefs = await _prefs;
                  // prefs.remove("idEcm");

                  SharedPrefsUtil.clearEcmId();
                  SharedPrefsUtil.clearEcmIdEdit();
                  Get.off(Dashboard());

                  // isStepSatuFill = true;
                  // isStepDuaFill = false;
                  // isStepTigaFill = false;
                  // isStepEmpatFill = false;
                  // isStepLimaFill = false;
                  // isStepEnamFill = false;
                  // isStepTujuhFill = false;
                  // isStepDelapanFill = false;

                  // Navigator.pushAndRemoveUntil(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => Dashboard()),
                  //     ModalRoute.withName("/"));
                },
                child: Container(
                    margin: EdgeInsets.only(top: 20, left: 16, right: 16),
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    decoration: const BoxDecoration(
                        color: Color(0xFF00AEDB),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: const Center(
                      child: Text(
                        "Selesai",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Rubik',
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    )),
              )
            ],
          );
        });
  }

  Future postStepDelapan() async {
    String ecmIdNewOrEdit = ecmId.isEmpty || ecmId == "" ? ecmIdEdit : ecmId;

    setState(() {
      isClicked = 1;
    });

    try {
      var res = await fillNewDelapan(
              ecmIdNewOrEdit, engineerTo, productTo, othersTo, tokenUser)
          .timeout(const Duration(seconds: 15));

      print("response step 8:");
      print(res);

      if (res['response']['status'] == 200) {
        print("sukses");

        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return Container(
                child: const Center(
                  child: CircularProgressIndicator(
                    value: null,
                    strokeWidth: 4,
                  ),
                ),
              );
            });

        await successStep8();

        // Fluttertoast.showToast(
        //     msg: 'Selesai, data E-CM Anda disimpan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.BOTTOM,
        //     timeInSecForIosWeb: 2,
        //     fontSize: 16);
        // Get.off(Dashboard());
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Koneksi bermasalah, E-CM Anda tidak disimpan',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.BOTTOM,
        //     timeInSecForIosWeb: 2,
        //     fontSize: 16);

        // await removeEcmCancelUser.removeEcmLast(tokenUser, ecmId);
        // Get.off(Dashboard());
        // removeStepCacheFillEcm();
        // removeCacheFillEcm();
        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(builder: (context) => Dashboard()),
        //     ModalRoute.withName("/"));
      }
      // if (ecmIdEdit.isEmpty || ecmIdEdit == "" || ecmIdEdit == "null") {
      //   var res = await fillNewDelapan(
      //           ecmId, engineerToKey, productToKey, othersToKey, tokenUser)
      //       .timeout(const Duration(seconds: 15));

      //   print("response step 8:");
      //   print(res);

      //   if (res['response']['status'] == 200) {
      //     print("sukses");
      //   } else {
      //     Fluttertoast.showToast(
      //         msg: 'Koneksi bermasalah, E-CM Anda tidak disimpan',
      //         toastLength: Toast.LENGTH_SHORT,
      //         gravity: ToastGravity.BOTTOM,
      //         timeInSecForIosWeb: 2,
      //         fontSize: 16);

      //     await removeEcmCancelUser.removeEcmLast(tokenUser, ecmId);
      //     removeStepCacheFillEcm();
      //     removeCacheFillEcm();
      //     Navigator.pushAndRemoveUntil(
      //         context,
      //         MaterialPageRoute(builder: (context) => Dashboard()),
      //         ModalRoute.withName("/"));
      //   }
      // } else {
      //   var response = await fillNewDelapanEdit(
      //           ecmIdEdit, engineerToKey, productToKey, othersToKey, tokenUser)
      //       .timeout(const Duration(seconds: 15));

      //   print("response step 8 edit:");
      //   print(response);

      //   if (response['response']['status'] == 200) {
      //     print("sukses diperbarui step 8");
      //   } else {
      //     Fluttertoast.showToast(
      //         msg: 'Koneksi bermasalah, E-CM Anda tidak disimpan',
      //         toastLength: Toast.LENGTH_SHORT,
      //         gravity: ToastGravity.BOTTOM,
      //         timeInSecForIosWeb: 2,
      //         fontSize: 16);

      //     // var response =
      //     //     await removeEcmCancelUser.removeEcmLast(tokenUser, ecmId);
      //     removeStepCacheFillEcm();
      //     removeCacheFillEcm();
      //     Navigator.pushAndRemoveUntil(
      //         context,
      //         MaterialPageRoute(builder: (context) => Dashboard()),
      //         ModalRoute.withName("/"));
      //   }
      // }
    } on TimeoutException catch (_) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Timeout'),
          content:
              const Text('Jaringan anda bermasalah, silahkan coba kembali'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context)
                ..pop()
                ..pop(true),
              child: const Text('Kembali'),
            ),
            // TextButton(
            //   onPressed: () => postStepDelapan(),
            //   child: const Text('Kirim Ulang'),
            // ),
          ],
        ),
      );
      // A timeout occurred.
    } on SocketException catch (_) {
      // removeStepCacheFillEcm();
      // removeCacheFillEcm();
      setStateIfMounted(() {
        Fluttertoast.showToast(
          msg: 'Terjadi kesalahan, silahkan dicoba lagi nanti',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.greenAccent,
        );
      });
    }

    // try {
    //   if (prefs.getString("ecmIdEdit").toString() != "null") {
    //     print("step 8 edit id ecm ${prefs.getString("ecmIdEdit")}");
    //     var response = await fillNewDelapanEdit(
    //             ecmIdEdit, engineerToKey, productToKey, othersToKey, tokenUser)
    //         .timeout(const Duration(seconds: 15));

    //     print("response step 8 edit:");
    //     print(response);

    //     if (response['response']['status'] == 200) {
    //       print("sukses diperbarui step 8");
    //     } else {
    //       Fluttertoast.showToast(
    //           msg: 'Koneksi bermasalah, E-CM Anda tidak disimpan',
    //           toastLength: Toast.LENGTH_SHORT,
    //           gravity: ToastGravity.BOTTOM,
    //           timeInSecForIosWeb: 2,
    //           fontSize: 16);

    //       var response =
    //           await removeEcmCancelUser.removeEcmLast(tokenUser, ecmId);
    //       removeStepCacheFillEcm();
    //       removeCacheFillEcm();
    //       Navigator.pushAndRemoveUntil(
    //           context,
    //           MaterialPageRoute(builder: (context) => Dashboard()),
    //           ModalRoute.withName("/"));
    //     }
    //   } else {
    //     print("ini ecm baru step 8");
    //     var res = await fillNewDelapan(
    //             ecmId, engineerToKey, productToKey, othersToKey, tokenUser)
    //         .timeout(const Duration(seconds: 15));

    //     print("response step 8:");
    //     print(res);

    //     if (res['response']['status'] == 200) {
    //       print("sukses");
    //     } else {
    //       Fluttertoast.showToast(
    //           msg: 'Koneksi bermasalah, E-CM Anda tidak disimpan',
    //           toastLength: Toast.LENGTH_SHORT,
    //           gravity: ToastGravity.BOTTOM,
    //           timeInSecForIosWeb: 2,
    //           fontSize: 16);

    //       await removeEcmCancelUser.removeEcmLast(tokenUser, ecmId);
    //       removeStepCacheFillEcm();
    //       removeCacheFillEcm();
    //       Navigator.pushAndRemoveUntil(
    //           context,
    //           MaterialPageRoute(builder: (context) => Dashboard()),
    //           ModalRoute.withName("/"));
    //     }
    //   }
    // } on TimeoutException catch (_) {
    //   showDialog<String>(
    //     context: context,
    //     builder: (BuildContext context) => AlertDialog(
    //       title: const Text('Timeout'),
    //       content: const Text(
    //           'Jaringan anda bermasalah, apakah ingin mencoba ulang?'),
    //       actions: <Widget>[
    //         TextButton(
    //           onPressed: () => Navigator.of(context)
    //             ..pop()
    //             ..pop(true),
    //           child: const Text('Kembali'),
    //         ),
    //         TextButton(
    //           onPressed: () => postStepDelapan(),
    //           child: const Text('Kirim Ulang'),
    //         ),
    //       ],
    //     ),
    //   );
    //   // A timeout occurred.
    // } on SocketException catch (_) {
    //   // print(e);
    //   // var response = await removeEcmCancelUser.removeEcmLast(tokenUser, idEcm);
    //   removeStepCacheFillEcm();
    //   removeCacheFillEcm();
    //   setStateIfMounted(() {
    //     Fluttertoast.showToast(
    //       msg: 'Terjadi kesalahan, silahkan dicoba lagi nanti',
    //       toastLength: Toast.LENGTH_LONG,
    //       gravity: ToastGravity.BOTTOM,
    //       backgroundColor: Colors.greenAccent,
    //     );
    //     // Navigator.pushAndRemoveUntil(
    //     //     context,
    //     //     MaterialPageRoute(builder: (context) => Dashboard()),
    //     //     ModalRoute.withName("/"));
    //   });
    // }
  }

  @override
  void initState() {
    // TODO: implement initState
    setBahasa();
    setLang();
    super.initState();
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
        height: MediaQuery.of(context).size.height * 0.58,
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
                      isFilled: false,
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
                      isFilled: true,
                    ),
                  ],
                ),
              ),
              // Container(
              //   width: MediaQuery.of(context).size.width,
              //   child: const Text("E-Sign", style: TextStyle(fontFamily: 'Rubik', color: Color(0xFF404446), fontSize: 16, fontWeight: FontWeight.w400 ),),
              // ),
              // InkWell(
              //   onTap: (){
              //       Navigator.of(context).push(
              //         MaterialPageRoute(builder: (context) => const ApproveStepDelapan())
              //       );
              //     },
              //   child: Container(
              //     margin: const EdgeInsets.only(top: 16),
              //     width: MediaQuery.of(context).size.width,
              //     height: 40,
              //     decoration: const BoxDecoration(
              //       color: Color(0XFF00AEDB),
              //       borderRadius: BorderRadius.all(Radius.circular(5))
              //     ),
              //     child: Row(
              //       // ignore: prefer_const_literals_to_create_immutables
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       // ignore: prefer_const_literals_to_create_immutables
              //       children: [
              //         const Icon(Icons.add_circle_outline, color: Colors.white,),
              //         const SizedBox(width: 10,),
              //         const Text("Add E-Sign", style: TextStyle(fontFamily: 'Rubik', color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400 ),),
              //       ],
              //     ),
              //   ),
              // ),
              Container(
                child: Text(
                  copy_to,
                  style: TextStyle(
                      fontFamily: 'Rubik',
                      color: Color(0xFF404446),
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () async {
                        // final SharedPreferences prefs = await _prefs;
                        setState(() {
                          engineerTo = '1';
                          productTo = '0';
                          othersTo = '0';
                          copyToGroup = '1';
                          setCopyTo();
                        });
                        // prefs.setString("engineerTo", engineerTo);
                        // prefs.setString("productTo", productTo);
                        // prefs.setString("othersTo", othersTo);
                        // prefs.setString("copyToBool", "1");
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.28,
                        height: 40,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFF979C9E)),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                                width: 30,
                                height: 30,
                                child: Radio(
                                    groupValue: copyToGroup,
                                    value: '1',
                                    onChanged: (value) async {
                                      // final SharedPreferences prefs =
                                      //     await _prefs;
                                      if (value != null) {
                                        setState(() {
                                          copyToGroup = value as String;
                                          engineerTo = '1';
                                          productTo = '0';
                                          othersTo = '0';
                                          setCopyTo();
                                        });
                                        // prefs.setString("engineerTo", engineerTo);
                                        // prefs.setString("productTo", productTo);
                                        // prefs.setString("othersTo", othersTo);
                                        // prefs.setString("copyToBool", "1");
                                      }
                                    })),
                            Text(engineer)
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        // final SharedPreferences prefs = await _prefs;
                        setState(() {
                          engineerTo = '0';
                          productTo = '1';
                          othersTo = '0';
                          copyToGroup = '2';
                          setCopyTo();
                        });
                        // prefs.setString("engineerTo", engineerTo);
                        // prefs.setString("productTo", productTo);
                        // prefs.setString("othersTo", othersTo);
                        // prefs.setString("copyToBool", "1");
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.28,
                        height: 40,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFF979C9E)),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                                width: 30,
                                height: 30,
                                child: Radio(
                                    groupValue: copyToGroup,
                                    value: '2',
                                    onChanged: (value) async {
                                      final SharedPreferences prefs =
                                          await _prefs;
                                      if (value != null) {
                                        setState(() {
                                          copyToGroup = value as String;
                                          engineerTo = '0';
                                          productTo = '1';
                                          othersTo = '0';
                                          setCopyTo();
                                        });
                                        // prefs.setString("engineerTo", engineerTo);
                                        // prefs.setString("productTo", productTo);
                                        // prefs.setString("othersTo", othersTo);
                                        // prefs.setString("copyToBool", "1");
                                      }
                                    })),
                            Text(product)
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        // final SharedPreferences prefs = await _prefs;
                        setState(() {
                          engineerTo = '0';
                          productTo = '0';
                          othersTo = '1';
                          copyToGroup = '3';
                          setCopyTo();
                        });
                        // prefs.setString("engineerTo", engineerTo);
                        // prefs.setString("productTo", productTo);
                        // prefs.setString("othersTo", othersTo);
                        // prefs.setString("copyToBool", "1");
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.28,
                        height: 40,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFF979C9E)),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                                width: 30,
                                height: 30,
                                child: Radio(
                                    groupValue: copyToGroup,
                                    value: '3',
                                    onChanged: (value) async {
                                      final SharedPreferences prefs =
                                          await _prefs;
                                      if (value != null) {
                                        setState(() {
                                          copyToGroup = value as String;
                                          engineerTo = '0';
                                          productTo = '0';
                                          othersTo = '1';
                                        });
                                        // prefs.setString("engineerTo", engineerTo);
                                        // prefs.setString("productTo", productTo);
                                        // prefs.setString("othersTo", othersTo);
                                        // prefs.setString("copyToBool", "1");
                                      }
                                    })),
                            Text(others)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Container(
              //   margin: const EdgeInsets.only(top: 16),
              //   child: const Text(
              //     "Approved by",
              //     style: TextStyle(
              //         fontFamily: 'Rubik',
              //         color: Color(0xFF404446),
              //         fontSize: 16,
              //         fontWeight: FontWeight.w400),
              //   ),
              // ),
              // Container(
              //   margin: const EdgeInsets.only(top: 4),
              //   padding: const EdgeInsets.all(5),
              //   height: 40,
              //   decoration: BoxDecoration(
              //       border: Border.all(color: const Color(0xFF979C9E)),
              //       borderRadius: const BorderRadius.all(Radius.circular(5))),
              //   child: TextFormField(
              //     style: const TextStyle(
              //         fontFamily: 'Rubik',
              //         fontSize: 14,
              //         fontWeight: FontWeight.w400),
              //     decoration: const InputDecoration(
              //         border: OutlineInputBorder(borderSide: BorderSide.none),
              //         suffixIcon: Icon(Icons.search),
              //         hintText: 'Type name',
              //         contentPadding: const EdgeInsets.only(top: 5, left: 5),
              //         hintStyle: TextStyle(
              //             fontFamily: 'Rubik',
              //             fontSize: 14,
              //             fontWeight: FontWeight.w400)),
              //   ),
              // ),
              Container(
                margin: EdgeInsets.only(top: 26),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: Color(0xFF00AEDB))),
                        child: const Center(
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
                      onTap: () async {
                        if (isClicked == 0) {
                          await postStepDelapan();
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 40,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Color(0xFF00AEDB)),
                        child: const Center(
                          child: Text("Akhiri",
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
