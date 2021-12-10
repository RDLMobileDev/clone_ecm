// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:e_cm/homepage/home/listname/service/listtmservice.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListTmName extends StatefulWidget {
  const ListTmName({Key? key}) : super(key: key);

  @override
  _ListTmNameState createState() => _ListTmNameState();
}

class _ListTmNameState extends State<ListTmName> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  List listTmName = [];

  Future getListTmFromService() async {
    final prefs = await _prefs;
    String tokenUser = prefs.getString("tokenKey").toString();
    String idUser = prefs.getString("idKeyUser").toString();

    listTmName = await listTmService.getListTmName(tokenUser, idUser);

    return await listTmService.getListTmName(tokenUser, idUser);
  }

  @override
  void initState() {
    getListTmFromService();
    super.initState();
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
          "TM Name",
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
            if(!snapshot.hasData){
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Center(child: Text("Loading List TM Name...",style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 16,
                      ),),),
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
                  border: Border(bottom: BorderSide(color: Color(0xFFE3E5E5)))),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                        color: Color(0xFF00AEDB),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage("assets/images/ario.png"))),
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
