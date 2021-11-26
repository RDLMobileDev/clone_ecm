// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, avoid_unnecessary_containers, avoid_print, prefer_const_literals_to_create_immutables, invalid_use_of_visible_for_testing_member

import 'dart:convert';
import 'dart:io';

import 'package:e_cm/homepage/home/services/apifillnewdua.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StepFillDua extends StatefulWidget {
  final StepFillDuaState stepFillDuaState = StepFillDuaState();

  void getSaveFillDua() {
    stepFillDuaState.saveStepFillDua();
  }

  @override
  StepFillDuaState createState() => StepFillDuaState();
}

class StepFillDuaState extends State<StepFillDua> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final ImagePicker imagePicker = ImagePicker();
  TextEditingController? timePickController;

  List<XFile>? imageFileList = [];
  List<File>? imageFileListCamera = [];
  // List<String> imageProblemName = [];
  List<String> imageProblemPath = [];

  String shiftA = '', shiftB = '', shiftC = '';
  String safetyOpt = '', qualityOpt = '', deliveryOpt = '', costOpt = '';
  String moldingOpt = '',
      utilityOpt = '',
      productionOpt = '',
      engineerOpt = '',
      otherOpt = '';
  String? incidentGroup;
  String? problemTypeGroup;
  String? percentageMistakeGroup;

  String incidentState = '',
      timePickState = '',
      problemTypeState = '',
      typeMistakeState = '',
      percentageState = '';

  bool isShiftA = false, isShiftB = false, isShiftC = false;
  bool isSafety = false, isQuality = false, isDelivery = false, isCost = false;
  bool isMolding = false,
      isUtility = false,
      isProduction = false,
      isEngineering = false,
      isOther = false;

  final DateTime now = DateTime.now();

  void getTime() async {
    final prefs = await _prefs;
    MaterialLocalizations localizations = MaterialLocalizations.of(context);

    showTimePicker(
            context: context,
            initialTime: TimeOfDay(hour: now.hour, minute: now.minute))
        .then((value) {
      String formattedTime =
          localizations.formatTimeOfDay(value!, alwaysUse24HourFormat: true);
      setState(() {
        timePickController = TextEditingController(text: formattedTime);
      });
      prefs.setString("timePickState", formattedTime);
    });
  }

  void selectImagesGallery() async {
    final prefs = await _prefs;
    if (imageFileList!.length < 4) {
      try {
        final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
        if (selectedImages!.isNotEmpty && selectedImages.length <= 4) {
          setState(() {
            imageFileList!.addAll(selectedImages);
          });

          for (int i = 0; i < selectedImages.length; i++) {
            imageProblemPath.add(selectedImages[i].path);
          }
          prefs.setStringList("imagesKetPath", imageProblemPath);
        } else if (selectedImages.length > 4) {
          Fluttertoast.showToast(
              msg: "Tidak boleh melebihi 4 foto",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Color(0xFF00AEDB),
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          imageFileList!.clear();
          Fluttertoast.showToast(
              msg: "Tidak boleh melebihi 4 foto",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Color(0xFF00AEDB),
              textColor: Colors.white,
              fontSize: 16.0);
        }

        print("Image List Length:" + imageFileList!.length.toString());
        setState(() {});
        Navigator.of(context).pop();
      } catch (e) {
        Fluttertoast.showToast(
            msg: "Foto tidak dipilih",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color(0xFF00AEDB),
            textColor: Colors.white,
            fontSize: 16.0);
        print(e);
      }
    } else {
      setState(() {
        Fluttertoast.showToast(
            msg: "Maksimal 4 foto",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color(0xFF00AEDB),
            textColor: Colors.white,
            fontSize: 16.0);
      });
    }
  }

  void selectImageCamera() async {
    if (imageFileList!.length < 4) {
      try {
        final XFile? selectedImages =
            await imagePicker.pickImage(source: ImageSource.camera);
        if (selectedImages != null) {
          imageFileList!.add(selectedImages);
        } else {
          imageFileList!.clear();
          Fluttertoast.showToast(
              msg: "Tidak boleh melebihi 4 foto",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Color(0xFF00AEDB),
              textColor: Colors.white,
              fontSize: 16.0);
        }

        print("Image List Length:" + imageFileList!.length.toString());
        setState(() {});

        Navigator.of(context).pop();
      } catch (e) {
        Fluttertoast.showToast(
            msg: "Foto tidak dipilih",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color(0xFF00AEDB),
            textColor: Colors.white,
            fontSize: 16.0);
        print(e);
      }
    } else {
      setState(() {
        Fluttertoast.showToast(
            msg: "Maksimal 4 foto",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color(0xFF00AEDB),
            textColor: Colors.white,
            fontSize: 16.0);
      });
    }
  }

  void saveStepFillDua() async {
    final prefs = await _prefs;
    String tokenUser = prefs.getString("tokenKey").toString();
    var idEcmKey = prefs.getString("idEcm");
    var shiftAkey = prefs.getString("shiftA");
    var shiftBkey = prefs.getString("shiftB");
    var shiftCkey = prefs.getString("shiftC");

    var safetyOptKey = prefs.getString("safetyOpt");
    var qualityOptKey = prefs.getString("qualityOpt");
    var deliveryOptKey = prefs.getString("deliveryOpt");
    var costOptKey = prefs.getString("costOpt");

    var moldingOptKey = prefs.getString("moldingOpt");
    var utilityOptKey = prefs.getString("utilityOpt");
    var productionOptKey = prefs.getString("productionOpt");
    var engineerOptKey = prefs.getString("engineerOpt");
    var otherOptKey = prefs.getString("otherOpt");

    var problemTypeState = prefs.getString("problemTypeState");
    var imagesKeyName = prefs.getStringList("imagesKeyName");
    var imagesKetPath = prefs.getStringList("imagesKetPath");
    var timePickState = prefs.getString("timePickState");

    // print(files.length);

    var result = await fillNewDua(
      token: tokenUser,
      shiftA: shiftAkey!,
      shiftB: shiftBkey!,
      shiftNs: shiftCkey!,
      time: timePickState!,
      problem: problemTypeState!,
      safety: safetyOptKey!,
      quality: qualityOptKey!,
      delivery: deliveryOptKey!,
      cost: costOptKey!,
      molding: moldingOptKey!,
      utility: utilityOptKey!,
      production: productionOptKey!,
      engineering: engineerOptKey!,
      other: otherOptKey!,
      ecmId: idEcmKey!,
      // images: files
      // imagesName: imagesKeyName,
      imagesPath: imagesKetPath,
    );

    print(result);
  }

  void goToStepFillTiga() {
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
    print("step 2 init");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: RichText(
                text: TextSpan(
                  text: 'Incident ',
                  style: TextStyle(
                      fontFamily: 'Rubik',
                      color: Color(0xFF404446),
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                  children: const <TextSpan>[
                    TextSpan(
                        text: '*',
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 16,
                            color: Colors.red,
                            fontWeight: FontWeight.w400)),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        // isShiftA = !isShiftA;
                        // shiftA = 'Shift A';
                        incidentGroup = '1';
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      height: 40,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFF979C9E)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: 30,
                              height: 30,
                              child: Radio(
                                  groupValue: incidentGroup,
                                  value: '1',
                                  onChanged: (value) async {
                                    final prefs = await _prefs;
                                    if (value != null) {
                                      setState(() {
                                        incidentGroup = value as String;
                                        shiftA = '1';
                                        shiftB = '0';
                                        shiftC = '0';
                                      });
                                      prefs.setString("shiftA", shiftA);
                                      prefs.setString("shiftB", shiftB);
                                      prefs.setString("shiftC", shiftC);
                                    }
                                  })),
                          const Text("Shift A")
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        // isShiftB = !isShiftB;
                        // shiftB = 'Shift B';
                        incidentGroup = '2';
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      height: 40,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFF979C9E)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: 30,
                              height: 30,
                              child: Radio(
                                  groupValue: incidentGroup,
                                  value: '2',
                                  onChanged: (value) async {
                                    final prefs = await _prefs;
                                    if (value != null) {
                                      setState(() {
                                        incidentGroup = value as String;
                                        shiftA = '0';
                                        shiftB = '1';
                                        shiftC = '0';
                                      });
                                      prefs.setString("shiftA", shiftA);
                                      prefs.setString("shiftB", shiftB);
                                      prefs.setString("shiftC", shiftC);
                                    }
                                  })),
                          const Text("Shift B")
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        // isShiftC = !isShiftC;
                        // shiftC = 'Shift C';
                        incidentGroup = '3';
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      height: 40,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFF979C9E)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: 30,
                              height: 30,
                              child: Radio(
                                  groupValue: incidentGroup,
                                  value: '3',
                                  onChanged: (value) async {
                                    final prefs = await _prefs;
                                    if (value != null) {
                                      setState(() {
                                        incidentGroup = value as String;
                                        shiftA = '0';
                                        shiftB = '0';
                                        shiftC = '1';
                                      });
                                      prefs.setString("shiftA", shiftA);
                                      prefs.setString("shiftB", shiftB);
                                      prefs.setString("shiftC", shiftC);
                                    }
                                  })),
                          const Text("Shift C")
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              padding: const EdgeInsets.all(5),
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF979C9E)),
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: TextFormField(
                controller: timePickController,
                onTap: () => getTime(),
                style: const TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    prefixIcon: Icon(Icons.access_time),
                    suffixIcon: Icon(Icons.arrow_drop_down),
                    hintText: 'HH:MM',
                    contentPadding: EdgeInsets.all(5),
                    hintStyle: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              padding: const EdgeInsets.all(5),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF979C9E)),
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: TextFormField(
                maxLines: 5,
                onChanged: (value) async {
                  final prefs = await _prefs;
                  prefs.setString("problemTypeState", value);
                },
                style: const TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: 'Type the problem'),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => setState(() {
                      isSafety = !isSafety;
                      safetyOpt = 'Safety';
                    }),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.40,
                      height: 40,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFF979C9E)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: 30,
                              height: 30,
                              child: Radio(
                                  groupValue: problemTypeGroup,
                                  value: '1',
                                  onChanged: (value) async {
                                    final prefs = await _prefs;
                                    if (value != null) {
                                      setState(() {
                                        problemTypeGroup = value as String;
                                        safetyOpt = '1';
                                        qualityOpt = '0';
                                        deliveryOpt = '0';
                                        costOpt = '0';
                                      });
                                      prefs.setString("safetyOpt", safetyOpt);
                                      prefs.setString("qualityOpt", qualityOpt);
                                      prefs.setString(
                                          "deliveryOpt", deliveryOpt);
                                      prefs.setString("costOpt", costOpt);
                                    }
                                  })),
                          const Text(
                            "Safety",
                            style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF72777A),
                                fontStyle: FontStyle.normal),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => setState(() {
                      isQuality = !isQuality;
                      qualityOpt = 'Quality';
                    }),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.40,
                      height: 40,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFF979C9E)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: 30,
                              height: 30,
                              child: Radio(
                                  groupValue: problemTypeGroup,
                                  value: '2',
                                  onChanged: (value) async {
                                    final prefs = await _prefs;
                                    if (value != null) {
                                      setState(() {
                                        problemTypeGroup = value as String;
                                        safetyOpt = '0';
                                        qualityOpt = '1';
                                        deliveryOpt = '0';
                                        costOpt = '0';
                                      });
                                      prefs.setString("safetyOpt", safetyOpt);
                                      prefs.setString("qualityOpt", qualityOpt);
                                      prefs.setString(
                                          "deliveryOpt", deliveryOpt);
                                      prefs.setString("costOpt", costOpt);
                                    }
                                  })),
                          const Text(
                            "Quality",
                            style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF72777A),
                                fontStyle: FontStyle.normal),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () => setState(() {
                isDelivery = !isDelivery;
                deliveryOpt = 'Delivery';
              }),
              child: Container(
                margin: const EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.40,
                      height: 40,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFF979C9E)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: 30,
                              height: 30,
                              child: Radio(
                                  groupValue: problemTypeGroup,
                                  value: '3',
                                  onChanged: (value) async {
                                    final prefs = await _prefs;
                                    if (value != null) {
                                      setState(() {
                                        problemTypeGroup = value as String;
                                        safetyOpt = '0';
                                        qualityOpt = '0';
                                        deliveryOpt = '1';
                                        costOpt = '0';
                                      });
                                      prefs.setString("safetyOpt", safetyOpt);
                                      prefs.setString("qualityOpt", qualityOpt);
                                      prefs.setString(
                                          "deliveryOpt", deliveryOpt);
                                      prefs.setString("costOpt", costOpt);
                                    }
                                  })),
                          const Text(
                            "Delivery",
                            style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF72777A),
                                fontStyle: FontStyle.normal),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () => setState(() {
                        isCost = !isCost;
                        costOpt = 'Cost';
                      }),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.40,
                        height: 40,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFF979C9E)),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                                width: 30,
                                height: 30,
                                child: Radio(
                                    groupValue: problemTypeGroup,
                                    value: '4',
                                    onChanged: (value) async {
                                      final prefs = await _prefs;
                                      if (value != null) {
                                        setState(() {
                                          problemTypeGroup = value as String;
                                          safetyOpt = '0';
                                          qualityOpt = '0';
                                          deliveryOpt = '0';
                                          costOpt = '1';
                                        });
                                        prefs.setString("safetyOpt", safetyOpt);
                                        prefs.setString(
                                            "qualityOpt", qualityOpt);
                                        prefs.setString(
                                            "deliveryOpt", deliveryOpt);
                                        prefs.setString("costOpt", costOpt);
                                      }
                                    })),
                            const Text(
                              "Cost",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF72777A),
                                  fontStyle: FontStyle.normal),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: RichText(
                text: TextSpan(
                  text: 'Percentage Mistake ',
                  style: TextStyle(
                      fontFamily: 'Rubik',
                      color: Color(0xFF404446),
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                  children: const <TextSpan>[
                    TextSpan(
                        text: '*',
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 16,
                            color: Colors.red,
                            fontWeight: FontWeight.w400)),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => setState(() {
                      isMolding = !isMolding;
                      moldingOpt = 'Molding';
                    }),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.40,
                      height: 40,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFF979C9E)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: 30,
                              height: 30,
                              child: Radio(
                                  groupValue: percentageMistakeGroup,
                                  value: '1',
                                  onChanged: (value) async {
                                    final prefs = await _prefs;
                                    if (value != null) {
                                      setState(() {
                                        percentageMistakeGroup =
                                            value as String;
                                        moldingOpt = '1';
                                        utilityOpt = '0';
                                        productionOpt = '0';
                                        engineerOpt = '0';
                                        otherOpt = '0';
                                      });
                                      prefs.setString("moldingOpt", moldingOpt);
                                      prefs.setString("utilityOpt", utilityOpt);
                                      prefs.setString(
                                          "productionOpt", productionOpt);
                                      prefs.setString(
                                          "engineerOpt", engineerOpt);
                                      prefs.setString("otherOpt", otherOpt);
                                    }
                                  })),
                          const Text(
                            "Molding",
                            style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF72777A),
                                fontStyle: FontStyle.normal),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => setState(() {
                      isUtility = !isUtility;
                      utilityOpt = 'Utility';
                    }),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.40,
                      height: 40,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFF979C9E)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: 30,
                              height: 30,
                              child: Radio(
                                  groupValue: percentageMistakeGroup,
                                  value: '2',
                                  onChanged: (value) async {
                                    final prefs = await _prefs;
                                    if (value != null) {
                                      setState(() {
                                        percentageMistakeGroup =
                                            value as String;
                                        moldingOpt = '0';
                                        utilityOpt = '1';
                                        productionOpt = '0';
                                        engineerOpt = '0';
                                        otherOpt = '0';
                                      });
                                      prefs.setString("moldingOpt", moldingOpt);
                                      prefs.setString("utilityOpt", utilityOpt);
                                      prefs.setString(
                                          "productionOpt", productionOpt);
                                      prefs.setString(
                                          "engineerOpt", engineerOpt);
                                      prefs.setString("otherOpt", otherOpt);
                                    }
                                  })),
                          const Text(
                            "Utility",
                            style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF72777A),
                                fontStyle: FontStyle.normal),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () => setState(() {
                isProduction = !isProduction;
                productionOpt = 'Production';
              }),
              child: Container(
                margin: const EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.40,
                      height: 40,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFF979C9E)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: 30,
                              height: 30,
                              child: Radio(
                                  groupValue: percentageMistakeGroup,
                                  value: '3',
                                  onChanged: (value) async {
                                    final prefs = await _prefs;
                                    if (value != null) {
                                      setState(() {
                                        percentageMistakeGroup =
                                            value as String;
                                        moldingOpt = '0';
                                        utilityOpt = '0';
                                        productionOpt = '1';
                                        engineerOpt = '0';
                                        otherOpt = '0';
                                      });
                                      prefs.setString("moldingOpt", moldingOpt);
                                      prefs.setString("utilityOpt", utilityOpt);
                                      prefs.setString(
                                          "productionOpt", productionOpt);
                                      prefs.setString(
                                          "engineerOpt", engineerOpt);
                                      prefs.setString("otherOpt", otherOpt);
                                    }
                                  })),
                          const Text(
                            "Production",
                            style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF72777A),
                                fontStyle: FontStyle.normal),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () => setState(() {
                        isEngineering = !isEngineering;
                        engineerOpt = 'Engineering';
                      }),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.40,
                        height: 40,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFF979C9E)),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                                width: 30,
                                height: 30,
                                child: Radio(
                                    groupValue: percentageMistakeGroup,
                                    value: '4',
                                    onChanged: (value) async {
                                      final prefs = await _prefs;
                                      if (value != null) {
                                        setState(() {
                                          percentageMistakeGroup =
                                              value as String;
                                          moldingOpt = '0';
                                          utilityOpt = '0';
                                          productionOpt = '0';
                                          engineerOpt = '1';
                                          otherOpt = '0';
                                        });
                                        prefs.setString(
                                            "moldingOpt", moldingOpt);
                                        prefs.setString(
                                            "utilityOpt", utilityOpt);
                                        prefs.setString(
                                            "productionOpt", productionOpt);
                                        prefs.setString(
                                            "engineerOpt", engineerOpt);
                                        prefs.setString("otherOpt", otherOpt);
                                      }
                                    })),
                            const Text(
                              "Engineering",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF72777A),
                                  fontStyle: FontStyle.normal),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () => setState(() {
                isOther = !isOther;
                otherOpt = 'Other';
              }),
              child: Container(
                margin: const EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.40,
                      height: 40,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFF979C9E)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: 30,
                              height: 30,
                              child: Radio(
                                  groupValue: percentageMistakeGroup,
                                  value: '5',
                                  onChanged: (value) async {
                                    final prefs = await _prefs;
                                    if (value != null) {
                                      setState(() {
                                        percentageMistakeGroup =
                                            value as String;
                                        moldingOpt = '0';
                                        utilityOpt = '0';
                                        productionOpt = '0';
                                        engineerOpt = '0';
                                        otherOpt = '1';
                                      });
                                      prefs.setString("moldingOpt", moldingOpt);
                                      prefs.setString("utilityOpt", utilityOpt);
                                      prefs.setString(
                                          "productionOpt", productionOpt);
                                      prefs.setString(
                                          "engineerOpt", engineerOpt);
                                      prefs.setString("otherOpt", otherOpt);
                                    }
                                  })),
                          const Text(
                            "Other",
                            style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF72777A),
                                fontStyle: FontStyle.normal),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: RichText(
                text: TextSpan(
                  text: 'Picture and Analysis ',
                  style: TextStyle(
                      fontFamily: 'Rubik',
                      color: Color(0xFF404446),
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                  children: const <TextSpan>[
                    TextSpan(
                        text: '*',
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 16,
                            color: Colors.red,
                            fontWeight: FontWeight.w400)),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                showBottomSheet(
                    context: context,
                    builder: (context) {
                      return optionPickImage(context);
                    });
              },
              child: Container(
                margin: const EdgeInsets.only(top: 4),
                padding: const EdgeInsets.all(10),
                height: 120,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFF979C9E)),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                child: imageFileList!.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Icon(
                            Icons.add_a_photo,
                            color: Color(0xFF979C9E),
                            size: 50,
                          ),
                          Text(
                            "Tap to add, max 4 photo",
                            style: const TextStyle(
                                color: Color(0xFF979C9E),
                                fontSize: 14,
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      )
                    : GridView.builder(
                        itemCount: imageFileList!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 8),
                            child: Row(
                              children: [
                                Image.file(
                                  File(imageFileList![index].path),
                                  fit: BoxFit.cover,
                                  width: 80,
                                ),
                                SizedBox(
                                  width: 5,
                                )
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget optionPickImage(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2),
      width: MediaQuery.of(context).size.width,
      height: 280,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 35),
            width: MediaQuery.of(context).size.width,
            child: Center(child: Text("Select image use")),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () => selectImageCamera(),
                  child: Container(
                    width: 105,
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/camera.png",
                          width: 60,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text("Camera")
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => selectImagesGallery(),
                  child: Container(
                    width: 105,
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/gallery 1.png",
                          width: 60,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text("Gallery")
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
