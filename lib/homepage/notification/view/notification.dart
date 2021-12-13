// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, duplicate_ignore

import 'package:e_cm/homepage/notification/services/apinotif.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/painting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationMember extends StatefulWidget {
  const NotificationMember({Key? key}) : super(key: key);

  @override
  _NotificationMemberState createState() => _NotificationMemberState();
}

class _NotificationMemberState extends State<NotificationMember> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  List listNotif = [];

  Future getListNotifFromService() async {
    final prefs = await _prefs;
    String tokenUser = prefs.getString("tokenKey").toString();
    String idUser = prefs.getString("idKeyUser").toString();

    // String tokenUser =
    //     "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMzY0Y2JiMDJhOGVkNDA3NzIyMmM2YzI2Yzk5YzYwNzc2N2M1MWViYzU0MmMyNmNhZGEwMGJjYTYzOGNhODZmYjNiY2JjMGExOTY1M2YzZDUiLCJpYXQiOjE2MzkyMDM4MjEsIm5iZiI6MTYzOTIwMzgyMSwiZXhwIjoxNjcwNzM5ODIxLCJzdWIiOiIxMiIsInNjb3BlcyI6W119.WehS3Hg0r-U77kWxXOjPpB-dtOgSLNgfCh_BfGqUrn4QOBHuVVVDOsWpZZ3tPFSrPTgsT-5kgn8DMYDI9dlt4wLGVz8rls7fKf__R4sa3KnHocasT_WBteBPFYbzTYoD91-u9I3ZD4VZWFSEMh_3D62RRkDC_b13XUFJsOuYEFKZ2ljTjkT5Jm3MCFlxnLyMs1cudFEWTWJEvJNipHX70cmsD6K8RnxEaNzsfMHnN4f7GyHWdVk4asa0j8CibxDGecCFZlouxj763k-o3nRMSCDeXRk6yAWjk2j5g47etXu7s1RgRPEy8hAQBRpjhsCQNfIUJJpB53EKmPbtlXsP53hilNFBxw79VxL7Ihr9NdsEE8ENvxefPXiKgLBAJah318Qfh1Xh0qKYkuMuFCnt4GXdI0MI5Zbno0OxLUbGOrnglgm6g_ZZDDNCYfHlr8nd3Z3Y9roFX1yceZXOSoOoKYD5Ohfafd8kLESpFPaZBrjnB-bppmeEpi38fccM5jvAUyR6VS4RoTLKXOMPYAQYzUIeN23ca0UKEMUSVpTTagelxF_xVJ2Ax2SAY3YR0DNfqkGcz31QlKpAXi2BbsytIKwRcGd5XY5fAvg-4q-AKWXo-caERBSbXu9RZecrPzptTGV536dW7zqjbjUelyI71_Z_PTiGxwZoZVYr3NDCTR8";
    // String idUser = "5";

    listNotif = await listNotifService.getListNotif(tokenUser, idUser);

    print("notif data -> $listNotif");

    return await listNotifService.getListNotif(tokenUser, idUser);
  }

  @override
  void initState() {
    getListNotifFromService();
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
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(16),
            child: FutureBuilder(
              future: getListNotifFromService(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: Text(
                        "Loading List Notification...",
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: listNotif.length,
                  itemBuilder: (context, i) {
                    return Container(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Color(0xFFE3E5E5)))),
                      child: Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                                color: Color(0xFF00AEDB),
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image:
                                        AssetImage("assets/images/ario.png"))),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 16,
                              ),
                              // ignore: prefer_const_literals_to_create_immutables
                              children: <TextSpan>[
                                TextSpan(
                                    text: listNotif[i]['nama'],
                                    style: TextStyle(
                                        color: Color(0xFF00AEDB),
                                        fontWeight: FontWeight.w700)),
                                TextSpan(
                                    text: ' - ',
                                    style: TextStyle(color: Color(0xFF00AEDB))),
                                TextSpan(
                                    text: listNotif[i]['status'],
                                    style: TextStyle(color: Color(0xFF00AEDB))),
                              ],
                            ),
                          ),
                        ],
                      ),
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
