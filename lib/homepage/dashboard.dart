// ignore_for_file: prefer_const_constructors
import 'package:e_cm/homepage/home/view/account.dart';
import 'package:e_cm/homepage/home/view/home.dart';
import 'package:e_cm/homepage/home/view/notification.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  // ignore: prefer_final_fields
  List<Widget> _listWidget = [
    Home(),
    NotificationPage(),
    Account()
  ];

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
                offset: Offset(0.0, 0.75)
            )
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => _onMenuItemTapped(0),
              child: Container(
                width: 150,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xFF00AEDB),
                  borderRadius: BorderRadius.all(Radius.circular(50))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/icons/ic_home_active.png", width: 20,),
                    SizedBox(width: 10,),
                    Text("Home", style: TextStyle(fontFamily: 'Rubik', color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),)
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () => _onMenuItemTapped(1),
              child: Container(
                width: 73,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xFFF2F4F5),
                  borderRadius: BorderRadius.all(Radius.circular(50))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/icons/ic_bell_inactive.png", width: 20,),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () => _onMenuItemTapped(2),
              child: Container(
                width: 73,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xFFF2F4F5),
                  borderRadius: BorderRadius.all(Radius.circular(50))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/icons/ic_user_inactive.png", width: 20,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
