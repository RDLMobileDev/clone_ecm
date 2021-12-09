// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:e_cm/homepage/home/approved/approved.dart';
import 'package:e_cm/homepage/home/component/sliderhistory.dart';
import 'package:e_cm/homepage/home/fillnew/fillnew.dart';
import 'package:e_cm/homepage/home/listname/listname.dart';
import 'package:e_cm/homepage/home/model/historyecmmodel.dart';
import 'package:e_cm/homepage/home/services/historyecmservice.dart';
import 'package:e_cm/language/model/lang_model.dart';
import 'package:e_cm/language/service/lang_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  StreamController historyStreamController = StreamController();
  String userName = "";
  bool isVisibility = true;

  late Timer _timer;

  List<HistoryEcmModel> _listHistoryEcmUser = [];

  Future<String> getNameUser() async {
    final SharedPreferences prefs = await _prefs;
    String nameUser = prefs.getString("usernameKey").toString();
    setState(() {
      userName = nameUser;
    });
    return nameUser;
  }

  getRoleUser() async {
    final SharedPreferences prefs = await _prefs;
    int jabatanUser = prefs.getInt("jabatanKey") ?? 0;

    setState(() {
      if (jabatanUser <= 5) {
        isVisibility = false;
      } else {
        isVisibility = true;
      }
    });
  }

  Future<List<HistoryEcmModel>> getHistoryEcmByUser() async {
    final SharedPreferences prefs = await _prefs;
    String idUser = prefs.getString("idKeyUser").toString();
    String tokenUser = prefs.getString("tokenKey").toString();

    try {
      _listHistoryEcmUser =
          await historyEcmService.getHistoryEcmModel(idUser, tokenUser);
      historyStreamController.add(_listHistoryEcmUser);
      print("data history:");
      print(_listHistoryEcmUser);
      return await historyEcmService.getHistoryEcmModel(idUser, tokenUser);
    } on SocketException catch (e) {
      print(e);
      return [];
    } on TimeoutException catch (e) {
      print(e);
      return [];
    } on Exception catch (e) {
      print(e);
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  @override
  void dispose() {
    if (_timer.isActive) _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHistoryEcmByUser();
    _timer =
        Timer.periodic(Duration(seconds: 10), (timer) => getHistoryEcmByUser());
    getNameUser();
    getRoleUser();
  }

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
                            Text(
                              "Good morning,",
                              style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              userName,
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
                                      "assets/images/logo_sugity.png"))),
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
            SizedBox(
              height: 16,
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
              ),
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder(
                stream: historyStreamController.stream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Center(
                            child: Text("Loading history E-CM Card...",
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  color: Color(0xFF00AEDB),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                )),
                          ),
                        ],
                      ),
                    );
                  }
                  return _listHistoryEcmUser.isEmpty
                      ? Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.all(16),
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(color: Color(0xFF00AEDB)),
                          ),
                          child: Center(
                              child: Text("No history here",
                                  style: TextStyle(
                                      fontFamily: 'Rubik',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF404446)))),
                        )
                      : Container(
                          height: 130,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: _listHistoryEcmUser.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, i) {
                              return SliderHistory(
                                classificationName:
                                    _listHistoryEcmUser[i].classification,
                                costRp: _listHistoryEcmUser[i].totalHarga,
                                factoryPlace: _listHistoryEcmUser[i].lokasi,
                                tanggal: _listHistoryEcmUser[i].date,
                                itemsRepair:
                                    _listHistoryEcmUser[i].arrayitemrepair,
                              );
                            },
                          ),
                        );
                },
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
              ),
              width: MediaQuery.of(context).size.width,
              child: Text(
                "Activity",
                style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF404446)),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Visibility(
              visible: isVisibility,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(routeToFillNew());
                },
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                  ),
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Color(0xFF00AEDB),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Fill New E-CM Card",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 14,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            InkWell(
              onTap: () {
                // Navigator.of(context).push(
                //     MaterialPageRoute(builder: (context) => ApprovedEcm()));
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ApprovedEcm()));
              },
              child: Container(
                margin: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
                padding: const EdgeInsets.only(left: 16, right: 16),
                width: MediaQuery.of(context).size.width,
                height: 40,
                decoration: BoxDecoration(
                    color: Color(0xFF00AEDB),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Approved E-Sign",
                      style: TextStyle(
                          fontFamily: 'Rubik',
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ListTmName()));
              },
              child: Container(
                margin: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
                padding: const EdgeInsets.only(left: 16, right: 16),
                width: MediaQuery.of(context).size.width,
                height: 40,
                decoration: BoxDecoration(
                    color: Color(0xFF00AEDB),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "List TM Name",
                      style: TextStyle(
                          fontFamily: 'Rubik',
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: Colors.white,
                    )
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
