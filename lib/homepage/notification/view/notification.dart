// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class NotificationMember extends StatefulWidget {
  const NotificationMember({Key? key}) : super(key: key);

  @override
  _NotificationMemberState createState() => _NotificationMemberState();
}

class _NotificationMemberState extends State<NotificationMember> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(16, 28, 24, 16),
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
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage("assets/images/sudin.png"),
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
                                  text: "Sudin",
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
                            "1 hour ago",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage("assets/images/ario.png"),
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
                                  text: "Ario",
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
                            "2 hour ago",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage("assets/images/sudin.png"),
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
                                  text: "Sudin",
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
                            "1 hour ago",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage("assets/images/sudin.png"),
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
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                TextSpan(
                                  text: "Sudin",
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
                            "21/10/2021",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
