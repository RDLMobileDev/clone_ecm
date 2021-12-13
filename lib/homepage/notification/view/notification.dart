// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, duplicate_ignore

import 'package:e_cm/homepage/notification/model/notifmodel.dart';
import 'package:e_cm/homepage/notification/services/apinotif.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationMember extends StatefulWidget {
  const NotificationMember({Key? key}) : super(key: key);

  @override
  _NotificationMemberState createState() => _NotificationMemberState();
}

class _NotificationMemberState extends State<NotificationMember> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  List<NotificationModel> listNotificationEcm = [];

  Future getListNotif() async {
    final prefs = await _prefs;
    String tokenUser = prefs.getString("tokenKey").toString();
    String idUser = prefs.getString("idKeyUser").toString();

    listNotificationEcm =
        await notifikasiService.getNotificationData(tokenUser, idUser);

    return notifikasiService.getNotificationData(tokenUser, idUser);
  }

  @override
  void initState() {
    getListNotif();
    super.initState();
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
                Text("All Notification",
                    style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 16,
                        color: Color(0xff404446),
                        fontWeight: FontWeight.w700)),
                Text("Mark all as read",
                    style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 12,
                        color: Color(0xff00AEDB))),
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
                  return Text("Memuat notifikasi...");
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
                                    text: "Was Aproved yout E-CM Card",
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
