// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:flutter/material.dart';

class AccountMember extends StatefulWidget {
  const AccountMember({Key? key}) : super(key: key);

  @override
  _AccountMemberState createState() => _AccountMemberState();
}

class _AccountMemberState extends State<AccountMember> {
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
                          "Budi",
                          style: TextStyle(
                              fontFamily: 'Rubik',
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF404446)),
                        ),
                        Text(
                          "budi@sugity.com - (member)",
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
              Container(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
