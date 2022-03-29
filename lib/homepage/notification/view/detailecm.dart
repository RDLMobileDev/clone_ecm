// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:e_cm/baseurl/baseurl.dart';
import 'package:e_cm/homepage/dashboard.dart';
import 'package:e_cm/homepage/home/approved/approved.dart';
import 'package:e_cm/homepage/home/model/detailecmmodel.dart';
import 'package:e_cm/homepage/home/model/detailesignmodel.dart';
import 'package:e_cm/homepage/home/model/detailitemcheckmodel.dart';
import 'package:e_cm/homepage/home/model/detailitemrepairmodel.dart';
import 'package:e_cm/homepage/home/model/detailsparepartmodel.dart';
import 'package:e_cm/homepage/home/model/incident_effect.dart';
import 'package:e_cm/homepage/home/model/incident_mistake.dart';
import 'package:e_cm/homepage/home/services/api_reject_ecm_service.dart';
import 'package:e_cm/homepage/home/services/apidetailecm.dart';
import 'package:e_cm/homepage/home/services/apigetapproved.dart';
import 'package:e_cm/homepage/home/services/apiupdatestatusecm.dart';
import 'package:e_cm/util/shared_prefs_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailEcm extends StatefulWidget {
  final String notifId;
  final bool isShowButton;

  const DetailEcm({required this.notifId, required this.isShowButton});

  @override
  _DetailEcmState createState() => _DetailEcmState();
}

class _DetailEcmState extends State<DetailEcm> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  TextEditingController alasanTolak = TextEditingController();

  String bahasa = "Bahasa Indonesia";
  bool bahasaSelected = false;
  bool isDeclined = false;

  String preventive_maintenance = '';
  String tim_member = '';
  String kejadian = '';
  String why_analysis = '';
  String why_1 = '';

  String pengecekan_item = '';
  String standard = '';
  String aktual = '';
  String jam = '';
  String note = '';
  String perbaikan_item = '';
  String perbaikan = '';

  String improvement = '';
  String ide = '';
  String waktu_kerja = '';
  String cek_perbaikan = '';
  String istirahat = '';
  String bm = '';

  String cost = '';
  String in_house = '';
  String out_house = '';
  String sparepart = '';
  String e_sign = '';
  String total_cost = '';
  String tanda_tangan = '';

  String tolak = '';
  String validasi_tanda_tangan = '';
  String selesai = '';
  String unduh_laporan = '';
  String konfirmasi = '';
  String validasi_unduh = '';
  String batal = '';
  String unduh = '';
  String approvedSign = '';
  String declinedSign = '';

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
        preventive_maintenance = dataLang['detail']['preventive'];

        tim_member = dataLang['detail']['tim_member'];
        kejadian = dataLang['detail']['incident'];
        why_analysis = dataLang['detail']['why_analys'];
        why_1 = dataLang['detail']['why_one'];
        pengecekan_item = dataLang['detail']['item_checking'];
        standard = dataLang['detail']['standard'];
        aktual = dataLang['detail']['actual'];
        jam = dataLang['detail']['time'];

        note = dataLang['detail']['note'];
        perbaikan = dataLang['detail']['repairing'];
        perbaikan_item = dataLang['detail']['item_repairing'];
        improvement = dataLang['detail']['improvement'];
        ide = dataLang['detail']['idea'];
        waktu_kerja = dataLang['detail']['working_time'];
        cek_perbaikan = dataLang['detail']['check_repair'];
        istirahat = dataLang['detail']['break'];

        bm = dataLang['detail']['line_stop'];
        cost = dataLang['detail']['cost'];
        in_house = dataLang['detail']['in_house'];
        out_house = dataLang['detail']['out_house'];
        sparepart = dataLang['detail']['sparepart'];
        e_sign = dataLang['detail']['e_sign'];
        total_cost = dataLang['detail']['total_cost'];
        tanda_tangan = dataLang['detail']['signature'];

        tolak = dataLang['detail']['decline'];
        validasi_tanda_tangan = dataLang['detail']['toast_signature'];
        selesai = dataLang['detail']['done'];
        unduh_laporan = dataLang['detail']['download_report'];
        konfirmasi = dataLang['detail']['confirm'];
        validasi_unduh = dataLang['detail']['valid_download'];
        batal = dataLang['detail']['cancel'];
        unduh = dataLang['detail']['download'];
        approvedSign = dataLang['detail']['approved_esign'];
        declinedSign = dataLang['detail']['declined_esign'];
      });
    }
  }

  void getLanguageId() async {
    var response = await rootBundle.loadString("assets/lang/lang-id.json");
    var dataLang = json.decode(response)['data'];

    if (mounted) {
      setState(() {
        preventive_maintenance = dataLang['detail']['preventive'];

        tim_member = dataLang['detail']['tim_member'];
        kejadian = dataLang['detail']['incident'];
        why_analysis = dataLang['detail']['why_analys'];
        why_1 = dataLang['detail']['why_one'];
        pengecekan_item = dataLang['detail']['item_checking'];
        standard = dataLang['detail']['standard'];
        aktual = dataLang['detail']['actual'];
        jam = dataLang['detail']['time'];

        note = dataLang['detail']['note'];
        perbaikan = dataLang['detail']['repairing'];
        perbaikan_item = dataLang['detail']['item_repairing'];
        improvement = dataLang['detail']['improvement'];
        ide = dataLang['detail']['idea'];
        waktu_kerja = dataLang['detail']['working_time'];
        cek_perbaikan = dataLang['detail']['check_repair'];
        istirahat = dataLang['detail']['break'];

        bm = dataLang['detail']['line_stop'];
        cost = dataLang['detail']['cost'];
        in_house = dataLang['detail']['in_house'];
        out_house = dataLang['detail']['out_house'];
        sparepart = dataLang['detail']['sparepart'];
        e_sign = dataLang['detail']['e_sign'];
        total_cost = dataLang['detail']['total_cost'];
        tanda_tangan = dataLang['detail']['signature'];

        tolak = dataLang['detail']['decline'];
        validasi_tanda_tangan = dataLang['detail']['toast_signature'];
        selesai = dataLang['detail']['done'];
        unduh_laporan = dataLang['detail']['download_report'];
        konfirmasi = dataLang['detail']['confirm'];
        validasi_unduh = dataLang['detail']['valid_download'];
        batal = dataLang['detail']['cancel'];
        unduh = dataLang['detail']['download'];
        approvedSign = dataLang['detail']['approved_esign'];
        declinedSign = dataLang['detail']['declined_esign'];
      });
    }
  }

  void postAlasanTolakEcm() async {
    final SharedPreferences prefs = await _prefs;
    String tokenUser = SharedPrefsUtil.getTokenUser();
    String userId = SharedPrefsUtil.getIdUser();

    Map<String, dynamic> params = {
      // "id_notif": userId,
      "id_notif": widget.notifId,
      "alasan": alasanTolak.text
    };

    try {
      print("menolak ecm card");

      if (alasanTolak.text.isNotEmpty) {
        var result = await postAlasanTolakTL(params, tokenUser);

        print(result);

        if (result['response']['status'] == 200) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Center(
                  child: CircularProgressIndicator(
                    value: null,
                    strokeWidth: 2,
                  ),
                );
              });
          await _loadingAction();
          postUpdateStatus('2');
        } else {
          Fluttertoast.showToast(
              msg: 'Pembaruan status gagal',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.greenAccent,
              textColor: Colors.white,
              fontSize: 16);
        }
      } else {
        Fluttertoast.showToast(
            msg: 'Alasan penolakan harus diisi',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.white,
            fontSize: 16);
      }
    } catch (e) {
      print(e);
    }
  }

  void showDialogInputReason(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.topRight,
                  child: Image.asset(
                    "assets/icons/X.png",
                    width: 20,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Masukan alasan penolakan E-CM",
                      style: TextStyle(
                          color: Color(0xFF404446),
                          fontFamily: 'Rubik',
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 16, right: 16),
                      child: TextFormField(
                        controller: alasanTolak,
                        maxLines: 5,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: const Color(0xFF979C9E))),
                            contentPadding: EdgeInsets.all(8),
                            hintText: "Masukkan alasan Anda"),
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () async {
                  // Navigator.pop(context);
                  postAlasanTolakEcm();
                },
                child: Container(
                    margin: EdgeInsets.only(top: 20, left: 16, right: 16),
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Color(0xFF00AEDB),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Center(
                      child: Text(
                        "Kirim",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Rubik',
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    )),
              )
            ],
          );
        });
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

  List<ItemCheckModel> _listItemCheck = [];
  List<ItemRepairModel> _listItemRepair = [];
  List<SparepartModel> _listSparepart = [];
  List<EsignModel> _listEssign = [];
  DetailEcmModel detailEcmModel = DetailEcmModel();
  RegExp regex = RegExp(r"([.]*00)(?!.*\d)");
  String incidentEffect = "-";
  String incidentMistake = "-";

  //loading modal
  Future<bool> _loadingAction() async {
    //replace the below line of code with your login request
    await new Future.delayed(const Duration(seconds: 0));
    return true;
  }

  Future<List<ItemCheckModel>> getItemCheck() async {
    final SharedPreferences prefs = await _prefs;
    String notifUser = widget.notifId;
    String tokenUser = SharedPrefsUtil.getTokenUser();
    // String userId = SharedPrefsUtil.getIdUser();
    var response = await getDetailEcm(notifUser, tokenUser);
    if (response['response']['status'] == 200) {
      setStateIfMounted(() {
        var data = response['data']['item_check'] as List;
        _listItemCheck = data.map((e) => ItemCheckModel.fromJson(e)).toList();
        print("===== list item check =====");
        for (int i = 0; i < _listItemCheck.length; i++) {
          print(_listItemCheck[i].namaPart.toString() + ",");
        }
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
    return _listItemCheck;
  }

  Future<List<ItemRepairModel>> getItemRepair() async {
    final SharedPreferences prefs = await _prefs;
    String notifUser = widget.notifId;
    String tokenUser = SharedPrefsUtil.getTokenUser();
    // String userId = SharedPrefsUtil.getIdUser();
    var response = await getDetailEcm(notifUser, tokenUser);
    if (response['response']['status'] == 200) {
      setStateIfMounted(() {
        var data = response['data']['item_repair'] as List;
        _listItemRepair = data.map((e) => ItemRepairModel.fromJson(e)).toList();
        print("===== list item check =====");
        for (int i = 0; i < _listItemRepair.length; i++) {
          print(_listItemRepair[i].namaPart.toString() + ",");
        }
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
    return _listItemRepair;
  }

  Future<List<SparepartModel>> getSparepart() async {
    final SharedPreferences prefs = await _prefs;
    String notifUser = widget.notifId;
    String tokenUser = SharedPrefsUtil.getTokenUser();
    // String userId = SharedPrefsUtil.getIdUser();
    var response = await getDetailEcm(notifUser, tokenUser);
    if (response['response']['status'] == 200) {
      setStateIfMounted(() {
        var data = response['data']['sparepart'] as List;
        _listSparepart = data.map((e) => SparepartModel.fromJson(e)).toList();
        print("===== list item check =====");
        for (int i = 0; i < _listSparepart.length; i++) {
          print(_listSparepart[i].namaPart.toString() + ",");
        }
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
    return _listSparepart;
  }

  Future<List<EsignModel>> getEsign() async {
    final SharedPreferences prefs = await _prefs;
    String notifUser = widget.notifId;
    String tokenUser = SharedPrefsUtil.getTokenUser();
    // String userId = SharedPrefsUtil.getIdUser();
    var response = await getDetailEcm(notifUser, tokenUser);
    if (response['response']['status'] == 200) {
      setStateIfMounted(() {
        var data = response['data']['esign'] as List;
        _listEssign = data.map((e) => EsignModel.fromJson(e)).toList();
        print("===== list item check =====");
        for (int i = 0; i < _listEssign.length; i++) {
          print(_listEssign[i].nama.toString() + ",");
        }
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
    return _listEssign;
  }

  getDetailData() async {
    final SharedPreferences prefs = await _prefs;
    String notifUser = widget.notifId;
    String tokenUser = SharedPrefsUtil.getTokenUser();
    // String userId = SharedPrefsUtil.getIdUser();
    var response = await getDetailEcm(notifUser, tokenUser);
    try {
      setStateIfMounted(() {
        print(response['data']);
        detailEcmModel = DetailEcmModel.fromJson(response['data']);
        incidentEffect =
            IncidentEffect.fromJson(response['data']['incident_effect'])
                .toString();
        incidentMistake =
            IncidentMistake.fromJson(response['data']['incident_mistake'])
                .toString();
      });

      print("why 1");
      print(detailEcmModel.analisisWhy2);
    } catch (e) {
      print("detail ecm response -> $e");
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

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  postUpdateStatus(String statusUser) async {
    final SharedPreferences prefs = await _prefs;
    String notifUser = widget.notifId;
    String tokenUser = SharedPrefsUtil.getTokenUser();
    // String userId = SharedPrefsUtil.getIdUser();
    try {
      var response = await updateStatus(notifUser, statusUser, tokenUser);
      print(response);
      if (response['response']['status'] != 200) {
        Fluttertoast.showToast(
            msg: 'Pembaruan status gagal',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.white,
            fontSize: 16);
        return;
      }
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Center(
              child: CircularProgressIndicator(
                value: null,
                strokeWidth: 2,
              ),
            );
          });
      await _loadingAction();
      if (statusUser == '1') {
        Fluttertoast.showToast(
            msg: approvedSign,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16);
      } else {
        Fluttertoast.showToast(
            msg: declinedSign,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.redAccent,
            textColor: Colors.white,
            fontSize: 16);
      }
      // Navigator.of(context).pop();
      // Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (context) => ApprovedEcm()));
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Dashboard()),
          ModalRoute.withName("/"));
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetailData();
    getItemCheck();
    getItemRepair();
    getSparepart();
    getEsign();

    setBahasa();
    setLang();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff00AEDB),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          preventive_maintenance,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: detailEcmModel.nama.toString() == "null"
          ? Container(
              color: Colors.white,
              child: Center(
                // Display Progress Indicator
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              ))
          : SingleChildScrollView(
              child: Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 12),
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(detailEcmModel.foto ?? "-")),
                      ),
                    ),
                    Text(
                      detailEcmModel.nama.toString(),
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff00AEDB)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      // color: Colors.amberAccent,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .center, //Center Column contents vertically,
                          crossAxisAlignment: CrossAxisAlignment
                              .center, //Center Column contents horizontally,
                          children: [
                            Icon(Icons.location_on_outlined,
                                color: Colors.grey),
                            Text(
                              detailEcmModel.lokasi.toString() +
                                  " · " +
                                  detailEcmModel.tanggal.toString(),
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                    ),
                    Text("Machine : " +
                        detailEcmModel.machineNama.toString() +
                        " (" +
                        detailEcmModel.nomormesin.toString() +
                        ")"),
                    _buildDivider(),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text(kejadian,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                          detailEcmModel.incidentShift.toString() +
                              " · " +
                              detailEcmModel.incidentJam.toString() +
                              " · Effect : " +
                              incidentEffect +
                              " · Mistake : " +
                              incidentMistake,
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text(detailEcmModel.incidentProblem.toString(),
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(detailEcmModel
                                        .incidentFoto1
                                        .toString())),
                                color: Colors.grey[400],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(detailEcmModel
                                        .incidentFoto2
                                        .toString())),
                                color: Colors.grey[400],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(detailEcmModel
                                        .incidentFoto3
                                        .toString())),
                                color: Colors.grey[400],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(detailEcmModel
                                        .incidentFoto4
                                        .toString())),
                                color: Colors.grey[400],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                          ),
                        ],
                      ),
                    ),
                    _buildDivider(),
                    Container(
                      child: _buildItemAnalyst(),
                    ),
                    _buildDivider(),
                    Container(
                      child: _buildItemCheck(),
                    ),
                    _buildDivider(),
                    Container(
                      child: _buildItemRepairing(),
                    ),
                    _buildDivider(),
                    Container(
                      child: _buildImprovement(),
                    ),
                    _buildDivider(),
                    Container(
                      child: _buildWorkingTime(),
                    ),
                    _buildDivider(),
                    Container(
                      child: _buildCost(),
                    ),
                    _buildDivider(),
                    Container(
                      child: _buildSparePart(),
                    ),
                    _buildDivider(),
                    Container(
                      child: _buildSign(),
                    ),
                    _buildDivider(),
                    Container(
                      child: _buildTotalCost(),
                    ),
                    SizedBox(height: 20),
                    isDeclined == false
                        ? Container()
                        : Container(
                            margin: EdgeInsets.only(top: 8),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Masukan alasan penolakan E-CM",
                                  style: TextStyle(
                                      color: Color(0xFF404446),
                                      fontFamily: 'Rubik',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    top: 10,
                                  ),
                                  child: TextFormField(
                                    controller: alasanTolak,
                                    maxLines: 5,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color:
                                                    const Color(0xFF979C9E))),
                                        contentPadding: EdgeInsets.all(8),
                                        hintText: "Masukkan alasan Anda"),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    // Navigator.pop(context);
                                    postAlasanTolakEcm();
                                  },
                                  child: Container(
                                      margin: EdgeInsets.only(
                                        top: 20,
                                      ),
                                      width: MediaQuery.of(context).size.width,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: Color(0xFF00AEDB),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      child: Center(
                                        child: Text(
                                          "Kirim",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Rubik',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      )),
                                )
                              ],
                            ),
                          ),
                    SizedBox(height: 20),
                    Visibility(
                      visible: widget.isShowButton,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: _buildButtonDecline(),
                          ),
                          Container(
                            child: _buildButtonAdd(),
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

  Widget _buildDivider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      color: Colors.grey,
      height: 2,
      width: MediaQuery.of(context).size.width,
    );
  }

  Widget _buildItemAnalyst() {
    return Container(
        child: Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: Text(why_analysis,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87)),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            SizedBox(
              width: 100,
              child: Text(why_1),
            ),
            Text(" : "),
            Expanded(
              flex: 4,
              child: Text(
                detailEcmModel.analisisWhy1.toString() == "null"
                    ? " - "
                    : detailEcmModel.analisisWhy1.toString(),
              ),
            )
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            SizedBox(
              width: 100,
              child: Text("Why 2"),
            ),
            Text(" : "),
            Expanded(
              flex: 4,
              child: Text(
                detailEcmModel.analisisWhy2.toString() == "null"
                    ? " - "
                    : detailEcmModel.analisisWhy2.toString(),
              ),
            )
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            SizedBox(
              width: 100,
              child: Text("Why 3"),
            ),
            Text(" : "),
            Expanded(
              flex: 4,
              child: Text(
                detailEcmModel.analisisWhy3.toString() == "null"
                    ? " - "
                    : detailEcmModel.analisisWhy3.toString(),
              ),
            )
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            SizedBox(
              width: 100,
              child: Text("Why 4"),
            ),
            Text(" : "),
            Expanded(
              flex: 4,
              child: Text(
                detailEcmModel.analisisWhy4.toString() == "null"
                    ? " - "
                    : detailEcmModel.analisisWhy4.toString(),
              ),
            )
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            SizedBox(
              width: 100,
              child: Text("How"),
            ),
            Text(" : "),
            Expanded(
              flex: 4,
              child: Text(
                detailEcmModel.analisisHow.toString() == "null"
                    ? " - "
                    : detailEcmModel.analisisHow.toString(),
              ),
            )
          ],
        ),
      ],
    ));
  }

  Widget _buildItemCheck() {
    return Container(
        child: Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: Text(pengecekan_item,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87)),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _listItemCheck.isEmpty ? 0 : _listItemCheck.length,
            itemBuilder: (context, i) {
              return Container(
                margin: EdgeInsets.only(bottom: 8, top: 8),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                          (i + 1).toString() +
                              ". " +
                              _listItemCheck[i]
                                  .namaPart
                                  .toString()
                                  .toUpperCase(),
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(standard),
                        ),
                        Text(" : "),
                        Expanded(
                          flex: 4,
                          child: Text(_listItemCheck[i].namaStandar.toString()),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(aktual),
                        ),
                        Text(" : "),
                        Expanded(
                          flex: 4,
                          child: Text(_listItemCheck[i].actual.toString()),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(jam),
                        ),
                        Text(" : "),
                        Expanded(
                          flex: 4,
                          child: Text(_listItemCheck[i].time.toString()),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(note),
                        ),
                        Text(" : "),
                        Wrap(children: [
                          _listItemCheck[i].note.toString() == "null"
                              ? const Text("-")
                              : _buildNoteWidget(
                                  _listItemCheck[i].note.toString()),
                        ])
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    ));
  }

  Widget _buildItemRepairing() {
    return Container(
        child: Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: Text(perbaikan_item,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87)),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _listItemRepair.isEmpty ? 0 : _listItemRepair.length,
            itemBuilder: (context, i) {
              return Container(
                margin: EdgeInsets.only(bottom: 8, top: 8),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                          (i + 1).toString() +
                              ". " +
                              _listItemRepair[i]
                                  .namaPart
                                  .toString()
                                  .toUpperCase(),
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(jam),
                        ),
                        Text(" : "),
                        Expanded(
                          flex: 4,
                          child: Text(_listItemRepair[i].time.toString()),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(perbaikan),
                        ),
                        Text(" : "),
                        Expanded(
                          flex: 4,
                          child: Text(_listItemRepair[i]
                              .repairing
                              .toString()
                              .toUpperCase()),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(note),
                        ),
                        Text(" : "),
                        Wrap(
                          children: [
                            _buildNoteWidget(
                              _listItemRepair[i].note.toString(),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    ));
  }

  Widget _buildImprovement() {
    return Container(
        child: Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: Text(improvement,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87)),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              child: Text(ide),
            ),
            Text(" : "),
            Expanded(
              flex: 4,
              child: Text(detailEcmModel.kaizenIdea.toString()),
            )
          ],
        ),
      ],
    ));
  }

  Widget _buildWorkingTime() {
    return Container(
        child: Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: Text(waktu_kerja,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87)),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              child: Text(cek_perbaikan),
            ),
            Text(" : "),
            Expanded(
                flex: 4,
                child: Text(
                  detailEcmModel.kaizenCheckH.toString() +
                      " H " +
                      detailEcmModel.kaizenCheckM.toString() +
                      " M + " +
                      detailEcmModel.kaizenRepairH.toString() +
                      " H " +
                      detailEcmModel.kaizenRepairM.toString() +
                      " M = " +
                      detailEcmModel.kaizenTotalH.toString() +
                      " H " +
                      detailEcmModel.kaizenTotalM.toString() +
                      " M",
                )),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              child: Text(istirahat),
            ),
            Text(" : "),
            Expanded(
              flex: 4,
              child: Text(detailEcmModel.kaizenBreaktimeH.toString() +
                  " H " +
                  detailEcmModel.kaizenBreaktimeM.toString() +
                  " M"),
            )
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 100,
              child: Text(bm),
            ),
            Text(" : "),
            Expanded(
              flex: 4,
              child: Text(
                detailEcmModel.kaizenLinestarH.toString() +
                    " H " +
                    detailEcmModel.kaizenLinestarM.toString() +
                    " M - " +
                    detailEcmModel.kaizenLinestopH.toString() +
                    " H " +
                    detailEcmModel.kaizenLinestopM.toString() +
                    " M = " +
                    detailEcmModel.kaizenTotallinestopH.toString() +
                    " H " +
                    detailEcmModel.kaizenTotallinestopM.toString() +
                    " M",
              ),
            )
          ],
        ),
      ],
    ));
  }

  Widget _buildCost() {
    return Container(
        child: Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: Text(cost,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87)),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Text(in_house),
            ),
            Text(detailEcmModel.kaizenCosthouse.toString()),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Text(out_house),
            ),
            Text(detailEcmModel.kaizenOutcosthouse.toString()),
          ],
        ),
      ],
    ));
  }

  Widget _buildSparePart() {
    return Container(
        child: Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: Text(sparepart,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87)),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _listSparepart.isEmpty ? 0 : _listSparepart.length,
            itemBuilder: (context, i) {
              return Container(
                margin: EdgeInsets.only(bottom: 8, top: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text((i + 1).toString() +
                          ". " +
                          _listSparepart[i].namaPart.toString().toUpperCase() +
                          " - (" +
                          _listSparepart[i]
                              .qty
                              .toString()
                              .replaceAll(regex, "") +
                          ")"),
                    ),
                    Text("Rp. " +
                        NumberFormat.currency(
                                locale: 'id', decimalDigits: 0, symbol: '')
                            .format(int.parse(
                                _listSparepart[i].totalHarga.toString()))),
                  ],
                ),
              );
            },
          ),
        )
      ],
    ));
  }

  Widget _buildSign() {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: Text(e_sign,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87)),
        ),
        SizedBox(
          height: 10,
          width: MediaQuery.of(context).size.width,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _listEssign.isEmpty ? 0 : _listEssign.length,
            itemBuilder: (context, i) {
              return Container(
                  margin: EdgeInsets.only(bottom: 8, top: 8),
                  child: Text(
                    (i + 1).toString() +
                        ". " +
                        _listEssign[i].nama.toString() +
                        " - " +
                        _listEssign[i].jabatan.toString(),
                    style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ));
            },
          ),
        )
      ],
    ));
  }

  Widget _buildTotalCost() {
    return Container(
        child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 4,
              child: Text(total_cost,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87)),
            ),
            Text("Rp. " + detailEcmModel.totalCost.toString()),
          ],
        ),
      ],
    ));
  }

  Widget _buildButtonAdd() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.44,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor:
                    MaterialStateProperty.all<Color>(const Color(0xff00AEDB)),
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(horizontal: 0, vertical: 14)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                )),
                textStyle:
                    MaterialStateProperty.all(TextStyle(fontSize: 16.0))),
            onPressed: () async {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Center(
                      child: CircularProgressIndicator(
                        value: null,
                        strokeWidth: 2,
                      ),
                    );
                  });
              await _loadingAction();
              postUpdateStatus('1');
            },
            child: Text(
              tanda_tangan,
              style: TextStyle(
                fontFamily: 'NunitoSans',
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonDecline() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.44,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.all<Color>(Colors.redAccent),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(horizontal: 0, vertical: 14)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        side: BorderSide(color: Colors.redAccent))),
                textStyle:
                    MaterialStateProperty.all(TextStyle(fontSize: 16.0))),
            onPressed: () {
              setState(() {
                isDeclined = !isDeclined;
              });
              // showDialogInputReason(context);
            },
            child: Text(
              tolak,
              style: TextStyle(
                fontFamily: 'Rubick',
                color: Colors.redAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoteWidget(String noteValue) {
    switch (noteValue) {
      case "ok":
        return _buildOkWidget();
      case "limit":
        return _buildLimitWidget();
      default:
        return _buildNgWidget();
    }
  }

  Widget _buildOkWidget() {
    return Container(
      margin: const EdgeInsets.only(top: 10, right: 10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFF00AEDB),
          ),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: Colors.transparent),
      // ignore: prefer_const_literals_to_create_immutables
      child: Row(
        children: const <Widget>[
          Icon(
            Icons.circle_outlined,
            color: Color(0xFF00AEDB),
            size: 20,
          ),
          Text(
            'OK',
            style: TextStyle(
                color: Color(0xFF00AEDB), fontSize: 16, fontFamily: 'Rubik'),
          )
        ],
      ),
    );
  }

  Widget _buildLimitWidget() {
    return Container(
      margin: const EdgeInsets.only(top: 10, right: 10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFF00AEDB),
          ),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: Colors.transparent),
      // ignore: prefer_const_literals_to_create_immutables
      child: Row(
        children: const <Widget>[
          Icon(
            Icons.change_history_outlined,
            color: Color(0xFF00AEDB),
            size: 20,
          ),
          Text(
            'Limit',
            style: TextStyle(
                color: Color(0xFF00AEDB), fontSize: 16, fontFamily: 'Rubik'),
          )
        ],
      ),
    );
  }

  Widget _buildNgWidget() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFF00AEDB),
          ),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: Colors.transparent),
      // ignore: prefer_const_literals_to_create_immutables
      child: Row(
        children: const <Widget>[
          Icon(
            Icons.close,
            color: Color(0xFF00AEDB),
            size: 20,
          ),
          Text(
            'N / G',
            style: TextStyle(
                color: Color(0xFF00AEDB), fontSize: 16, fontFamily: 'Rubik'),
          )
        ],
      ),
    );
  }
}
