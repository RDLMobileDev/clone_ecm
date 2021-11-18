// ignore_for_file: prefer_const_constructors

import 'package:e_cm/homepage/home/component/sliderhistory.dart';
import 'package:e_cm/homepage/home/fillnew/fillnew.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 16, top: 30, right: 16),
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/images/Dashboard.png"),
                fit: BoxFit.fill,
              )),
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const Text(
                              "Good Morning,",
                              style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                            const Text(
                              "Budi",
                              style: TextStyle(
                                  fontFamily: 'Rubik',
                                  color: Color(0xFF00AEDB),
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                        Container(
                          width: 80,
                          height: 40,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/Logo Sugity.png"))),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Welcome to PT. Sugity Creatives",
                      style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF404446)),
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              width: MediaQuery.of(context).size.width,
              child: Text(
                "History E-CM Card",
                style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF404446)),
              ),
            ),
            SizedBox(height: 16,),
            Container(
              padding: const EdgeInsets.only(left: 16, right: 16,),
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    SliderHistory(),
                    SliderHistory()
                  ],
                ),
              ),
            ),
            SizedBox(height: 25,),
            Container(
              padding: const EdgeInsets.only(left: 16, right: 16,),
              width: MediaQuery.of(context).size.width,
              child: Text("Activity", style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF404446)),),
            ),
            SizedBox(height: 16,),
            InkWell(
              onTap: (){
                Navigator.of(context).push(routeToFillNew());
              },
              child: Container(
                margin: const EdgeInsets.only(left: 16, right: 16,),
                padding: const EdgeInsets.only(left: 16, right: 16),
                width: MediaQuery.of(context).size.width,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(0xFF00AEDB),
                  borderRadius: BorderRadius.all(Radius.circular(5))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Fill New E-CM Card", style: TextStyle(fontFamily: 'Rubik', color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400 ), ),
                    Icon(Icons.arrow_forward_ios, size: 14, color: Colors.white,)
                  ],
                ),
              ),
            ),
            SizedBox(height: 16,),
            Container(
              margin: const EdgeInsets.only(left: 16, right: 16,),
              padding: const EdgeInsets.only(left: 16, right: 16),
              width: MediaQuery.of(context).size.width,
              height: 40,
              decoration: BoxDecoration(
                color: Color(0xFF00AEDB),
                borderRadius: BorderRadius.all(Radius.circular(5))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Approved E-Sign", style: TextStyle(fontFamily: 'Rubik', color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400 ), ),
                  Icon(Icons.arrow_forward_ios, size: 14, color: Colors.white,)
                ],
              ),
            ),
            SizedBox(height: 16,),
            Container(
              margin: const EdgeInsets.only(left: 16, right: 16,),
              padding: const EdgeInsets.only(left: 16, right: 16),
              width: MediaQuery.of(context).size.width,
              height: 40,
              decoration: BoxDecoration(
                color: Color(0xFF00AEDB),
                borderRadius: BorderRadius.all(Radius.circular(5))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("List TM Name", style: TextStyle(fontFamily: 'Rubik', color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400 ), ),
                  Icon(Icons.arrow_forward_ios, size: 14, color: Colors.white,)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Route routeToFillNew() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => FillNew(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
