// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:e_cm/baseurl/baseurl.dart';
import 'package:e_cm/homepage/home/model/partitemmachinemodel.dart';
import 'package:e_cm/homepage/home/services/PartItemMachineSaveService.dart';
import 'package:e_cm/homepage/home/services/api_get_item_steptujuh.dart';
import 'package:e_cm/homepage/home/services/apifillsteptujuhformpage.dart';
import 'package:e_cm/homepage/home/services/partitemmachineservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddItemFillTujuh extends StatefulWidget {
  final bool? isFromUpdate;
  final String? partIdEcm;
  const AddItemFillTujuh({Key? key, this.isFromUpdate, this.partIdEcm})
      : super(key: key);

  @override
  _AddItemFillTujuhState createState() => _AddItemFillTujuhState();
}

class _AddItemFillTujuhState extends State<AddItemFillTujuh> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  TextEditingController partNameController = TextEditingController();
  TextEditingController costRpController = TextEditingController();

  List<PartItemMachineModel> listItemMachineData = [];
  List itemPartStepTujuh = [];

  bool isTapPartItemMachineInput = false;
  bool enableSave = false;
  int qtyStock = 0;
  int qtyUsed = 0;
  int subTotal = 0;

  String bahasa = "Bahasa Indonesia";
  bool bahasaSelected = false;

  String sparepart = "";
  String no_sparepart = "";
  String add_item = "";
  String part_name = "";
  String type_name = "";
  String quantity_used = "";
  String quantity_stock = "";
  String cost = "";
  String type_cost = "";
  String subtotal2 = "";
  String save_sparepart = "";
  String cost_ = "";
  String total_cost = "";
  String back = "";
  String next_eight = "";

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
        sparepart = dataLang['step_7']['sparepart'];
        no_sparepart = dataLang['step_7']['no_sparepart'];
        add_item = dataLang['step_7']['add_item'];
        part_name = dataLang['step_7']['part_name'];
        type_name = dataLang['step_7']['type_name'];
        quantity_used = dataLang['step_7']['quantity_used'];
        quantity_stock = dataLang['step_7']['quantity_stock'];
        cost = dataLang['step_7']['cost'];
        total_cost = dataLang['step_7']['total_cost'];
        back = dataLang['step_7']['back'];
        next_eight = dataLang['step_7']['next_eight'];
        subtotal2 = dataLang['step_7']['subtotal'];
        save_sparepart = dataLang['step_7']['save_sparepart'];
        cost_ = dataLang['step_7']['cost_'];
        type_cost = dataLang['step_7']['type_cost'];
      });
    }
  }

  void getLanguageId() async {
    var response = await rootBundle.loadString("assets/lang/lang-id.json");
    var dataLang = json.decode(response)['data'];

    if (mounted) {
      setState(() {
        sparepart = dataLang['step_7']['sparepart'];
        no_sparepart = dataLang['step_7']['no_sparepart'];
        add_item = dataLang['step_7']['add_item'];
        part_name = dataLang['step_7']['part_name'];
        type_name = dataLang['step_7']['type_name'];
        quantity_used = dataLang['step_7']['quantity_used'];
        quantity_stock = dataLang['step_7']['quantity_stock'];
        cost = dataLang['step_7']['cost'];
        total_cost = dataLang['step_7']['total_cost'];
        back = dataLang['step_7']['back'];
        next_eight = dataLang['step_7']['next_eight'];
        subtotal2 = dataLang['step_7']['subtotal'];
        save_sparepart = dataLang['step_7']['save_sparepart'];
        cost_ = dataLang['step_7']['cost_'];
        type_cost = dataLang['step_7']['type_cost'];
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

  void getItemUpdate(String idDataEcm) async {
    Map<String, dynamic> dataUpdateEcmPart = {};
    final prefs = await _prefs;
    String tokenUser = prefs.getString("tokenKey").toString();
    dataUpdateEcmPart =
        await partItemMachineService.getDataForUpdateEcm(idDataEcm, tokenUser);
    print(idDataEcm);

    setState(() {
      partNameController =
          TextEditingController(text: dataUpdateEcmPart['partname']);
      qtyStock = double.parse(dataUpdateEcmPart['stock']).toInt();
      qtyUsed = double.parse(dataUpdateEcmPart['used']).toInt();
      costRpController =
          TextEditingController(text: dataUpdateEcmPart['harga'].toString());

      subTotal = qtyUsed * double.parse(costRpController.text).toInt();
    });
  }

  Future<List> getPartItembyMacchine() async {
    final prefs = await _prefs;
    String tokenUser = prefs.getString("tokenKey").toString();
    String idEcmKey = prefs.getString("idEcm") ?? "";

    listItemMachineData =
        await partItemMachineService.getPartItemMachine(tokenUser, idEcmKey);

    return await partItemMachineService.getPartItemMachine(tokenUser, idEcmKey);
  }

  saveUpdatePart() async {
    final prefs = await _prefs;
    String tokenUser = prefs.getString("tokenKey").toString();
    print("tes update step 7");

    try {
      var resultUpdate = await partItemMachineService.saveUpdateFroEcm(
          tokenUser, widget.partIdEcm!, qtyUsed.toString(), "0");
      if (resultUpdate['response']['status'] == 200) {
        Fluttertoast.showToast(
          msg: 'Item berhasil diperbarui',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.greenAccent,
        );
        prefs.setString("sparePartBool", "1");
        Navigator.of(context).pop();
      } else {
        Fluttertoast.showToast(
          msg: 'Item gagal diperbarui',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.greenAccent,
        );
      }
    } catch (e) {
      print(e);
    }
  }

  saveSparePart(String qtyUsed, String costRp) async {
    final prefs = await _prefs;
    String tokenUser = prefs.getString("tokenKey").toString();
    String? idEcmKey = prefs.getString("idEcm");
    String? idMesin = prefs.getString("id_machine_res");
    var idPartMachine = prefs.getString("idPartItemMachine");

    try {
      if ((int.parse(qtyUsed) <= qtyStock) | (int.parse(qtyUsed) >= qtyStock)) {
        var result = await saveDataPartMachine(tokenUser, idEcmKey!, idMesin!,
            partNameController.text, qtyStock.toString(), qtyUsed, "0");

        print(result);
        if (result['response']['status'] == 200) {
          prefs.setString("sparePartBool", "1");
          Fluttertoast.showToast(
            msg: 'Data item step 7 disimpan',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.greenAccent,
          );
          Navigator.of(context).pop();
        } else {
          Fluttertoast.showToast(
            msg: 'Data gagal disimpan',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.greenAccent,
          );
        }
      }
    } on SocketException catch (e) {
      Fluttertoast.showToast(
        msg: 'Koneksi Anda terputus, coba lagi nanti',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.greenAccent,
      );
    } on TimeoutException catch (e) {
      Fluttertoast.showToast(
        msg: 'Waktu koneksi Anda habis, coba lagi nanti',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.greenAccent,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Terjadi kesalahan, periksa koneksi Anda',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.greenAccent,
      );
    }
  }

  void getItemForStep7() async {
    final prefs = await _prefs;
    String tokenUser = prefs.getString("tokenKey").toString();
    String idEcmKey = prefs.getString("idEcm") ?? "";

    itemPartStepTujuh = await getItemStepTujuh(tokenUser, idEcmKey);
  }

  @override
  void initState() {
    getPartItembyMacchine();

    if (widget.isFromUpdate == true) {
      getItemUpdate(widget.partIdEcm!);
      setState(() {
        enableSave = true;
      });
    }

    super.initState();
    setBahasa();
    setLang();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF00AEDB),
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 16, right: 16),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 16,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text: part_name,
                                style: TextStyle(color: Color(0xFF404446))),
                            TextSpan(
                                text: ' * ',
                                style: TextStyle(color: Colors.red)),
                            TextSpan(
                                text: ':',
                                style: TextStyle(color: Color(0xFF404446))),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      height: 60,
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFF979C9E)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                      child: TextFormField(
                        controller: partNameController,
                        maxLength: 50,
                        style: const TextStyle(
                            fontFamily: 'Rubik',
                            color: Color(0xFF404446),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 10, left: 10),
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            hintText: type_name),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 16,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                    text: quantity_used,
                                    style: TextStyle(color: Color(0xFF404446))),
                                TextSpan(
                                    text: ' * ',
                                    style: TextStyle(color: Colors.red)),
                                TextSpan(
                                    text: ':',
                                    style: TextStyle(color: Color(0xFF404446))),
                              ],
                            ),
                          ),
                          Container(
                            width: 110,
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFF979C9E)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      qtyUsed != 0 ? qtyUsed-- : null;

                                      int costRp =
                                          costRpController.text.isNotEmpty
                                              ? int.parse(costRpController.text)
                                              : 0;

                                      subTotal = qtyUsed * costRp;

                                      if (qtyUsed == 0) {
                                        enableSave = false;
                                      }
                                    });
                                  },
                                  child: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: Icon(
                                      Icons.remove,
                                      color: qtyUsed != 0
                                          ? Color(0xFF20519F)
                                          : Color(0xFF979C9E),
                                    ),
                                  ),
                                ),
                                Text(qtyUsed.toString(),
                                    style: TextStyle(
                                        color: Color(0xFF404446),
                                        fontFamily: 'Rubik',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700)),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      qtyUsed++;

                                      int costRp =
                                          costRpController.text.isNotEmpty
                                              ? int.parse(costRpController.text)
                                              : 0;

                                      subTotal = qtyUsed * costRp;

                                      enableSave = true;
                                    });
                                  },
                                  child: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: Icon(
                                      Icons.add,
                                      color: Color(0xFF20519F),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 16,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                    text: quantity_stock,
                                    style: TextStyle(color: Color(0xFF404446))),
                                TextSpan(
                                    text: ' * ',
                                    style: TextStyle(color: Colors.red)),
                                TextSpan(
                                    text: ':',
                                    style: TextStyle(color: Color(0xFF404446))),
                              ],
                            ),
                          ),
                          Container(
                            width: 110,
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFF979C9E)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      qtyStock != 0 ? qtyStock-- : null;
                                      if (qtyStock == 0) {
                                        enableSave = false;
                                      }
                                    });
                                  },
                                  child: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: Icon(
                                      Icons.remove,
                                      color: qtyStock != 0
                                          ? Color(0xFF20519F)
                                          : Color(0xFF979C9E),
                                    ),
                                  ),
                                ),
                                Text(qtyStock.toString(),
                                    style: TextStyle(
                                        color: Color(0xFF404446),
                                        fontFamily: 'Rubik',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700)),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      qtyStock++;
                                      enableSave = true;
                                    });
                                  },
                                  child: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: Icon(
                                      Icons.add,
                                      color: Color(0xFF20519F),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Container(
                    //   margin: const EdgeInsets.only(top: 16),
                    //   child: RichText(
                    //     text: TextSpan(
                    //       style: TextStyle(
                    //         fontFamily: 'Rubik',
                    //         fontSize: 16,
                    //       ),
                    //       children: <TextSpan>[
                    //         TextSpan(
                    //             text: cost,
                    //             style: TextStyle(color: Color(0xFF404446))),
                    //         TextSpan(
                    //             text: ' * ',
                    //             style: TextStyle(color: Colors.red)),
                    //         TextSpan(
                    //             text: ':',
                    //             style: TextStyle(color: Color(0xFF404446))),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // Container(
                    //   padding: EdgeInsets.all(4),
                    //   margin: const EdgeInsets.only(top: 5),
                    //   height: 50,
                    //   decoration: BoxDecoration(
                    //       border: Border.all(color: const Color(0xFF979C9E)),
                    //       borderRadius:
                    //           const BorderRadius.all(Radius.circular(5))),
                    //   child: TextFormField(
                    //     controller: costRpController,
                    //     maxLength: 7,
                    //     onChanged: (value) {
                    //       if (value.length <= 7) {
                    //         int costRp = value.isEmpty ? 0 : int.parse(value);

                    //         setState(() {
                    //           subTotal = qtyUsed * costRp;
                    //         });
                    //       } else {
                    //         Fluttertoast.showToast(
                    //           msg: 'Cost tidak boleh melebihi 7 angka',
                    //           toastLength: Toast.LENGTH_SHORT,
                    //           gravity: ToastGravity.BOTTOM,
                    //           backgroundColor: Colors.greenAccent,
                    //         );
                    //       }
                    //     },
                    //     keyboardType: TextInputType.number,
                    //     style: const TextStyle(
                    //         fontFamily: 'Rubik',
                    //         color: Color(0xFF404446),
                    //         fontSize: 14,
                    //         fontWeight: FontWeight.w400,
                    //         fontStyle: FontStyle.normal),
                    //     decoration: InputDecoration(
                    //         contentPadding: EdgeInsets.only(
                    //           top: 10,
                    //         ),
                    //         border:
                    //             OutlineInputBorder(borderSide: BorderSide.none),
                    //         hintText: type_cost),
                    //   ),
                    // ),
                    // Visibility(
                    //   visible: false,
                    //   child: Column(
                    //     children: [

                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 230),
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Color(0xFFCDCFD0)))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: false,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              subtotal2,
                              style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              subTotal.toString(),
                              style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: enableSave == true && widget.isFromUpdate == false
                          ? () {
                              saveSparePart(
                                  qtyUsed.toString(), costRpController.text);
                            }
                          : enableSave == true && widget.isFromUpdate == true
                              ? () {
                                  saveUpdatePart();
                                }
                              : null,
                      child: Container(
                        margin: const EdgeInsets.only(top: 8),
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        decoration: BoxDecoration(
                            color: enableSave == false
                                ? Color(0xFF979C9E)
                                : Color(0xFF00AEDB),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Center(
                          child: Text(
                            save_sparepart,
                            style: TextStyle(
                                fontFamily: 'Rubik',
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
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
