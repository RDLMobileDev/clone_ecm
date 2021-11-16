// ignore_for_file: prefer_const_constructors
import 'package:e_cm/homepage/home/view/account.dart';
import 'package:e_cm/homepage/home/view/home.dart';
import 'package:e_cm/homepage/home/view/notification.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
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
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.blue,
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/icons/ic_home.png"),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/icons/ic_bell.png"),
            ),
            label: "Notification",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/icons/ic_user_inactive.png"),
            ),
            label: "Account",
          ),
        ],
        selectedFontSize: 12.0,
        unselectedFontSize: 12.0,
        selectedLabelStyle: TextStyle(
          fontFamily: 'Rubik',
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: 'Rubik',
        ),
        currentIndex: _selectedIndex,
        onTap: _onMenuItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
