// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, avoid_unnecessary_containers
import 'package:e_cm/homepage/home/fillnew/additionpage/add_item_step7.dart';
import 'package:e_cm/homepage/home/model/partitemmachinesavedmodel.dart';
import 'package:e_cm/homepage/home/services/PartItemMachineSaveService.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StepFillTujuh extends StatefulWidget {
  const StepFillTujuh({Key? key}) : super(key: key);

  @override
  _StepFillTujuhState createState() => _StepFillTujuhState();
}

class _StepFillTujuhState extends State<StepFillTujuh> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  List<PartItemMachineSavedModel> _listDataPartSaved = [];

  Future getDataPartItemSaved() async {
    final prefs = await _prefs;
    String tokenUser = prefs.getString("tokenKey").toString();
    String? idEcmKey = prefs.getString("idEcm");

    _listDataPartSaved = await partItemMachineSaveService
        .getPartItemMachineSaveData(tokenUser, idEcmKey!);

    return await partItemMachineSaveService.getPartItemMachineSaveData(
        tokenUser, idEcmKey);
  }

  void deletePartMachineSaved() async {
    final prefs = await _prefs;
    String tokenUser = prefs.getString("tokenKey").toString();
    var idPart = prefs.getString("idPartItemMachine");
    var result = await partItemMachineSaveService.deletePartMachineSaved(
        idPart!, tokenUser);

    print(result);

    await getDataPartItemSaved();

    Fluttertoast.showToast(
        msg: 'Data Disimpan',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.greenAccent,
        textColor: Colors.white,
        fontSize: 16);
  }

  @override
  void initState() {
    getDataPartItemSaved();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Text("Spare Part",
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  )),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: _listDataPartSaved.isEmpty
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/images/empty.png",
                            width: 250,
                          ),
                          Center(
                            child: Text("No spare part yet",
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  color: Color(0xFF00AEDB),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                )),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _listDataPartSaved.length,
                        itemBuilder: (context, i) {
                          return Container(
                            padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Color(0xFF00AEDB),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Column(
                              // ignore: prefer_const_literals_to_create_immutables
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Selang",
                                    style: TextStyle(
                                      fontFamily: 'Rubik',
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text(
                                          "Cost: ${_listDataPartSaved[i].total_harga}",
                                          style: TextStyle(
                                            fontFamily: 'Rubik',
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                          )),
                                    ),
                                    Container(
                                      width: 60,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Image.asset(
                                            "assets/icons/akar-icons_edit.png",
                                            width: 20,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              deletePartMachineSaved();
                                            },
                                            child: Image.asset(
                                              "assets/icons/trash.png",
                                              width: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddItemFillTujuh()));
              },
              child: Container(
                margin: EdgeInsets.only(top: 50),
                width: MediaQuery.of(context).size.width,
                height: 40,
                decoration: BoxDecoration(
                    color: Color(0xFF00AEDB),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Icon(
                        Icons.add_circle_outline,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Add Item",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            color: Colors.white,
                            fontSize: 12,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
