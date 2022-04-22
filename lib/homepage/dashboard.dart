// ignore_for_file: prefer_const_constructors, avoid_print
import 'dart:async';
import 'dart:convert';

import 'package:e_cm/homepage/account/view/account.dart';
import 'package:e_cm/homepage/home/view/home.dart';
import 'package:e_cm/homepage/notification/view/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool isHome = true, isNotif = false, isAccount = false;

  String homeName = '';
  String notifName = '';
  String accountName = '';

  int _selectedIndex = 0;
  // ignore: prefer_final_fields
  List<Widget> _listWidget = [Home(), NotificationMember(), AccountMember()];

  void _onMenuItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void getLanguageEn() async {
    var response = await rootBundle.loadString("assets/lang/lang-en.json");
    var dataLang = json.decode(response)['data'];
    if (mounted) {
      setState(() {
        homeName = dataLang['menu_nav']['home'];
        notifName = dataLang['menu_nav']['notif'];
        accountName = dataLang['menu_nav']['account'];
      });
    }
  }

  void getLanguageId() async {
    var response = await rootBundle.loadString("assets/lang/lang-id.json");
    var dataLang = json.decode(response)['data'];
    if (mounted) {
      setState(() {
        homeName = dataLang['menu_nav']['home'];
        notifName = dataLang['menu_nav']['notif'];
        accountName = dataLang['menu_nav']['account'];
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

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (mounted) {
      setState(() {
        setLang();
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setLang();

    Timer _timer =
        Timer.periodic(Duration(milliseconds: 500), (timer) => setLang());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _listWidget.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        height: 70,
        decoration: BoxDecoration(
          // ignore: prefer_const_literals_to_create_immutables
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  isHome = true;
                  isNotif = false;
                  isAccount = false;
                });

                _onMenuItemTapped(0);
              },
              child: Container(
                width: isHome == true ? 150 : 73,
                height: 50,
                decoration: BoxDecoration(
                    color:
                        isHome == true ? Color(0xFF00AEDB) : Color(0xFFF2F4F5),
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: isHome == true
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/icons/ic_home_active.png",
                            width: 20,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            homeName,
                            style: TextStyle(
                                fontFamily: 'Rubik',
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      )
                    : Center(
                        child: Image.asset(
                          "assets/icons/ic_home_inactive.png",
                          width: 20,
                        ),
                      ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  isHome = false;
                  isNotif = true;
                  isAccount = false;
                });

                print(isHome);

                _onMenuItemTapped(1);
              },
              child: Container(
                width: isNotif == true ? 150 : 73,
                height: 50,
                decoration: BoxDecoration(
                    color:
                        isNotif == true ? Color(0xFF00AEDB) : Color(0xFFF2F4F5),
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: isNotif == true
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/icons/ic_bell_active.png",
                            width: 20,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            notifName,
                            style: TextStyle(
                                fontFamily: 'Rubik',
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      )
                    : Center(
                        child: Image.asset(
                          "assets/icons/ic_bell_inactive.png",
                          width: 20,
                        ),
                      ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  isHome = false;
                  isNotif = false;
                  isAccount = true;
                });

                _onMenuItemTapped(2);
              },
              child: Container(
                width: isAccount == true ? 150 : 73,
                height: 50,
                decoration: BoxDecoration(
                    color: isAccount == true
                        ? Color(0xFF00AEDB)
                        : Color(0xFFF2F4F5),
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: isAccount == true
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/icons/ic_user_active.png",
                            width: 20,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            accountName,
                            style: TextStyle(
                                fontFamily: 'Rubik',
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      )
                    : Center(
                        child: Image.asset(
                          "assets/icons/ic_user_inactive.png",
                          width: 20,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
