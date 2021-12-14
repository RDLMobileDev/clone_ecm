import 'dart:convert';
import 'package:date_time_format/src/date_time_extension_methods.dart';
import 'package:e_cm/homepage/home/history/model/historyall.dart';
import 'package:e_cm/homepage/home/history/model/historydailymodel.dart';
import 'package:e_cm/homepage/home/history/model/historymonthly.dart';
import 'package:e_cm/homepage/home/history/service/get_history_all.dart';
import 'package:e_cm/homepage/home/history/service/get_history_daily.dart';
import 'package:e_cm/homepage/home/history/service/get_history_monthly.dart';
import 'package:e_cm/homepage/home/services/apigetapproved.dart';
import 'package:e_cm/homepage/notification/view/detailecm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  String bahasa = "Bahasa Indonesia";
  bool bahasaSelected = false;

  String history = '';
  String all = '';
  String today = '';
  String monthly = '';
  String? making;
  String a_hour = '';
  String one_week = '';
  String two_week = '';
  String one_month = '';
  String no_data = '';
  String no_riwayat = '';

 void setBahasa() async {
    final prefs = await _prefs;
    String bahasaBool = prefs.getString("bahasa") ?? "";

    if (bahasaBool.isNotEmpty && bahasaBool == "Bahasa Indonesia") {
      setState(() {
        bahasaSelected = false;
        bahasa = bahasaBool;
      });
    } else if (bahasaBool.isNotEmpty && bahasaBool == "English") {
      setState(() {
        bahasaSelected = true;
        bahasa = bahasaBool;
      });
    } else {
      setState(() {
        bahasaSelected = false;
        bahasa = "Bahasa Indonesia";
      });
    }
  }

  void getLanguageEn() async {
    var response = await rootBundle.loadString("assets/lang/lang-en.json");
    var dataLang = json.decode(response)['data'];
    if (mounted) {
      setState(() {
        history = dataLang['riwayat']['history'];
        all = dataLang['riwayat']['all'];
        today = dataLang['riwayat']['today'];
        monthly = dataLang['riwayat']['monthly'];
        making = dataLang['riwayat']['making_ecm'];
        a_hour = dataLang['riwayat']['a_hour_ago'];
        one_week = dataLang['riwayat']['one_week'];
        two_week = dataLang['riwayat']['two_week'];
        one_month = dataLang['riwayat']['one_month'];
        no_data = dataLang['riwayat']['no_data'];
        no_riwayat = dataLang['riwayat']['no_riwayat'];
      });
    }
  }

  void getLanguageId() async {
    var response = await rootBundle.loadString("assets/lang/lang-id.json");
    var dataLang = json.decode(response)['data'];
  
    if (mounted) {
      setState(() {
        history = dataLang['riwayat']['history'];
        all = dataLang['riwayat']['all'];
        today = dataLang['riwayat']['today'];
        monthly = dataLang['riwayat']['monthly'];
        making = dataLang['riwayat']['making_ecm'];
        a_hour = dataLang['riwayat']['a_hour_ago'];
        one_week = dataLang['riwayat']['one_week'];
        two_week = dataLang['riwayat']['two_week'];
        one_month = dataLang['riwayat']['one_month'];
        no_data = dataLang['riwayat']['no_data'];
        no_riwayat = dataLang['riwayat']['no_riwayat'];
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




  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  List<HistoryDaily> _listDaily = [];
  List<HistoryAll> _listAll = [];
  List<HistoryMonthly> _listMonthly = [];
  DateTime _fromDate = DateTime.now();
  String dateSelected = 'DD/MM/YYYY';
  String monthSelected = '';
  String nowDateSelected = '';
  String month = '';
  String year = '';
  String monthName = '';

  bool tabAll = false;
  bool tabDaily = true;
  bool tabMontly = false;

  int idMonth = 0;
  int idMonthPembanding = 0;

  String tokenKeyUser = '';
  String idUser = '';
  List bulan = [];

  Future<List> getMonth() async {
    var response = await rootBundle.loadString("assets/month/month.json");
    var dataLang = json.decode(response)['data'];
    bulan = dataLang;
    return dataLang;
  }

  Future<List<HistoryDaily>> getListDaily() async {
    final SharedPreferences prefs = await _prefs;

    tokenKeyUser = prefs.getString("tokenKey").toString();
    String? tokenUser = prefs.getString("tokenKey").toString();
    final String date = _fromDate.format("Y-m-d");
    try {
      var response = await getHistoryDaily(tokenUser, date, date);
      if (response['response']['status'] == 200) {
        setStateIfMounted(() {
          var data = response['data'] as List;
          _listDaily = data.map((e) => HistoryDaily.fromJson(e)).toList();
          print("===== list approved =====");
          print(data.length);
          // print(response['data']);
          print("===== || =====");
        });
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
      print(e);
    }
    return _listDaily;
  }

  Future<List<HistoryMonthly>> getListMonthly() async {
    final SharedPreferences prefs = await _prefs;

    tokenKeyUser = prefs.getString("tokenKey").toString();
    String? tokenUser = prefs.getString("tokenKey").toString();
    try {
      var response = await getHistoryDaily(tokenUser, year, month);
      if (response['response']['status'] == 200) {
        setStateIfMounted(() {
          var data = response['data'] as List;
          _listMonthly = data.map((e) => HistoryMonthly.fromJson(e)).toList();
          print("===== list approved =====");
          print(data.length);
          // print(response['data']);
          print("===== || =====");
        });
      } else if (response['response']['status'] == 201) {
        setState(() {
          Fluttertoast.showToast(
              msg: no_data,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.greenAccent,
              textColor: Colors.white,
              fontSize: 16);
        });
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
      print(e);
    }
    return _listMonthly;
  }

  Future<List<HistoryAll>> getListAll() async {
    final SharedPreferences prefs = await _prefs;
    tokenKeyUser = prefs.getString("tokenKey").toString();
    idUser = prefs.getString("idKeyUser").toString();
    try {
      var response = await getHistoryAll(tokenKeyUser, idUser);
      if (response['response']['status'] == 200) {
        setStateIfMounted(() {
          var data = response['data'] as List;
          _listAll = data.map((e) => HistoryAll.fromJson(e)).toList();
          print("===== list approved =====");
          print(data.length);
          // print(response['data']);
          print("===== || =====");
        });
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
      print(e);
    }
    return _listAll;
  }

  void getDateFromDialog(BuildContext context) async {
    final prefs = await _prefs;
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1990),
            lastDate: DateTime(2022))
        .then((value) {
      if (value != null) {
        DateTime _fromDate = DateTime.now();
        final dateFormat = new DateFormat('dd MMMM yyyy');
        final monthFormat = new DateFormat('MMMM yyyy');
        _fromDate = value;
        final String date = _fromDate.format("Y-m-d");

        final String month = monthFormat.format(_fromDate);

        // String date = _fromDate.format("Y-m-d");
        setState(() {
          dateSelected = date;
          monthSelected = month;
        });
        print(dateSelected);
      }
    });
  }

  void getDateNow(BuildContext context) async {
    final prefs = await _prefs;
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1990),
            lastDate: DateTime(2022))
        .then((value) {
      if (value != null) {
        DateTime _fromDate = DateTime.now();
        final dateFormat = new DateFormat('dd MMMM yyyy');
        final monthFormat = new DateFormat('MMMM');
        _fromDate = value;
        final String date = _fromDate.format("Y-m-d");

        final String month = monthFormat.format(_fromDate);

        // String date = _fromDate.format("Y-m-d");
        setState(() {
          dateSelected = date;
          monthSelected = month;
        });
        print(dateSelected);
      }
    });
  }

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListDaily();
    getListAll();
    getListMonthly();
    setBahasa();
    setLang();
    DateTime _fromDateNow = DateTime.now();
    final dateFormatNow = new DateFormat('dd MMMM yyyy');
    final monthFormatNow = new DateFormat('M');
    final yearFormatNow = new DateFormat('yyyy');

    final String dateNow = dateFormatNow.format(_fromDateNow);
    final String monthNow = monthFormatNow.format(_fromDateNow);
    final String yearNow = yearFormatNow.format(_fromDateNow);

    nowDateSelected = dateNow;
    month = monthNow;
    year = yearNow;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF00AEDB),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          history,
          style: TextStyle(
              fontFamily: 'Rubik', fontSize: 16, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              alignment: Alignment.center,
              height: 40,
              // color: Colors.redAccent,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      setState(() {
                        getHistoryAll(tokenKeyUser, idUser);
                      });
                      tabAll = true;
                      tabDaily = false;
                      tabMontly = false;
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 8, right: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        border: Border.all(
                          width: 1,
                          color: Color(0xFF00AEDB),
                        ),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            color: tabAll == true
                                ? Color(0xFF00AEDB)
                                : Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                        // height: 20,
                        child: Text(
                          all,
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 12,
                            color: tabAll == true
                                ? Colors.white
                                : Color(0xFF00AEDB),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        getHistoryDaily(
                            tokenKeyUser, dateSelected, dateSelected);
                      });
                      tabAll = false;
                      tabDaily = true;
                      tabMontly = false;
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 8, right: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        border: Border.all(
                          width: 1,
                          color: Color(0xFF00AEDB),
                        ),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            color: tabDaily == true
                                ? Color(0xFF00AEDB)
                                : Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                        // height: 20,
                        child: Text(
                          today,
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 12,
                            color: tabDaily == true
                                ? Colors.white
                                : Color(0xFF00AEDB),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        // addMasjid();
                      });
                      tabAll = false;
                      tabDaily = false;
                      tabMontly = true;
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 8, right: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        border: Border.all(
                          width: 1,
                          color: Color(0xFF00AEDB),
                        ),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            color: tabMontly == true
                                ? Color(0xFF00AEDB)
                                : Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                        // height: 20,
                        child: Text(
                          monthly,
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 12,
                            color: tabMontly == true
                                ? Colors.white
                                : Color(0xFF00AEDB),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
                visible: tabAll,
                child: Center(
                    child: Container(
                        margin: EdgeInsets.only(top: 40),
                        child: Text(no_riwayat)))),
            Visibility(
                visible: tabMontly,
                child: Center(
                    child: Container(
                        margin: EdgeInsets.only(top: 40),
                        child: Text(no_riwayat)))),
            Visibility(
              visible: tabDaily,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SingleChildScrollView(
                    child: Container(
                      // color: Colors.amberAccent,
                      margin: EdgeInsets.symmetric(vertical: 8),
                      height: MediaQuery.of(context).size.height * 0.7,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _listDaily.isEmpty ? 0 : _listDaily.length,
                        itemBuilder: (context, i) {
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 2,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 48,
                                          height: 48,
                                          decoration: const BoxDecoration(
                                              color: Color(0xFF00AEDB),
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/images/ario.png"))),
                                        ),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  style: const TextStyle(
                                                    fontFamily: 'Rubik',
                                                    fontSize: 16,
                                                  ),
                                                  // ignore: prefer_const_literals_to_create_immutables
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                        text: _listDaily[i]
                                                            .nama
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color: Color(
                                                                0xFF00AEDB),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700)),
                                                    TextSpan(
                                                        text: making,
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF6C7072))),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                _listDaily[i].waktu.toString(),
                                                style: const TextStyle(
                                                    fontFamily: 'Rubik',
                                                    fontSize: 10,
                                                    color: Color(0xFF979C9E)),
                                              ),
                                              // Container(
                                              //   margin: const EdgeInsets.only(top: 22),
                                              //   child: Row(
                                              //     children: [
                                              //       InkWell(
                                              //         onTap: () {
                                              //           // Navigator.of(context).push(MaterialPageRoute(
                                              //           //     builder: (context) => DetailEcm(
                                              //           //           notifId: _listDaily[i]
                                              //           //               .notifEcmId
                                              //           //               .toString(),
                                              //           //         )));
                                              //           // print("ok");
                                              //         },
                                              //         child: Container(
                                              //           width: 63,
                                              //           height: 24,
                                              //           decoration: BoxDecoration(
                                              //               border: Border.all(
                                              //                   color: const Color(0xFF00AEDB)),
                                              //               borderRadius: const BorderRadius.all(
                                              //                   Radius.circular(5))),
                                              //           child: const Center(
                                              //             child: Text(
                                              //               "Review",
                                              //               style: TextStyle(
                                              //                   fontFamily: 'Rubik',
                                              //                   fontSize: 12,
                                              //                   fontWeight: FontWeight.w400),
                                              //             ),
                                              //           ),
                                              //         ),
                                              //       ),
                                              //       SizedBox(
                                              //         width: 8,
                                              //       ),
                                              //       Container(
                                              //         width: 63,
                                              //         height: 24,
                                              //         decoration: BoxDecoration(
                                              //             color: Color(0xFF00AEDB),
                                              //             borderRadius:
                                              //                 BorderRadius.all(Radius.circular(5))),
                                              //         child: Center(
                                              //           child: Text(
                                              //             "Approve",
                                              //             style: TextStyle(
                                              //                 fontFamily: 'Rubik',
                                              //                 color: Colors.white,
                                              //                 fontSize: 12,
                                              //                 fontWeight: FontWeight.w400),
                                              //           ),
                                              //         ),
                                              //       ),
                                              //       SizedBox(
                                              //         width: 8,
                                              //       ),
                                              //       Container(
                                              //         width: 63,
                                              //         height: 24,
                                              //         decoration: BoxDecoration(
                                              //             color: Color(0xFFFF0000),
                                              //             borderRadius:
                                              //                 BorderRadius.all(Radius.circular(5))),
                                              //         child: Center(
                                              //           child: Text(
                                              //             "Decline",
                                              //             style: TextStyle(
                                              //                 fontFamily: 'Rubik',
                                              //                 color: Colors.white,
                                              //                 fontSize: 12,
                                              //                 fontWeight: FontWeight.w400),
                                              //           ),
                                              //         ),
                                              //       ),
                                              //     ],
                                              //   ),
                                              // )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: Colors.black54,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    margin: EdgeInsets.only(right: 20, left: 20, bottom: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        )
                      ],
                      color: Colors.white,
                    ),
                    child: Row(
                      children: <Widget>[
                        InkWell(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            width: 30,
                            height: 30,
                            child: Icon(
                              Icons.keyboard_arrow_left,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              // getDateFromDialog();
                            });
                          },
                          child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(left: 10),
                              width: MediaQuery.of(context).size.width * 0.65,
                              child: Text(
                                monthSelected == ''
                                    ? nowDateSelected
                                    : monthSelected,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Rubik',
                                    fontSize: 16,
                                    color: Colors.black),
                              )),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.only(right: 10),
                            width: 30,
                            height: 30,
                            child: Icon(
                              Icons.keyboard_arrow_right,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _showCardMonth(BuildContext context) {
    return Container(
      height: 250,
      width: 100,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      )),
      child: FutureBuilder(
        future: getMonth(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: bulan.length,
                itemBuilder: (context, i) {
                  return InkWell(
                      onTap: () async {
                        setState(() {
                          monthName = bulan[i]["name"];
                          getHistoryMonthly(tokenKeyUser, year, bulan[i]["id"]);

                          idMonth = bulan[i]["id"];
                        });
                        var result = await getHistoryMonthly(
                            tokenKeyUser, year, bulan[i]["id"]);

                        print("hasil monthly");
                        print(result['response']['status']);

                        if (result['response']['status'] == 201) {
                          Fluttertoast.showToast(
                              msg: 'Data tidak ada',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 2,
                              backgroundColor: Colors.greenAccent,
                              textColor: Colors.white,
                              fontSize: 16);
                        }

                        Navigator.of(context).pop();
                        tabAll = false;
                        tabDaily = false;
                        tabMontly = true;
                      },
                      child: Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.grey, width: 2))),
                          child: Center(
                            child: Text(
                              bulan[i]["name"],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          )));
                });
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }
}
