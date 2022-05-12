// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:date_time_format/src/date_time_extension_methods.dart';
import 'package:e_cm/homepage/home/history/historydetailpage.dart';
import 'package:e_cm/homepage/home/history/model/historyall.dart';
import 'package:e_cm/homepage/home/history/model/historydailymodel.dart';
import 'package:e_cm/homepage/home/history/model/historymonthly.dart';
import 'package:e_cm/homepage/home/history/service/get_data_history_byname.dart';
import 'package:e_cm/homepage/home/history/service/get_history_all.dart';
import 'package:e_cm/homepage/home/history/service/get_history_daily.dart';
import 'package:e_cm/homepage/home/history/service/get_history_monthly.dart';
import 'package:e_cm/homepage/home/services/apigetapproved.dart';
import 'package:e_cm/homepage/notification/view/detailecm.dart';
import 'package:e_cm/util/shared_prefs_util.dart';
import 'package:e_cm/widget/network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  String bahasa = "Bahasa Indonesia";
  bool bahasaSelected = false;
  bool noDataLayout = false, dataSearch = false;
  bool conectionStatus = true;

  String history = '';
  String all = 'Semua';
  String today = 'Hari ini';
  String monthly = 'Bulanan';
  String? making;
  String a_hour = '';
  String one_week = '';
  String two_week = '';
  String one_month = '';
  String no_data = '';
  String no_riwayat = '';
  String show = 'Menampilkan riwayat';
  String his_empty = 'Riwayat ';
  String empty = ' kosong';
  String search_history = '';
  String connectionString = "";

  TextEditingController searchController = TextEditingController();

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
        show = dataLang['riwayat']['show'];
        his_empty = dataLang['riwayat']['his_empty'];
        empty = dataLang['riwayat']['empty'];
        search_history = dataLang['riwayat']['search_history'];
        connectionString = dataLang['riwayat']['connection_lost'];
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
        show = dataLang['riwayat']['show'];
        his_empty = dataLang['riwayat']['his_empty'];
        empty = dataLang['riwayat']['empty'];
        search_history = dataLang['riwayat']['search_history'];
        connectionString = dataLang['riwayat']['connection_lost'];
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
  List<HistoryMonthly> _listMontly = [];
  List<HistoryAll> _listSearch = [];
  DateTime _fromDate = DateTime.now();
  String dateSelected = '';
  String monthSelected = '';
  String yearSelected = '';
  String nowDateSelected = '';
  String nowMonthSelected = '';
  final dateFormat = new DateFormat('dd MMMM yyyy');
  String choseDate = '';
  final monthFormater = new DateFormat('MMMM');

  bool tabAll = true;
  bool tabDaily = false;
  bool tabMontly = false;

  int idMonth = 0;
  int idMonthPembanding = 0;

  String tokenKeyUser = '';
  String idUser = '';
  List bulan = [];

  //   Future<void> cariDokterUmum(String cariDokter) async {
  //   Map<String, dynamic> params = {
  //     "idservice": widget.idService,
  //     "idcategory": idCategory,
  //     "search": cariDokter
  //   };

  //   var result = await ApiServices.post("okechat/doktercaribycat", params);

  //   var user = await SharedPrefUtil.getUser();

  //   setState(() {
  //     if (result['response']['status'] == 200) {
  //       _listDokter = (result['data'] as List)
  //           .map((e) => DokterFavoritModel.fromJson(e))
  //           .toList();
  //     } else {
  //       _listDokter = [];
  //     }
  //   });
  // }

  Future<List> getMonth() async {
    var response = await rootBundle.loadString("assets/month/month.json");
    var dataLang = json.decode(response)['data'];
    bulan = dataLang;
    return dataLang;
  }

  Future<List<HistoryDaily>> getListDaily(String dateTarget) async {
    print("cek daily");
    final SharedPreferences prefs = await _prefs;
    String tokenUser = SharedPrefsUtil.getTokenUser();
    final String dateTime = _fromDate.format("Y-m-d");

    try {
      print("data showed by date " + dateTarget);
      var response = await getHistoryDaily(tokenUser, dateTarget, dateTarget);
      if (response['response']['status'] == 200) {
        setStateIfMounted(() {
          var data = response['data'] as List;
          _listDaily = data.map((e) => HistoryDaily.fromJson(e)).toList();
          print("===== list data daily =====");
          print(data.length);
          // print(response['data']);
          print("===== || =====");
        });
      } else {
        setState(() {
          Fluttertoast.showToast(
              msg: "Tidak ada data histori E-CM hari ini",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.orangeAccent,
              textColor: Colors.white,
              fontSize: 16);
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        conectionStatus = false;
        Fluttertoast.showToast(
            msg: connectionString,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.orangeAccent,
            textColor: Colors.white,
            fontSize: 16);
      });
    }
    return _listDaily;
  }

  Future<List<HistoryMonthly>> getListMonthly(
      String yearsTarget, String monthTarget) async {
    final SharedPreferences prefs = await _prefs;

    String tokenUser = SharedPrefsUtil.getTokenUser();
    try {
      print("data berdasarkan = th " + yearsTarget + " / bln " + monthTarget);
      var response =
          await getHistoryMonthly(tokenUser, yearsTarget, monthTarget);
      if (response['response']['status'] == 200) {
        setStateIfMounted(() {
          var data = response['data'] as List;
          _listMontly = data.map((e) => HistoryMonthly.fromJson(e)).toList();
          print("===== list data monthly =====");
          print(data.length);
          // print(response['data']);
          print("===== || =====");
        });
        setState(() {
          Fluttertoast.showToast(
              msg: show + monthSelected,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16);
        });
      } else {
        setState(() {
          Fluttertoast.showToast(
              msg: his_empty + " " + monthSelected,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.orangeAccent,
              textColor: Colors.white,
              fontSize: 16);
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        conectionStatus = false;
        Fluttertoast.showToast(
            msg: connectionString,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.orangeAccent,
            textColor: Colors.white,
            fontSize: 16);
      });
    }
    return _listMontly;
  }

  Future<List<HistoryAll>> getListAll() async {
    final SharedPreferences prefs = await _prefs;
    String tokenUser = SharedPrefsUtil.getTokenUser();
    try {
      var response = await getHistoryAll(tokenUser);
      if (response['response']['status'] == 200) {
        setStateIfMounted(() {
          var data = response['data'] as List;
          _listAll = data.map((e) => HistoryAll.fromJson(e)).toList();
          print("===== list data all =====");
          print(data.length);
          // print(response['data']);
          print("===== || =====");
        });
        setState(() {
          Fluttertoast.showToast(
              msg: 'Showing all of history E-CM Card',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16);
        });
        tabAll = true;
        tabDaily = false;
        tabMontly = false;
        noDataLayout = false;
      } else {
        setState(() {
          Fluttertoast.showToast(
              msg: 'E-CM Card history is empty',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.orangeAccent,
              textColor: Colors.white,
              fontSize: 16);
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        conectionStatus = false;
        Fluttertoast.showToast(
            msg: connectionString,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.orangeAccent,
            textColor: Colors.white,
            fontSize: 16);
      });
    }
    return _listAll;
  }

  Future<List<HistoryAll>> getListAllByName(String byName) async {
    // final SharedPreferences prefs = await _prefs;
    String tokenUser = SharedPrefsUtil.getTokenUser();
    try {
      var response = await getHistoryAllByName(tokenUser, byName);
      if (response['response']['status'] == 200) {
        setStateIfMounted(() {
          var data = response['data'] as List;
          _listSearch = data.map((e) => HistoryAll.fromJson(e)).toList();
          print("===== list data search =====");
          print(data);
          // print(response['data']);
          print("===== || =====");
          dataSearch = true;
          noDataLayout = false;
          tabAll = false;
          tabDaily = false;
          tabMontly = false;
        });
        // setState(() {
        //   Fluttertoast.showToast(
        //       msg: 'Showing all of history E-CM Card',
        //       toastLength: Toast.LENGTH_SHORT,
        //       gravity: ToastGravity.BOTTOM,
        //       timeInSecForIosWeb: 2,
        //       backgroundColor: Colors.green,
        //       textColor: Colors.white,
        //       fontSize: 16);
        // });
        // tabAll = true;
        // tabDaily = true;
        // tabMontly = true;

      } else {
        setState(() {
          tabAll = false;
          tabDaily = false;
          tabMontly = false;
          noDataLayout = true;
          dataSearch = false;
          print("===== data search not found =====");
          // Fluttertoast.showToast(
          //     msg: 'E-CM Card history not found',
          //     toastLength: Toast.LENGTH_SHORT,
          //     gravity: ToastGravity.BOTTOM,
          //     timeInSecForIosWeb: 2,
          //     backgroundColor: Colors.orangeAccent,
          //     textColor: Colors.white,
          //     fontSize: 16);
        });
      }
    } catch (e) {
      print(e);
    }
    return _listAll;
  }

  void getDateFromDialog() async {
    final prefs = await _prefs;
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2010),
            lastDate: DateTime(2030))
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
          dateSelected = dateFormat.format(DateTime.parse(date));
          monthSelected = month;
          choseDate = date;
          getListDaily(date);
        });
        print("tanggal yg dipilih = " + dateSelected);
      }
    });
  }

  void getMonthFromDialog() async {
    final prefs = await _prefs;
    showMonthPicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2010),
            lastDate: DateTime(2030))
        .then((value) {
      if (value != null) {
        DateTime _fromDate = DateTime.now();
        final monthFormat = new DateFormat('MMMM');
        final yearFormat = new DateFormat('yyyy');
        _fromDate = value;

        final String month = monthFormat.format(_fromDate);
        final String years = yearFormat.format(_fromDate);
        String chooseMonth = _fromDate.format("m");
        // String date = _fromDate.format("Y-m-d");
        setState(() {
          monthSelected = month;
          yearSelected = years;
          getListMonthly(yearSelected, chooseMonth);
        });
        print("bulan & thn yg dipilih = " + yearSelected + " / " + chooseMonth);
      }
    });
  }

  // void getDateNow() async {
  //   final prefs = await _prefs;
  //   showDatePicker(
  //           context: context,
  //           initialDate: DateTime.now(),
  //           firstDate: DateTime(1990),
  //           lastDate: DateTime(2022))
  //       .then((value) {
  //     if (value != null) {
  //       DateTime _fromDate = DateTime.now();
  //       final dateFormat = new DateFormat('dd MMMM yyyy');
  //       final monthFormat = new DateFormat('MMMM');
  //       _fromDate = value;
  //       String date = _fromDate.format("Y-m-d");

  //       final String month = monthFormat.format(_fromDate);

  //       // String date = _fromDate.format("Y-m-d");
  //       setState(() {
  //         dateSelected = date;
  //         monthSelected = month;
  //         choseDate = date;
  //       });
  //       // print("date selected = " + dateSelected);
  //       // print("date choosen = " + choseDate);
  //     }
  //   });
  // }

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setLang();
    final String dateTime = _fromDate.format("m Y");
    getListAll();
    DateTime _fromDateNow = DateTime.now();
    final dateFormatNow = new DateFormat('dd MMMM yyyy');
    final monthFormatNow = new DateFormat('MMMM yyyy');
    final yearFormatNow = new DateFormat('yyyy');
    final String dateNow = dateFormatNow.format(_fromDateNow);
    final String monthNow = monthFormatNow.format(_fromDateNow);
    final String yearNow = yearFormatNow.format(_fromDateNow);

    nowDateSelected = dateNow;
    nowMonthSelected = monthFormatNow.format(_fromDateNow);
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
                        getListAll();
                        tabAll = true;
                        tabDaily = false;
                        tabMontly = false;
                        noDataLayout = false;

                        searchController.clear();
                      });
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
                      setState(
                        () {
                          String dateNow = _fromDate.format("Y-m-d");
                          getListDaily(dateNow);
                          tabAll = false;
                          tabDaily = true;
                          tabMontly = false;
                          noDataLayout = false;

                          searchController.clear();
                        },
                      );
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
                        // getListMonthly();

                        String monthNow = _fromDate.format("m");
                        String yearsNow = _fromDate.format("Y");
                        getListMonthly(yearsNow, monthNow);
                        tabAll = false;
                        tabDaily = false;
                        tabMontly = true;
                        noDataLayout = false;

                        searchController.clear();
                      });
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
            Container(
              margin: EdgeInsets.only(top: 10, left: 15, right: 15),
              width: MediaQuery.of(context).size.width,
              height: 45,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 2,
                    )
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: TextFormField(
                controller: searchController,
                onFieldSubmitted: (value) {
                  if (value.isNotEmpty) {
                    getListAllByName(value);
                  } else {
                    getListAll();
                  }
                  // setState(() {
                  //   print(value);

                  // });
                },
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    prefixIcon: Icon(Icons.search_outlined),
                    hintText: search_history,
                    hintStyle: TextStyle(
                        color: Colors.black38,
                        fontFamily: 'Poppins',
                        fontSize: 14)),
              ),
            ),
            Visibility(
              visible: noDataLayout,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width,
                child: const Center(
                  child: Text("Data not found"),
                ),
              ),
            ),
            Visibility(
              visible: dataSearch,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SingleChildScrollView(
                    child: conectionStatus == true
                        ? Container(
                            // color: Colors.redAccent,
                            margin: EdgeInsets.symmetric(vertical: 8),
                            height: MediaQuery.of(context).size.height * 0.8,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(
                                vertical: 3, horizontal: 8),
                            child: _listSearch.isEmpty
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    // physics: NeverScrollableScrollPhysics(),
                                    itemCount: _listSearch.isEmpty
                                        ? 0
                                        : _listSearch.length,
                                    itemBuilder: (context, i) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HistoryDetailPage(
                                                        notifId: _listSearch[i]
                                                            .tEcmId
                                                            .toString(),
                                                        isShowButton: true,
                                                      )));
                                        },
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          elevation: 2,
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                          width: 48,
                                                          height: 48,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4),
                                                            child: NetworkImageWidget(
                                                                imageUri:
                                                                    _listSearch[
                                                                            i]
                                                                        .foto),
                                                          )),
                                                      const SizedBox(
                                                        width: 16,
                                                      ),
                                                      Container(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.6,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Container(
                                                                    child: Text(
                                                                        _listSearch[i]
                                                                            .nama
                                                                            .toString(),
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Color(0xFF00AEDB),
                                                                            fontWeight: FontWeight.w700)),
                                                                  ),
                                                                  const Text(
                                                                      'Making E-CM Card',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Color(0xFF6C7072))),
                                                                ],
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 8,
                                                            ),
                                                            Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.6,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Container(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.3,
                                                                    child: Text(
                                                                      _listSearch[
                                                                              i]
                                                                          .problem
                                                                          .toString(),
                                                                      style: const TextStyle(
                                                                          fontFamily:
                                                                              'Rubik',
                                                                          fontSize:
                                                                              10,
                                                                          color:
                                                                              Colors.black87),
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    _listSearch[
                                                                            i]
                                                                        .waktu
                                                                        .toString(),
                                                                    style: const TextStyle(
                                                                        fontFamily:
                                                                            'Rubik',
                                                                        fontSize:
                                                                            10,
                                                                        color: Color(
                                                                            0xFF979C9E)),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  child: Icon(
                                                    Icons
                                                        .arrow_forward_ios_rounded,
                                                    color: Colors.black54,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                          )
                        : Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: Center(
                              child: Text(connectionString,
                                  style: TextStyle(
                                      fontFamily: 'Rubik',
                                      fontSize: 12,
                                      color: Colors.black87)),
                            ),
                          ),
                  )
                ],
              ),
            ),
            Visibility(
                visible: tabAll,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SingleChildScrollView(
                      child: conectionStatus == true
                          ? Container(
                              // color: Colors.redAccent,
                              margin: EdgeInsets.symmetric(vertical: 8),
                              height: MediaQuery.of(context).size.height * 0.8,
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 8),
                              child: _listAll.isEmpty
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      // physics: NeverScrollableScrollPhysics(),
                                      itemCount: _listAll.isEmpty
                                          ? 0
                                          : _listAll.length,
                                      itemBuilder: (context, i) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        HistoryDetailPage(
                                                          notifId: _listAll[i]
                                                              .tEcmId
                                                              .toString(),
                                                          isShowButton: true,
                                                        )));
                                          },
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            elevation: 2,
                                            child: Container(
                                              padding: const EdgeInsets.all(8),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                            width: 48,
                                                            height: 48,
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4),
                                                              child: NetworkImageWidget(
                                                                  imageUri:
                                                                      _listAll[
                                                                              i]
                                                                          .foto),
                                                            )),
                                                        const SizedBox(
                                                          width: 16,
                                                        ),
                                                        Container(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.6,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Container(
                                                                      child: Text(
                                                                          _listAll[i]
                                                                              .nama
                                                                              .toString(),
                                                                          style: const TextStyle(
                                                                              color: Color(0xFF00AEDB),
                                                                              fontWeight: FontWeight.w700)),
                                                                    ),
                                                                    const Text(
                                                                        'Making E-CM Card',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Color(0xFF6C7072))),
                                                                  ],
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 8,
                                                              ),
                                                              Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.6,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.3,
                                                                      child:
                                                                          Text(
                                                                        _listAll[i]
                                                                            .problem
                                                                            .toString(),
                                                                        style: const TextStyle(
                                                                            fontFamily:
                                                                                'Rubik',
                                                                            fontSize:
                                                                                10,
                                                                            color:
                                                                                Colors.black87),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      _listAll[
                                                                              i]
                                                                          .waktu
                                                                          .toString(),
                                                                      style: const TextStyle(
                                                                          fontFamily:
                                                                              'Rubik',
                                                                          fontSize:
                                                                              10,
                                                                          color:
                                                                              Color(0xFF979C9E)),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Icon(
                                                      Icons
                                                          .arrow_forward_ios_rounded,
                                                      color: Colors.black54,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                            )
                          : Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: Center(
                                child: Text(connectionString,
                                    style: TextStyle(
                                        fontFamily: 'Rubik',
                                        fontSize: 12,
                                        color: Colors.black87)),
                              ),
                            ),
                    )
                  ],
                )),
            Visibility(
                visible: tabMontly,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SingleChildScrollView(
                      child: conectionStatus == true
                          ? Container(
                              // color: Colors.amberAccent,
                              margin: EdgeInsets.symmetric(vertical: 8),
                              height: MediaQuery.of(context).size.height * 0.7,
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 8),
                              child: _listMontly.isEmpty
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      // physics: NeverScrollableScrollPhysics(),
                                      itemCount: _listMontly.isEmpty
                                          ? 0
                                          : _listMontly.length,
                                      itemBuilder: (context, i) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        HistoryDetailPage(
                                                          notifId:
                                                              _listMontly[i]
                                                                  .tEcmId
                                                                  .toString(),
                                                          isShowButton: true,
                                                        )));
                                          },
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            elevation: 2,
                                            child: Container(
                                              padding: const EdgeInsets.all(8),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                            width: 48,
                                                            height: 48,
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4),
                                                              child: NetworkImageWidget(
                                                                  imageUri:
                                                                      _listMontly[
                                                                              i]
                                                                          .foto),
                                                            )),
                                                        const SizedBox(
                                                          width: 16,
                                                        ),
                                                        Container(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.6,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Container(
                                                                      child: Text(
                                                                          _listMontly[i]
                                                                              .nama
                                                                              .toString(),
                                                                          style: const TextStyle(
                                                                              color: Color(0xFF00AEDB),
                                                                              fontWeight: FontWeight.w700)),
                                                                    ),
                                                                    const Text(
                                                                        'Making E-CM Card',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Color(0xFF6C7072))),
                                                                  ],
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 8,
                                                              ),
                                                              Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.6,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.3,
                                                                      child:
                                                                          Text(
                                                                        _listMontly[i]
                                                                            .problem
                                                                            .toString(),
                                                                        style: const TextStyle(
                                                                            fontFamily:
                                                                                'Rubik',
                                                                            fontSize:
                                                                                10,
                                                                            color:
                                                                                Colors.black87),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      _listMontly[
                                                                              i]
                                                                          .waktu
                                                                          .toString(),
                                                                      style: const TextStyle(
                                                                          fontFamily:
                                                                              'Rubik',
                                                                          fontSize:
                                                                              10,
                                                                          color:
                                                                              Color(0xFF979C9E)),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Icon(
                                                      Icons
                                                          .arrow_forward_ios_rounded,
                                                      color: Colors.black54,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                            )
                          : Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: Center(
                                child: Text(connectionString,
                                    style: TextStyle(
                                        fontFamily: 'Rubik',
                                        fontSize: 12,
                                        color: Colors.black87)),
                              ),
                            ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      margin: EdgeInsets.only(right: 20, left: 20, bottom: 16),
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
                                getMonthFromDialog();
                              });
                            },
                            child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(left: 10),
                                width: MediaQuery.of(context).size.width * 0.65,
                                child: Text(
                                  monthSelected == ''
                                      ? nowMonthSelected
                                      : monthSelected + ' ' + yearSelected,
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
                )),
            Visibility(
              visible: tabDaily,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SingleChildScrollView(
                    child: conectionStatus == true
                        ? Container(
                            // color: Colors.amberAccent,
                            margin: EdgeInsets.symmetric(vertical: 8),
                            height: MediaQuery.of(context).size.height * 0.7,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(
                                vertical: 3, horizontal: 8),
                            child: _listDaily.isEmpty
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    // physics: NeverScrollableScrollPhysics(),
                                    itemCount: _listDaily.isEmpty
                                        ? 0
                                        : _listDaily.length,
                                    itemBuilder: (context, i) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HistoryDetailPage(
                                                        notifId: _listDaily[i]
                                                            .tEcmId
                                                            .toString(),
                                                        isShowButton: true,
                                                      )));
                                        },
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          elevation: 2,
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                          width: 48,
                                                          height: 48,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4),
                                                            child: NetworkImageWidget(
                                                                imageUri:
                                                                    _listDaily[
                                                                            i]
                                                                        .foto),
                                                          )),
                                                      const SizedBox(
                                                        width: 16,
                                                      ),
                                                      Container(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.6,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Container(
                                                                    child: Text(
                                                                        _listDaily[i]
                                                                            .nama
                                                                            .toString(),
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Color(0xFF00AEDB),
                                                                            fontWeight: FontWeight.w700)),
                                                                  ),
                                                                  const Text(
                                                                      'Making E-CM Card',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Color(0xFF6C7072))),
                                                                ],
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 8,
                                                            ),
                                                            Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.6,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Container(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.3,
                                                                    child: Text(
                                                                      _listDaily[
                                                                              i]
                                                                          .problem
                                                                          .toString(),
                                                                      style: const TextStyle(
                                                                          fontFamily:
                                                                              'Rubik',
                                                                          fontSize:
                                                                              10,
                                                                          color:
                                                                              Colors.black87),
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    _listDaily[
                                                                            i]
                                                                        .waktu
                                                                        .toString(),
                                                                    style: const TextStyle(
                                                                        fontFamily:
                                                                            'Rubik',
                                                                        fontSize:
                                                                            10,
                                                                        color: Color(
                                                                            0xFF979C9E)),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  child: Icon(
                                                    Icons
                                                        .arrow_forward_ios_rounded,
                                                    color: Colors.black54,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                          )
                        : Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: Center(
                              child: Text(connectionString,
                                  style: TextStyle(
                                      fontFamily: 'Rubik',
                                      fontSize: 12,
                                      color: Colors.black87)),
                            ),
                          ),
                  ),
                  InkWell(
                    onTap: () {
                      getMonthFromDialog();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      margin: EdgeInsets.only(right: 20, left: 20, bottom: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 2,
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
                                getDateFromDialog();
                              });
                            },
                            child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(left: 10),
                                width: MediaQuery.of(context).size.width * 0.65,
                                child: Text(
                                  dateSelected == ''
                                      ? nowDateSelected
                                      : dateSelected,
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

// Container _showCardMonth(BuildContext context) {
//   return Container(
//     height: 250,
//     width: 100,
//     padding: const EdgeInsets.all(8.0),
//     decoration: BoxDecoration(
//         borderRadius: BorderRadius.only(
//       topLeft: Radius.circular(10),
//       topRight: Radius.circular(10),
//     )),
//     child: FutureBuilder(
//       future: getMonth(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return ListView.builder(
//               itemCount: bulan.length,
//               itemBuilder: (context, i) {
//                 return InkWell(
//                     onTap: () async {
//                       setState(() {
//                         monthName = bulan[i]["name"];
//                         getHistoryMonthly(tokenKeyUser, year, bulan[i]["id"]);

//                         idMonth = bulan[i]["id"];
//                       });
//                       var result = await getHistoryMonthly(
//                           tokenKeyUser, year, bulan[i]["id"]);

//                       print("hasil monthly");
//                       print(result['response']['status']);

//                       if (result['response']['status'] == 201) {
//                         Fluttertoast.showToast(
//                             msg: 'Data tidak ada',
//                             toastLength: Toast.LENGTH_SHORT,
//                             gravity: ToastGravity.BOTTOM,
//                             timeInSecForIosWeb: 2,
//                             backgroundColor: Colors.greenAccent,
//                             textColor: Colors.white,
//                             fontSize: 16);
//                       }

//                       Navigator.of(context).pop();
//                       tabAll = false;
//                       tabDaily = false;
//                       tabMontly = true;
//                     },
//                     child: Container(
//                         margin: EdgeInsets.only(left: 20, right: 20),
//                         padding: EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                             border: Border(
//                                 bottom: BorderSide(
//                                     color: Colors.grey, width: 2))),
//                         child: Center(
//                           child: Text(
//                             bulan[i]["name"],
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 16,
//                             ),
//                           ),
//                         )));
//               });
//         }

//         return CircularProgressIndicator();
//       },
//     ),
//   );
// }
}
