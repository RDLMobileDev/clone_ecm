// ignore_for_file: prefer_const_constructors, avoid_print
import 'package:e_cm/homepage/account/view/account.dart';
import 'package:e_cm/homepage/home/view/home.dart';
import 'package:e_cm/homepage/notification/view/notification.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool isHome = true, isNotif = false, isAccount = false;

  int _selectedIndex = 0;
  // ignore: prefer_final_fields
  List<Widget> _listWidget = [Home(), NotificationMember(), AccountMember()];

  void _onMenuItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
          boxShadow: const <BoxShadow>[
            BoxShadow(
                color: Colors.black54,
                blurRadius: 8.0,
                offset: Offset(0.0, 0.75))
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
                            "Home",
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
                            "Notifications",
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
                            "Account",
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
