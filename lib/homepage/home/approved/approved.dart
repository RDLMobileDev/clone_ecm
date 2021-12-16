// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:e_cm/homepage/home/model/approvedmodel.dart';
import 'package:e_cm/homepage/home/services/apigetapproved.dart';
import 'package:e_cm/homepage/home/services/apiupdatestatusecm.dart';
import 'package:e_cm/homepage/notification/view/detailecm.dart';
import 'package:e_cm/util/dialog_util.dart';
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
      body: FutureBuilder(
          future: getApprovedData(),
          builder: (BuildContext context,
              AsyncSnapshot<List<ApprovedModel>> snapshot) {
            if (snapshot.hasData) {
              return _listApproved.isEmpty
                  ? _buildErrorResultWidget()
                  : _buildBodyWidget();
            }

            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Wrap(
                  children: const [
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget _buildBodyWidget() {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: _listApproved.length,
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
                                text: 'E-CM Card from ',
                                style: TextStyle(color: Color(0xFF6C7072))),
                            TextSpan(
                                text: _listApproved[i].nama.toString(),
                                style: TextStyle(
                                    color: Color(0xFF00AEDB),
                                    fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                      const Text(
                        "1 hour ago",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 10,
                            color: Color(0xFF979C9E)),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 22),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => DetailEcm(
                                          notifId: _listApproved[i]
                                              .notifEcmId
                                              .toString(),
                                        )));
                              },
                              child: Container(
                                width: 70,
                                height: 32,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xFF00AEDB)),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5))),
                                child: const Center(
                                  child: Text(
                                    "Review",
                                    style: TextStyle(
                                        fontFamily: 'Rubik',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Visibility(
                              visible: _listApproved[i].status != "2",
                              child: Container(
                                width: 70,
                                height: 32,
                                decoration: BoxDecoration(
                                    color: _listApproved[i].status != "1"
                                        ? Color(0xFF00AEDB)
                                        : Color(0xFF979C9E),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: Center(
                                  child: TextButton(
                                    onPressed: _listApproved[i].status != "1"
                                        ? () => showCustomDialog(
                                              context: context,
                                              assetPath:
                                                  "assets/icons/Sign.png",
                                              title: "Confirm",
                                              message: "Yakin untuk menyetujui",
                                              positiveButtonTitle: "Approved",
                                              positiveCallback: () =>
                                                  postUpdateStatus(
                                                "1",
                                                _listApproved[i]
                                                    .notifEcmId
                                                    .toString(),
                                              ),
                                            )
                                        : () {},
                                    child: Text(
                                      _listApproved[i].status == "1"
                                          ? "Approved"
                                          : "Approve",
                                      style: TextStyle(
                                          fontFamily: 'Rubik',
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: _listApproved[i].status != "2",
                              child: SizedBox(
                                width: 8,
                              ),
                            ),
                            Visibility(
                              visible: _listApproved[i].status != "1",
                              child: Container(
                                width: 70,
                                height: 32,
                                decoration: BoxDecoration(
                                    color: _listApproved[i].status != "2"
                                        ? Color(0xFFFF0000)
                                        : Color(0xFF979C9E),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: Center(
                                  child: TextButton(
                                    onPressed: _listApproved[i].status != "2"
                                        ? () => showCustomDialog(
                                              context: context,
                                              assetPath:
                                                  "assets/icons/Sign.png",
                                              title: "Confirm",
                                              message: "Yakin untuk menolak",
                                              positiveButtonTitle: "Decline",
                                              positiveCallback:
                                                  postUpdateStatus(
                                                "2",
                                                _listApproved[i]
                                                    .notifEcmId
                                                    .toString(),
                                              ),
                                            )
                                        : () {},
                                    child: Text(
                                      _listApproved[i].status == "2"
                                          ? "Declined"
                                          : "Decline",
                                      style: TextStyle(
                                          fontFamily: 'Rubik',
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
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
    );
  }

  Widget _buildErrorResultWidget() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Wrap(
          children: const [
            Text("Data E-CM card untuk user ini tidak ada"),
          ],
        ),
      ),
    );
  }

  postUpdateStatus(String statusUser, String notifUser) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tokenUser = prefs.getString("tokenKey").toString();
    try {
      var response = await updateStatus(notifUser, statusUser, tokenUser);

      if (response['response']['status'] != 200) {
        Fluttertoast.showToast(
            msg: 'Pembaruan status gagal',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.white,
            fontSize: 16);
        return;
      }

      Fluttertoast.showToast(
          msg: 'Pembaruan status sukses',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.greenAccent,
          textColor: Colors.white,
          fontSize: 16);
      setState(() {
        getApprovedData();
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
}
