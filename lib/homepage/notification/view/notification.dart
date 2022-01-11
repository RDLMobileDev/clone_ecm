// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, duplicate_ignore

import 'dart:convert';

import 'package:e_cm/homepage/notification/model/notifmodel.dart';
import 'package:e_cm/homepage/notification/services/apinotif.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationMember extends StatefulWidget {
  const NotificationMember({Key? key}) : super(key: key);

  @override
  _NotificationMemberState createState() => _NotificationMemberState();
}

class _NotificationMemberState extends State<NotificationMember> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  String bahasa = "Bahasa Indonesia";
  bool bahasaSelected = false;

  String all_notification = '';
  String mark_as_read = '';
  String mark_read = '';
  String approve_ecm = '';
  String one_hour = '';
  String one_day_ago = '';

  String sent_you_ecm = '';
  String review = '';
  String approve = '';
  String decline = '';
  String declined = '';
  String approved = '';
  String loading = '';

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
        all_notification = dataLang['notifikasi_tl']['notification_all'];
        mark_read = dataLang['notifikasi_tl']['mark_all'];
        approve_ecm = dataLang['notifikasi_staff']['was_approve'];
        one_hour = dataLang['notifikasi_tl']['a_hour'];
        one_day_ago = dataLang['notifikasi_staff']['one_day'];
        sent_you_ecm = dataLang['notifikasi_tl']['send_ecm'];
        review = dataLang['notifikasi_tl']['review'];
        approve = dataLang['notifikasi_tl']['approve'];
        decline = dataLang['notifikasi_tl']['decline'];
        declined = dataLang['notifikasi_tl']['declined'];
        approved = dataLang['notifikasi_tl']['approved'];
        loading = dataLang['notifikasi_tl']['loading'];
        mark_as_read = dataLang['notifikasi_tl']['mark_as_read'];
      });
    }
  }

  void getLanguageId() async {
    var response = await rootBundle.loadString("assets/lang/lang-id.json");
    var dataLang = json.decode(response)['data'];

    if (mounted) {
      setState(() {
        all_notification = dataLang['notifikasi_tl']['notification_all'];
        mark_read = dataLang['notifikasi_tl']['mark_all'];
        approve_ecm = dataLang['notifikasi_staff']['was_approve'];
        one_hour = dataLang['notifikasi_tl']['a_hour'];
        one_day_ago = dataLang['notifikasi_staff']['one_day'];
        sent_you_ecm = dataLang['notifikasi_tl']['send_ecm'];
        review = dataLang['notifikasi_tl']['review'];
        approve = dataLang['notifikasi_tl']['approve'];
        decline = dataLang['notifikasi_tl']['decline'];
        declined = dataLang['notifikasi_tl']['declined'];
        approved = dataLang['notifikasi_tl']['approved'];
        loading = dataLang['notifikasi_tl']['loading'];
        mark_as_read = dataLang['notifikasi_tl']['mark_as_read'];
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

  List<NotificationModel> listNotificationEcm = [];

  Future getListNotif() async {
    final prefs = await _prefs;
    String tokenUser = prefs.getString("tokenKey").toString();
    String idUser = prefs.getString("idKeyUser").toString();

    listNotificationEcm =
        await notifikasiService.getNotificationData(tokenUser, idUser);

    return notifikasiService.getNotificationData(tokenUser, idUser);
  }

  // String bahasa = "Bahasa Indonesia";
  // bool bahasaSelected = false;

  // String all_notification = "";
  String mark = "";
  String notification = "";

  // void setBahasa() async {
  //   final prefs = await _prefs;
  //   String bahasaBool = prefs.getString("bahasa") ?? "";

  //   if (bahasaBool.isNotEmpty && bahasaBool == "Bahasa Indonesia") {
  //     setState(() {
  //       bahasaSelected = false;
  //       bahasa = bahasaBool;
  //     });
  //   } else if (bahasaBool.isNotEmpty && bahasaBool == "English") {
  //     setState(() {
  //       bahasaSelected = true;
  //       bahasa = bahasaBool;
  //     });
  //   } else {
  //     setState(() {
  //       bahasaSelected = false;
  //       bahasa = "Bahasa Indonesia";
  //     });
  //   }
  // }

  // void getLanguageEn() async {
  //   var response = await rootBundle.loadString("assets/lang/lang-en.json");
  //   var dataLang = json.decode(response)['data'];
  //   if (mounted) {
  //     setState(() {
  //       all_notification = dataLang['notification']['all_notification'];
  //       mark = dataLang['notification']['mark'];
  //       notification = dataLang['notification']['notification'];
  //     });
  //   }
  // }

  // void getLanguageId() async {
  //   var response = await rootBundle.loadString("assets/lang/lang-id.json");
  //   var dataLang = json.decode(response)['data'];

  //   if (mounted) {
  //     setState(() {
  //       all_notification = dataLang['notification']['all_notification'];
  //       mark = dataLang['notification']['mark'];
  //       notification = dataLang['notification']['notification'];
  //     });
  //   }
  // }

  // void setLang() async {
  //   final prefs = await _prefs;
  //   var langSetting = prefs.getString("bahasa") ?? "";
  //   print(langSetting);

  //   if (langSetting.isNotEmpty && langSetting == "Bahasa Indonesia") {
  //     getLanguageId();
  //   } else if (langSetting.isNotEmpty && langSetting == "English") {
  //     getLanguageEn();
  //   } else {
  //     getLanguageId();
  //   }
  // }

  void markAsRead() {
    setState(() {
      Fluttertoast.showToast(
          msg: mark_as_read,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.greenAccent,
          textColor: Colors.white,
          fontSize: 16);
    });
  }

  @override
  void initState() {
    getListNotif();
    super.initState();
    setBahasa();
    setLang();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(16, 45, 24, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(all_notification,
                    style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 16,
                        color: Color(0xff404446),
                        fontWeight: FontWeight.w700)),
                InkWell(
                  onTap: () {
                    markAsRead();
                  },
                  child: Text(mark_read,
                      style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 12,
                          color: Color(0xff00AEDB))),
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.black54,
          ),
          Container(
            padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
            child: FutureBuilder(
              future: getListNotif(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text(notification);
                }

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: listNotificationEcm.length,
                  itemBuilder: (context, i) {
                    return Row(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/images/sudin.png"),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                ),
                                children: [
                                  TextSpan(
                                    text: listNotificationEcm[i].nama,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueAccent),
                                  ),
                                  TextSpan(text: " "),
                                  TextSpan(
                                    text: approve_ecm,
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  )
                                ],
                              ),
                            ),
                            Text(
                              listNotificationEcm[i].waktu,
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            )
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
