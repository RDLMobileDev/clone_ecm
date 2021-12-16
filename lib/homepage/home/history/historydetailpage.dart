import 'package:e_cm/homepage/home/model/detailecmmodel.dart';
import 'package:e_cm/homepage/home/model/detailesignmodel.dart';
import 'package:e_cm/homepage/home/model/detailitemcheckmodel.dart';
import 'package:e_cm/homepage/home/model/detailitemrepairmodel.dart';
import 'package:e_cm/homepage/home/model/detailsparepartmodel.dart';
import 'package:e_cm/homepage/home/model/incident_effect.dart';
import 'package:e_cm/homepage/home/model/incident_mistake.dart';
import 'package:e_cm/homepage/home/services/apidetailecm.dart';
import 'package:e_cm/homepage/home/services/apiupdatestatusecm.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class HistoryDetailPage extends StatefulWidget {
  final String notifId;

  const HistoryDetailPage({required this.notifId});

  @override
  _HistoryDetailPageState createState() => _HistoryDetailPageState();
}

class _HistoryDetailPageState extends State<HistoryDetailPage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  List<ItemCheckModel> _listItemCheck = [];
  List<ItemRepairModel> _listItemRepair = [];
  List<SparepartModel> _listSparepart = [];
  List<EsignModel> _listEssign = [];
  DetailEcmModel detailEcmModel = DetailEcmModel();
  RegExp regex = RegExp(r"([.]*00)(?!.*\d)");
  String incidentEffect = "-";
  String incidentMistake = "-";

  Future<List<ItemCheckModel>> getItemCheck() async {
    final SharedPreferences prefs = await _prefs;
    String notifUser = widget.notifId;
    String? tokenUser = prefs.getString("tokenKey").toString();
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
    String? tokenUser = prefs.getString("tokenKey").toString();
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
    String? tokenUser = prefs.getString("tokenKey").toString();
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
    String? tokenUser = prefs.getString("tokenKey").toString();
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
    String? tokenUser = prefs.getString("tokenKey").toString();
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

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  postUpdateStatus(String statusUser) async {
    final SharedPreferences prefs = await _prefs;
    String notifUser = widget.notifId;
    String? tokenUser = prefs.getString("tokenKey").toString();
    try {
      var response = await updateStatus(notifUser, notifUser, tokenUser);
      print(response);
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

  void _launchURL() async {
    String url =
        "https://app.ragdalion.com/ecm/webviewreportpdfecm?id=${widget.notifId}";
    if (!await launch(url)) throw 'Could not open $url';
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
          "Preventive Maintance",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
                      image: AssetImage('assets/images/img_ava.png')),
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
                      Icon(Icons.location_on_outlined, color: Colors.grey),
                      Text(
                        detailEcmModel.lokasi.toString() +
                            " · " +
                            detailEcmModel.tanggal.toString(),
                        style: TextStyle(fontSize: 14, color: Colors.grey),
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
                child: const Text("Incident",
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
                              image: NetworkImage(
                                  detailEcmModel.incidentFoto1.toString())),
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  detailEcmModel.incidentFoto2.toString())),
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  detailEcmModel.incidentFoto3.toString())),
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  detailEcmModel.incidentFoto4.toString())),
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.all(Radius.circular(20))),
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
              Container(
                child: _buildButtonAdd(),
              ),
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
          child: const Text("Why Analisis",
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
              child: Text("Why 1"),
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
          child: const Text("Item Checking",
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
                          child: Text("Standart"),
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
                          child: Text("Actual"),
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
                          child: Text("Time"),
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
                          child: Text("Note"),
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
          child: const Text("Item Repairing",
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
                          child: Text("Time"),
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
                          child: Text("Repairing"),
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
                          child: Text("Note"),
                        ),
                        Text(" : "),
                        Wrap(
                          children: [
                            _buildNoteWidget(
                              _listItemRepair[i].note.toString(),
                            )
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
          child: const Text("Improvement/Kaizen",
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
              child: Text("Idea"),
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
          child: const Text("Working Time",
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
              child: Text("Check & Repair"),
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
              child: Text("Break time"),
            ),
            Text(" : "),
            Expanded(
              flex: 4,
              child:
                  Text(detailEcmModel.kaizenBreaktimeH.toString() + " H 0 M"),
            )
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 100,
              child: Text("Line stop"),
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
          child: const Text("Cost",
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
              child: Text("In-House M/P Cost (Rp)"),
            ),
            Text(detailEcmModel.kaizenCosthouse.toString()),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Text("Out-House (Rp) : "),
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
          child: const Text("Sparepart",
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
          child: const Text("E-Sign",
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
                        _listEssign[i].nama.toString(),
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
              child: Text("Total Cost (Rp) :",
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
      width: MediaQuery.of(context).size.width,
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
            onPressed: () {
              _launchURL();
            },
            child: Text(
              'Download Report',
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
              postUpdateStatus('decline');
            },
            child: Text(
              'Decline',
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
