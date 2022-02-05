// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace

import 'dart:async';
import 'dart:convert';

import 'dart:io';

import 'package:e_cm/auth/view/login.dart';
import 'package:e_cm/homepage/account/services/apilogout.dart';
import 'package:e_cm/homepage/account/services/apiuser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountMember extends StatefulWidget {
  const AccountMember({Key? key}) : super(key: key);

  @override
  _AccountMemberState createState() => _AccountMemberState();
}

class _AccountMemberState extends State<AccountMember> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  String locale = Platform.localeName;

  static const _localizedValues = <String, Map<String, String>>{
    'en_US': {
      'logout_sukses': 'Logout Success',
      'check': 'Check your connection',
      'problem': 'There was a problem with your connection',
      'logout': 'Do you sure to logout?'
    },
    'id_ID': {
      'logout_sukses': 'Logout sukses',
      'check': 'Periksa koneksi internet',
      'problem': 'Terjadi masalah pada koneksi Anda',
      'logout': 'Apakah anda yakin ingin keluar?'
    },
  };

  String userName = "";
  String emailName = "";
  String roleName = "";
  String photoUserLink = "";

  String bahasa = "Bahasa Indonesia";
  bool bahasaSelected = false;

  String logoutName = '';
  String leaveName = '';
  String confirm = '';
  String confirm_logout = '';
  String cancel = '';
  String leave = '';

  void confirmLogout() {
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
                    confirm,
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
                    confirm_logout,
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
                            "Cancel",
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
                      postLogout();
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
                            "Logout",
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
        logoutName = dataLang['account']['logout'];
        leaveName = dataLang['account']['leave'];
        confirm = dataLang['account']['confirm'];
        confirm_logout = dataLang['account']['confirm_logout'];
        cancel = dataLang['account']['cancel'];
      });
    }
  }

  void getLanguageId() async {
    var response = await rootBundle.loadString("assets/lang/lang-id.json");
    var dataLang = json.decode(response)['data'];

    if (mounted) {
      setState(() {
        logoutName = dataLang['account']['logout'];
        leaveName = dataLang['account']['leave'];
        confirm = dataLang['account']['confirm'];
        confirm_logout = dataLang['account']['confirm_logout'];
        cancel = dataLang['account']['cancel'];
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

  postLogout() async {
    final SharedPreferences prefs = await _prefs;
    String emailUser = prefs.getString("emailKey").toString();
    String deviceUser = prefs.getString("deviceKey").toString();
    String? tokenUser = prefs.getString("tokenKey").toString();
    try {
      // prefs.clear();
      var rspLogut = await logoutUser(emailUser, deviceUser, tokenUser);
      print(rspLogut);
      if (rspLogut['response']['status'] == 200) {
        setState(() {
          Fluttertoast.showToast(
              msg:
                  _localizedValues[locale]!['logout_sukses'] ?? "Logout sukses",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.greenAccent,
              textColor: Colors.white,
              fontSize: 16);
        });
        prefs.clear();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LogIn()),
            (Route<dynamic> route) => false);
        // setState(() {
        //   Fluttertoast.showToast(
        //       msg: _localizedValues[locale]!['check'] ??
        //           'Periksa jaringan internet anda',
        //       toastLength: Toast.LENGTH_SHORT,
        //       gravity: ToastGravity.BOTTOM,
        //       timeInSecForIosWeb: 2,
        //       backgroundColor: Colors.greenAccent,
        //       textColor: Colors.white,
        //       fontSize: 16);
        // });
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: _localizedValues[locale]!['check'] ??
              'Periksa jaringan internet anda',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.greenAccent,
          textColor: Colors.white,
          fontSize: 16);
    }
  }

  getDataUser() async {
    final SharedPreferences prefs = await _prefs;
    String emailUser = prefs.getString("emailKey").toString();
    String? tokenUser = prefs.getString("tokenKey").toString();
    String nameUser = prefs.getString("usernameKey").toString();
    String roleUser = prefs.getString("namaJabatanKey").toString();
    String photoUser = prefs.getString("photoUser") ?? "-";

    print(emailUser);
    setState(() {
      userName = nameUser;
      emailName = emailUser;
      roleName = roleUser;
      photoUserLink = photoUser;
    });

    var rspGetUser = await getUser(emailUser, tokenUser);
    print(rspGetUser);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataUser();
    setBahasa();
    setLang();

    if (Platform.localeName != "en_US" || Platform.localeName != "id_ID") {
      setState(() {
        locale = "en_US";
      });
    }

    Timer _timer =
        Timer.periodic(Duration(milliseconds: 500), (timer) => setLang());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.fromLTRB(16, 40, 24, 16),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  children: [
                    Container(
                      width: 74,
                      height: 74,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(photoUserLink))),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          style: TextStyle(
                              fontFamily: 'Rubik',
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF404446)),
                        ),
                        Text(
                          emailName + " - (" + roleName + ")",
                          style: TextStyle(
                              fontFamily: 'Rubik',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF979C9E)),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Divider(
                height: 2,
                color: Color(0xFFE3E5E5),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 16),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Icon(
                        Icons.translate,
                        color: Colors.white,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 14),
                          width: MediaQuery.of(context).size.width * 0.595,
                          child: Text(
                            bahasa,
                            style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 16,
                                color: Colors.lightBlue,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 14),
                          width: MediaQuery.of(context).size.width * 0.595,
                          child: Text(
                            bahasa == 'Bahasa Indonesia'
                                ? "Gunakan bahasa berbeda pada app ini"
                                : "Use app in another language",
                            style: TextStyle(
                              fontFamily: 'Rubik',
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    FlutterSwitch(
                        width: 65,
                        height: 30,
                        activeText: 'EN',
                        inactiveText: 'ID',
                        value: bahasaSelected,
                        showOnOff: true,
                        onToggle: (value) async {
                          final prefs = await _prefs;
                          setState(() {
                            bahasaSelected = !bahasaSelected;
                            if (bahasaSelected == false) {
                              bahasa = "Bahasa Indonesia";
                            } else {
                              bahasa = "English";
                            }
                          });
                          prefs.setString("bahasa", bahasa);
                        })
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  confirmLogout();
                  // showDialog<String>(
                  //    context: context,
                  //    builder: (BuildContext context) => showDialogLogout());
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Color(0xFFFF0000),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: Icon(
                              Icons.logout,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                logoutName,
                                style: TextStyle(
                                    fontFamily: 'Rubik',
                                    color: Color(0xFFFF0000),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                leaveName,
                                style: TextStyle(
                                    fontFamily: 'Rubik',
                                    color: Color(0xFF979C9E),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          )
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Color(0xFF979C9E),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showDialogLogout() {
    return SimpleDialog(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              Navigator.pop(context);
            });
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
          margin: EdgeInsets.only(top: 10),
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            "assets/images/img_attendance_logout.png",
            width: 100,
            height: 100,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 8),
          alignment: Alignment.center,
          child: Row(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Confirm",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black54,
                    fontFamily: 'Rubik',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(right: 20, left: 20),
          child: Text(
            "E-CM must approved by",
            style: TextStyle(
                fontFamily: 'Rubik', color: Colors.black54, fontSize: 16),
          ),
        ),
        Container(
            margin: EdgeInsets.only(top: 8, left: 16, right: 16),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 30,
                        height: 30,
                        child: Image.asset("assets/images/img_ava.png"),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          "Dadi",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: Text(
                          " - ",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: Text(
                          "GM",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
        InkWell(
          onTap: () {},
          child: Row(
            children: [
              Container(
                  margin: EdgeInsets.only(top: 20, left: 16, right: 16),
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Color(0xFF00AEDB),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Center(
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Rubik',
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  )),
              InkWell(
                onTap: () {
                  setState(() {
                    postLogout();
                  });
                },
                child: Container(
                    margin: EdgeInsets.only(top: 20, left: 16, right: 16),
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Center(
                      child: Text(
                        "Logout",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Rubik',
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    )),
              ),
            ],
          ),
        )
      ],
    );
  }
}
