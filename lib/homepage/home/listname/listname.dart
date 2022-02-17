// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'dart:convert';

import 'package:e_cm/homepage/home/listname/service/listtmservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListTmName extends StatefulWidget {
  const ListTmName({Key? key}) : super(key: key);

  @override
  _ListTmNameState createState() => _ListTmNameState();
}

class _ListTmNameState extends State<ListTmName> {
  String bahasa = "Bahasa Indonesia";
  bool bahasaSelected = false;

  String list_tm = '';
  String loading = '';

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
        list_tm = dataLang['daftar_nama_tm']['name_tm'];
        loading = dataLang['daftar_nama_tm']['loading'];
      });
    }
  }

  void getLanguageId() async {
    var response = await rootBundle.loadString("assets/lang/lang-id.json");
    var dataLang = json.decode(response)['data'];

    if (mounted) {
      setState(() {
        list_tm = dataLang['daftar_nama_tm']['name_tm'];
        loading = dataLang['daftar_nama_tm']['loading'];
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

  List listTmName = [];

  Future getListTmFromService() async {
    try {
      final prefs = await _prefs;
      String tokenUser = prefs.getString("tokenKey").toString();
      String idUser = prefs.getString("idKeyUser").toString();

      listTmName = await listTmService.getListTmName(tokenUser, idUser);

      return await listTmService.getListTmName(tokenUser, idUser);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getListTmFromService();
    super.initState();
    setBahasa();
    setLang();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF00AEDB),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          list_tm,
          style: TextStyle(
              fontFamily: 'Rubik', fontSize: 16, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16),
        child: FutureBuilder(
          future: getListTmFromService(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Text(
                    loading,
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              itemCount: listTmName.length,
              itemBuilder: (context, i) {
                return Container(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Color(0xFFE3E5E5)))),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        child: CircleAvatar(
                          radius: 48,
                          child: listTmName[i]['photo'] == null
                              ? Image.asset("assets/images/img_ava.png")
                              : Image.network(listTmName[i]['photo']),
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFF00AEDB),
                          shape: BoxShape.circle,
                          // image: DecorationImage(
                          //     image: NetworkImage(listTmName[i]['photo']))
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 16,
                          ),
                          // ignore: prefer_const_literals_to_create_immutables
                          children: <TextSpan>[
                            TextSpan(
                                text: listTmName[i]['nama'],
                                style: TextStyle(
                                    color: Color(0xFF00AEDB),
                                    fontWeight: FontWeight.w700)),
                            TextSpan(
                                text: ' - ',
                                style: TextStyle(color: Color(0xFF00AEDB))),
                            TextSpan(
                                text: listTmName[i]['jabatan'],
                                style: TextStyle(color: Color(0xFF00AEDB))),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
