// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:e_cm/homepage/home/services/api_remove_cache.dart';
import 'package:e_cm/homepage/home/services/remove_ecm_cancel_service.dart';
import 'package:http/http.dart' as http;
import 'package:e_cm/homepage/home/approved/approved.dart';
import 'package:e_cm/homepage/home/component/sliderhistory.dart';
import 'package:e_cm/homepage/home/fillnew/fillnew.dart';
import 'package:e_cm/homepage/home/history/historydetailpage.dart';
import 'package:e_cm/homepage/home/history/historypage.dart';
import 'package:e_cm/homepage/home/history/historyreview.dart';
import 'package:e_cm/homepage/home/listname/listname.dart';
import 'package:e_cm/homepage/home/model/historyecmmodel.dart';
import 'package:e_cm/homepage/home/services/historyecmservice.dart';
import 'package:e_cm/language/model/lang_model.dart';
import 'package:e_cm/language/service/lang_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
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
  bool isVisibility = true, activitySectionJabatan = false, addcard = true;

  // late Timer _timer;

  List<HistoryEcmModel> _listHistoryEcmUser = [];

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  late Timer _timer;

  String bahasa = "Bahasa Indonesia";
  bool bahasaSelected = false;

  String halo = '';
  String welcometo = '';
  String recent_ecm = '';
  String activity = '';
  String add_ecm = '';
  String sign_ecm = '';
  String listname = '';
  String history_ecm = '';
  String properti_ecm = '';
  String home = '';
  String notification = '';
  String account = '';
  String loading = '';
  String no_data = '';
  String ecm_approved = '';
  String ecm_declined = '';
  String ecm_pending = '';
  var cardStatus;

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // items.add((items.length+1).toString());
    await getHistoryEcmByUser();
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

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
        halo = dataLang['beranda']['hello'];
        welcometo = dataLang['beranda']['welcome_to'];
        recent_ecm = dataLang['beranda']['ecm_card_recent'];
        activity = dataLang['beranda']['activity'];
        add_ecm = dataLang['beranda']['fill_ecm'];
        sign_ecm = dataLang['beranda']['approved_sign'];
        listname = dataLang['beranda']['list_tm'];
        history_ecm = dataLang['beranda']['history_ecm'];
        properti_ecm = dataLang['beranda']['property_of'];
        home = dataLang['beranda']['home'];
        notification = dataLang['beranda']['notif'];
        account = dataLang['beranda']['account'];
        loading = dataLang['beranda']['loading'];
        no_data = dataLang['beranda']['no_data'];
        ecm_approved = dataLang['beranda']['approved'];
        ecm_declined = dataLang['beranda']['declined'];
        ecm_pending = dataLang['beranda']['pending'];
      });
    }
  }

  void getLanguageId() async {
    var response = await rootBundle.loadString("assets/lang/lang-id.json");
    var dataLang = json.decode(response)['data'];

    if (mounted) {
      setState(() {
        halo = dataLang['beranda']['hello'];
        welcometo = dataLang['beranda']['welcome_to'];
        recent_ecm = dataLang['beranda']['ecm_card_recent'];
        activity = dataLang['beranda']['activity'];
        add_ecm = dataLang['beranda']['fill_ecm'];
        sign_ecm = dataLang['beranda']['approved_sign'];
        listname = dataLang['beranda']['list_tm'];
        history_ecm = dataLang['beranda']['history_ecm'];
        properti_ecm = dataLang['beranda']['property_of'];
        home = dataLang['beranda']['home'];
        notification = dataLang['beranda']['notif'];
        account = dataLang['beranda']['account'];
        loading = dataLang['beranda']['loading'];
        no_data = dataLang['beranda']['no_data'];
        ecm_approved = dataLang['beranda']['approved'];
        ecm_declined = dataLang['beranda']['declined'];
        ecm_pending = dataLang['beranda']['pending'];
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
    int? jabatanUser = prefs.getInt("jabatanKey");

    if (jabatanUser != null) {
      setState(() {
        if (jabatanUser != 8) {
          isVisibility = false;
          addcard = true;
          activitySectionJabatan = false;
        } else {
          isVisibility = false;
          addcard = true;
          activitySectionJabatan = true;
        }
      });
    }
  }

  Future<List<HistoryEcmModel>> getHistoryEcmByUser() async {
    final SharedPreferences prefs = await _prefs;
    String idUser = prefs.getString("idKeyUser").toString();
    String tokenUser = prefs.getString("tokenKey").toString();

    try {
      _listHistoryEcmUser =
          await historyEcmService.getHistoryEcmModel(idUser, tokenUser);
      historyStreamController.add(_listHistoryEcmUser);
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

  getCardStatus() async {
    final SharedPreferences prefs = await _prefs;
    String idUser = prefs.getString("idKeyUser").toString();
    String tokenUser = prefs.getString("tokenKey").toString();
    var url =
        "http://app.ragdalion.com/ecm/public/api/home_cekecm?id_user=$idUser";
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $tokenUser'
      });
      setState(() {
        cardStatus = json.decode(response.body)['data'];
      });
      return cardStatus;
    } catch (err) {
      print(err);
      return null;
    }
  }

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  void removeCacheEcmFromDb() async {
    final prefs = await _prefs;
    String tokenUser = prefs.getString("tokenKey") ?? "";
    String idEcm = prefs.getString("idEcm") ?? "";

    if ((tokenUser.isNotEmpty || tokenUser != "") &&
        (idEcm.isNotEmpty || idEcm != "")) {
      var response = await removeEcmCancelUser.removeEcmLast(tokenUser, idEcm);

      removeStepCacheFillEcm();
      removeCacheFillEcm();
    }
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

    _timer = Timer.periodic(Duration(seconds: 30), (e) {
      getHistoryEcmByUser();
      if (e.tick == 10) {
        _timer.cancel();
      }
    });

    getNameUser();
    getRoleUser();
    setBahasa();
    setLang();
    getCardStatus();
    removeCacheEcmFromDb();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(),
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: Container(
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
                  image: AssetImage("assets/images/Header-Homepage-V3.png"),
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
                                halo,
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
                                    fontSize: 25,
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
                        welcometo,
                        style: TextStyle(
                            height: 1.5,
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
                  recent_ecm,
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
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return _listHistoryEcmUser.isEmpty
                        ? Container(
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.all(16),
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: 130,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              border: Border.all(color: Color(0xFF00AEDB)),
                            ),
                            child: Center(
                                child: Text(no_data,
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
                                return InkWell(
                                  onTap: () {
                                    // print(
                                    //     _listHistoryEcmUser[i].ecmId.toString());
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HistoryDetailPage(
                                                  notifId:
                                                      _listHistoryEcmUser[i]
                                                          .ecmId
                                                          .toString(),
                                                  isShowButton: false,
                                                )));
                                  },
                                  child: SliderHistory(
                                    classificationName:
                                        _listHistoryEcmUser[i].classification,
                                    costRp: _listHistoryEcmUser[i].totalHarga,
                                    factoryPlace: _listHistoryEcmUser[i].lokasi,
                                    tanggal: _listHistoryEcmUser[i].date,
                                    itemsRepair:
                                        _listHistoryEcmUser[i].arrayitemrepair,
                                  ),
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
                height: 310,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        activity,
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF404446)),
                      ),
                    ),
                    Visibility(
                      visible: addcard,
                      //add ecm
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(routeToFillNew());
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                            top: 16,
                            left: 16,
                            right: 16,
                          ),
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Color(0xFF00AEDB),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                add_ecm,
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
                    Visibility(
                        visible: addcard,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(top: 8, right: 16, left: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  padding: EdgeInsets.only(top: 8, bottom: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(ecm_approved,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Rubik',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400)),
                                      Text(
                                        cardStatus == null
                                            ? "0"
                                            : cardStatus['ecm_approved']
                                                .toString(),
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontFamily: 'Rubik',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  )),
                              Divider(
                                height: 3,
                                color: Color(0xffE3E5E5),
                              ),
                              Container(
                                  padding: EdgeInsets.only(top: 8, bottom: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        ecm_declined,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Rubik',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        cardStatus == null
                                            ? "0"
                                            : cardStatus['ecm_reject']
                                                .toString(),
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontFamily: 'Rubik',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  )),
                              Divider(
                                height: 3,
                                color: Color(0xffE3E5E5),
                              ),
                              Container(
                                  padding: EdgeInsets.only(top: 8, bottom: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        ecm_pending,
                                        style: TextStyle(
                                            color: Color(0xff979C9E),
                                            fontFamily: 'Rubik',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        cardStatus == null
                                            ? "0"
                                            : cardStatus['ecm_masuk']
                                                .toString(),
                                        style: TextStyle(
                                            color: Color(0xff979C9E),
                                            fontFamily: 'Rubik',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  )),
                              Divider(
                                height: 3,
                                color: Color(0xffE3E5E5),
                              ),
                            ],
                          ),
                        )),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          //sign ecm
                          Visibility(
                            visible: isVisibility,
                            child: InkWell(
                              onTap: () {
                                // Navigator.of(context).push(
                                //     MaterialPageRoute(builder: (context) => ApprovedEcm()));
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ApprovedEcm()));
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                  left: 16,
                                  right: 16,
                                ),
                                padding:
                                    const EdgeInsets.only(left: 16, right: 16),
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Color(0xFF00AEDB),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      sign_ecm,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Rubik',
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
                          Visibility(
                            visible: isVisibility,
                            child: SizedBox(
                              height: 16,
                            ),
                          ),
                          //listname

                          Visibility(
                            visible: activitySectionJabatan,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ListTmName()));
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                  left: 16,
                                  right: 16,
                                ),
                                padding:
                                    const EdgeInsets.only(left: 16, right: 16),
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Color(0xFF00AEDB),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      listname,
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
                          //history ecm
                          Visibility(
                            visible: activitySectionJabatan,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => HistoryPage()));
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                  left: 16,
                                  right: 16,
                                ),
                                padding:
                                    const EdgeInsets.only(left: 16, right: 16),
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Color(0xFF00AEDB),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      history_ecm,
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
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          properti_ecm,
                          style: TextStyle(
                              color: Colors.black87,
                              fontFamily: 'Rubik',
                              fontSize: 12),
                        ),
                      ),
                    ),
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
