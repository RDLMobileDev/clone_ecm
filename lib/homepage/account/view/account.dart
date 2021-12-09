// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace

import 'dart:math';

import 'package:e_cm/auth/view/login.dart';
import 'package:e_cm/homepage/account/services/apilogout.dart';
import 'package:e_cm/homepage/account/services/apiuser.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountMember extends StatefulWidget {
  const AccountMember({Key? key}) : super(key: key);

  @override
  _AccountMemberState createState() => _AccountMemberState();
}

class _AccountMemberState extends State<AccountMember> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  String userName = "";
  String emailName = "";

  postLogout() async {
    final SharedPreferences prefs = await _prefs;
    String emailUser = prefs.getString("emailKey").toString();
    String deviceUser = prefs.getString("deviceKey").toString();
    String? tokenUser = prefs.getString("tokenKey").toString();
    try {
      var rspLogut = await logoutUser(emailUser, deviceUser, tokenUser);
      // print(rspLogut);
      if (rspLogut['response']['status'] == 200) {
        prefs.clear;
        setState(() {
          Fluttertoast.showToast(
              msg: 'Logout Sukses',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.greenAccent,
              textColor: Colors.white,
              fontSize: 16);
        });
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => LogIn()));
      } else {
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

  getDataUser() async {
    final SharedPreferences prefs = await _prefs;
    String emailUser = prefs.getString("emailKey").toString();
    String? tokenUser = prefs.getString("tokenKey").toString();
    String nameUser = prefs.getString("usernameKey").toString();
    print(emailUser);
    setState(() {
      userName = nameUser;
      emailName = emailUser;
    });

    var rspGetUser = await getUser(emailUser, tokenUser);
    print(rspGetUser);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataUser();
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
                              image: AssetImage("assets/images/sudin.png"))),
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
                          emailName,
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
              InkWell(
                onTap: () {
                  postLogout();
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
                                "Logout",
                                style: TextStyle(
                                    fontFamily: 'Rubik',
                                    color: Color(0xFFFF0000),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "Leave the app",
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
