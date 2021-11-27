// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations

import 'package:e_cm/homepage/home/model/partitemmachinemodel.dart';
import 'package:e_cm/homepage/home/services/apifillsteptujuhformpage.dart';
import 'package:e_cm/homepage/home/services/partitemmachineservice.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddItemFillTujuh extends StatefulWidget {
  const AddItemFillTujuh({Key? key}) : super(key: key);

  @override
  _AddItemFillTujuhState createState() => _AddItemFillTujuhState();
}

class _AddItemFillTujuhState extends State<AddItemFillTujuh> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  TextEditingController partNameController = TextEditingController();
  TextEditingController costRpController = TextEditingController();

  List<PartItemMachineModel> listItemMachineData = [];

  bool isTapPartItemMachineInput = false;
  bool enableSave = false;
  int qtyStock = 0;
  int qtyUsed = 0;
  int subTotal = 0;

  Future<List> getPartItembyMacchine() async {
    final prefs = await _prefs;
    String tokenUser = prefs.getString("tokenKey").toString();
    String idEcmKey = prefs.getString("idEcm") ?? "";

    listItemMachineData =
        await partItemMachineService.getPartItemMachine(tokenUser, idEcmKey);

    return await partItemMachineService.getPartItemMachine(tokenUser, idEcmKey);
  }

  saveSparePart(String qtyUsed, String costRp) async {
    final prefs = await _prefs;
    String tokenUser = prefs.getString("tokenKey").toString();
    String? idEcmKey = prefs.getString("idEcm");
    var idPartMachine = prefs.getString("idPartItemMachine");

    try {
      var result = await saveDataPartMachine(
          tokenUser, idEcmKey!, idPartMachine!, qtyUsed, costRp);
      if (result['response']['status'] == 200) {
        Navigator.of(context).pop(true);
      } else {
        Fluttertoast.showToast(
          msg: 'Data gagal disimpan',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.greenAccent,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Terjadi kesalahan, periksa koneksi Anda',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.greenAccent,
      );
    }
  }

  @override
  void initState() {
    getPartItembyMacchine();
    super.initState();
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
                              text: 'Part Name',
                              style: TextStyle(color: Color(0xFF404446))),
                          TextSpan(
                              text: ' * ', style: TextStyle(color: Colors.red)),
                          TextSpan(
                              text: ':',
                              style: TextStyle(color: Color(0xFF404446))),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF979C9E)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    child: TextFormField(
                      controller: partNameController,
                      onTap: () {
                        setState(() {
                          isTapPartItemMachineInput =
                              !isTapPartItemMachineInput;
                        });
                      },
                      style: const TextStyle(
                          fontFamily: 'Rubik',
                          color: Color(0xFF404446),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal),
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(top: 10, left: 10),
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          hintText: 'Type Item Name'),
                    ),
                  ),
                  isTapPartItemMachineInput == false
                      ? Container()
                      : Container(
                          margin: const EdgeInsets.only(top: 5),
                          width: MediaQuery.of(context).size.width,
                          child: FutureBuilder(
                            future: getPartItembyMacchine(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: Text("Loading part item machine..."),
                                );
                              }

                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: listItemMachineData.isEmpty
                                    ? 0
                                    : listItemMachineData.length,
                                itemBuilder: (context, i) {
                                  return InkWell(
                                    onTap: () async {
                                      final prefs = await _prefs;
                                      setState(() {
                                        double stock = double.parse(
                                            listItemMachineData[i].partStock);
                                        qtyStock = stock.toInt();
                                        partNameController =
                                            TextEditingController(
                                                text: listItemMachineData[i]
                                                    .partNama);
                                        costRpController =
                                            TextEditingController(
                                                text: listItemMachineData[i]
                                                    .partHarga
                                                    .toString());
                                      });
                                      prefs.setString("idPartItemMachine",
                                          listItemMachineData[i].partitemId);
                                    },
                                    child: Container(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                            listItemMachineData[i].partNama)),
                                  );
                                },
                              );
                            },
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
                                  text: 'Quantity (Used)',
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
                                  int costRp = int.parse(costRpController.text);
                                  setState(() {
                                    qtyUsed != 0 ? qtyUsed-- : null;
                                    subTotal = costRp * qtyUsed;
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
                                  int costRp = int.parse(costRpController.text);
                                  setState(() {
                                    qtyUsed++;
                                    subTotal = costRp * qtyUsed;
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
                                  text: 'Quantity (Stock)',
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
                              SizedBox(
                                width: 30,
                                height: 30,
                                child: Icon(
                                  Icons.remove,
                                  color: Color(0xFF979C9E),
                                ),
                              ),
                              Text(qtyStock.toString(),
                                  style: TextStyle(
                                      color: Color(0xFF404446),
                                      fontFamily: 'Rubik',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700)),
                              SizedBox(
                                width: 30,
                                height: 30,
                                child: Icon(
                                  Icons.add,
                                  color: Color(0xFF20519F),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
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
                              text: 'Cost (Rp)',
                              style: TextStyle(color: Color(0xFF404446))),
                          TextSpan(
                              text: ' * ', style: TextStyle(color: Colors.red)),
                          TextSpan(
                              text: ':',
                              style: TextStyle(color: Color(0xFF404446))),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF979C9E)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    child: TextFormField(
                      controller: costRpController,
                      style: const TextStyle(
                          fontFamily: 'Rubik',
                          color: Color(0xFF404446),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal),
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(top: 10, left: 10),
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          hintText: 'Type the cost'),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Color(0xFFCDCFD0)))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sub Total (Rp) :",
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
                  InkWell(
                    onTap: enableSave == true
                        ? () {
                            saveSparePart(
                                qtyUsed.toString(), costRpController.text);
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
                          "Save Spare part",
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
    );
  }
}
