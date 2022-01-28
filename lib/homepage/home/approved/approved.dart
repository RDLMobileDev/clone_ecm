// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:e_cm/homepage/home/model/approvedmodel.dart';
import 'package:e_cm/homepage/home/services/apigetapproved.dart';
import 'package:e_cm/homepage/notification/view/detailecm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApprovedEcm extends StatefulWidget {
  const ApprovedEcm({Key? key}) : super(key: key);

  @override
  _ApprovedEcmState createState() => _ApprovedEcmState();
}

class _ApprovedEcmState extends State<ApprovedEcm> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  String bahasa = "Bahasa Indonesia";
  bool bahasaSelected = false;

  String? ecm_from;
  String one_hour = '';
  String review = '';
  String approve = '';
  String decline = '';
  String approved = '';
  String yesterday = '';

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
        ecm_from = dataLang['setuju_e_sign']['ecm_card_from'];
        one_hour = dataLang['setuju_e_sign']['one_hour'];
        review = dataLang['setuju_e_sign']['review'];
        approve = dataLang['setuju_e_sign']['approve'];
        decline = dataLang['setuju_e_sign']['decline'];
        approved = dataLang['setuju_e_sign']['approved'];
        yesterday = dataLang['setuju_e_sign']['yesterday'];
       
      });
    }
  }

  void getLanguageId() async {
    var response = await rootBundle.loadString("assets/lang/lang-id.json");
    var dataLang = json.decode(response)['data'];
  
    if (mounted) {
      setState(() {
       ecm_from = dataLang['setuju_e_sign']['ecm_card_from'];
        one_hour = dataLang['setuju_e_sign']['one_hour'];
        review = dataLang['setuju_e_sign']['review'];
        approve = dataLang['setuju_e_sign']['approve'];
        decline = dataLang['setuju_e_sign']['decline'];
        approved = dataLang['setuju_e_sign']['approved'];
        yesterday = dataLang['setuju_e_sign']['yesterday'];
       
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

  List<ApprovedModel> _listApproved = [];

  Future<List<ApprovedModel>> getApprovedData() async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    String? tokenUser = prefs.getString("tokenKey").toString();
    String? idUser = prefs.getString("idKeyUser").toString();
    print("jabatan = " + idUser.toString());
    try {
      var response = await getApproved(idUser, tokenUser);
      if (response['response']['status'] == 200) {
        var data = response['data'] as List;
        _listApproved = data.map((e) => ApprovedModel.fromJson(e)).toList();
        print("===== list approved =====");
        print(data.length);
        // print(response['data']);
        print("===== || =====");

      } else {
        Fluttertoast.showToast(
            msg: 'Periksa jaringan internet anda',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.white,
            fontSize: 16);
      }
    } catch (e) {
      print("approved exception $e");
    }
    return _listApproved;
  }

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  @override
  void initState() {
    super.initState();
    getApprovedData();
    setBahasa();
    setLang();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF00AEDB),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          "E-CM Card",
          style: TextStyle(
              fontFamily: 'Rubik', fontSize: 16, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(16),
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _listApproved.isEmpty ? 0 : _listApproved.length,
            itemBuilder: (context, i) {
              return Container(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: const BoxDecoration(
                          color: Color(0xFF00AEDB),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage("assets/images/ario.png"))),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontFamily: 'Rubik',
                              fontSize: 16,
                            ),
                            // ignore: prefer_const_literals_to_create_immutables
                            children: <TextSpan>[
                              TextSpan(
                                  text: ecm_from,
                                  style: TextStyle(color: Color(0xFF6C7072))),
                              TextSpan(
                                  text: _listApproved[i].nama.toString(),
                                  style: TextStyle(
                                      color: Color(0xFF00AEDB),
                                      fontWeight: FontWeight.w700)),
                            ],
                          ),
                          // ignore: prefer_const_literals_to_create_immutables
                          // children: <TextSpan>[
                          //   TextSpan(
                          //       text: 'E-CM Card from ',
                          //       style: TextStyle(color: Color(0xFF6C7072))),
                          //   TextSpan(
                          //       text: _listApproved[i].nama.toString(),
                          //       style: TextStyle(
                          //           color: Color(0xFF00AEDB),
                          //           fontWeight: FontWeight.w700)),
                          // ],
                        ),
                        Text(
                          one_hour,
                          style: TextStyle(
                              fontFamily: 'Rubik',
                              fontSize: 10,
                              color: Color(0xFF979C9E)),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 22),
                          child: _listApproved[i].status == "null"
                              ? Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: (context) => DetailEcm(
                                                  isShowButton: true,
                                                      notifId: _listApproved[i]
                                                          .notifEcmId
                                                          .toString(),
                                                    )));
                                        print("ok");
                                      },
                                      child: Container(
                                        width: 63,
                                        height: 24,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: const Color(0xFF00AEDB)),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(5))),
                                        child: Center(
                                          child: Text(
                                            review,
                                            style: TextStyle(
                                                fontFamily: 'Rubik',
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : _listApproved[i].status == "0"
                                  ? Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetailEcm(
                                                          isShowButton: true,
                                                          notifId:
                                                              _listApproved[i]
                                                                  .notifEcmId
                                                                  .toString(),
                                                        )));
                                            print("ok");
                                          },
                                          child: Container(
                                            width: 63,
                                            height: 24,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: const Color(
                                                        0xFF00AEDB)),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(5))),
                                            child: Center(
                                              child: Text(
                                                review,
                                                style: TextStyle(
                                                    fontFamily: 'Rubik',
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Container(
                                          width: 63,
                                          height: 24,
                                          decoration: BoxDecoration(
                                              color: Color(0xFF00AEDB),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          child: Center(
                                            child: Text(
                                              approve,
                                              style: TextStyle(
                                                  fontFamily: 'Rubik',
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Container(
                                          width: 63,
                                          height: 24,
                                          decoration: BoxDecoration(
                                              color: Color(0xFFFF0000),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          child: Center(
                                            child: Text(
                                              decline,
                                              style: TextStyle(
                                                  fontFamily: 'Rubik',
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : _listApproved[i].status == "1"
                                      ? Row(
                                          children: [
                                            Container(
                                              width: 63,
                                              height: 24,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF00AEDB),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5))),
                                              child: Center(
                                                child: Text(
                                                  approve,
                                                  style: TextStyle(
                                                      fontFamily: 'Rubik',
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Container(
                                          width: 63,
                                          height: 24,
                                          decoration: BoxDecoration(
                                              color: Color(0xFFFF0000),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          child: Center(
                                            child: Text(
                                              decline,
                                              style: TextStyle(
                                                  fontFamily: 'Rubik',
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
