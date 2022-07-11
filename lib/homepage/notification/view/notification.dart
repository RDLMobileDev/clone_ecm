// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, duplicate_ignore

import 'dart:convert';

import 'package:e_cm/homepage/notification/model/notif_model_new.dart';
import 'package:e_cm/homepage/notification/model/notifmodel.dart';
import 'package:e_cm/homepage/notification/services/apinotif.dart';
import 'package:e_cm/homepage/notification/services/get_list_nofit.dart';
import 'package:e_cm/util/shared_prefs_util.dart';
import 'package:e_cm/widget/network_image_widget.dart';
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
  String no_notification = '';
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
        no_notification = dataLang['notifikasi_tl']['no_notification'];
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
        no_notification = dataLang['notifikasi_tl']['no_notification'];
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
  List<NotifModelNew> listNotifNew = [];

  Future getListNotif() async {
    final prefs = await _prefs;
    String tokenUser = SharedPrefsUtil.getTokenUser();
    String userId = SharedPrefsUtil.getIdUser();

    listNotificationEcm =
        await notifikasiService.getNotificationData(tokenUser, userId);

    return notifikasiService.getNotificationData(tokenUser, userId);
  }

  Future<List<NotifModelNew>> getListNotifNew() async {
    final SharedPreferences prefs = await _prefs;
    String tokenUser = SharedPrefsUtil.getTokenUser();
    String idUser = SharedPrefsUtil.getIdUser();
    print("idUser = " + idUser.toString());
    try {
      var response = await getListNotification(idUser, tokenUser);
      if (response['response']['status'] == 200) {
        setStateIfMounted(() {
          var data = response['data'] as List;
          listNotifNew = data.map((e) => NotifModelNew.fromJson(e)).toList();
          print("===== list approved =====");
          print(data.length);
          // print(response['data']);
          print("===== || =====");
        });
      } else {
        // Fluttertoast.showToast(
        //     msg: 'Periksa jaringan internet anda',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.BOTTOM,
        //     timeInSecForIosWeb: 2,
        //     backgroundColor: Colors.greenAccent,
        //     textColor: Colors.white,
        //     fontSize: 16);
      }
    } catch (e) {
      print("approved exception $e");
    }
    return listNotifNew;
  }

  void setStateIfMounted(f) {
    if (mounted) setState(f);
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
    super.initState();
    // getListNotif();
    getListNotifNew();
    setBahasa();
    setLang();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          title: Text(all_notification,
              style: TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 16,
                  color: Color(0xff404446),
                  fontWeight: FontWeight.w700)),
          actions: [
            Center(
              child: Container(
                margin: EdgeInsets.only(
                  right: 16,
                ),
                child: InkWell(
                  onTap: () => markAsRead(),
                  child: Text(mark_read,
                      style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 12,
                          color: Color(0xff00AEDB))),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.fromLTRB(16, 16, 0, 0),
          child: listNotifNew.isEmpty
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: Text(no_notification))
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: listNotifNew.length,
                  itemBuilder: (context, i) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: NetworkImageWidget(
                                  imageUri: listNotifNew[i].photo.toString()),
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.79,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(listNotifNew[i].nama.toString(),
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blueAccent)),
                                    Text(approve_ecm,
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey))
                                  ],
                                ),
                              ),
                              Text(
                                listNotifNew[i].waktu.toString(),
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
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
