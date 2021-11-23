// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, avoid_unnecessary_containers, avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class StepFillDua extends StatefulWidget {
  final StepFillDuaState stepFillDuaState = StepFillDuaState();

  void getSaveFillDua() {
    stepFillDuaState.saveStepFillDua();
  }

  @override
  StepFillDuaState createState() => StepFillDuaState();
}

class StepFillDuaState extends State<StepFillDua> {
  final ImagePicker imagePicker = ImagePicker();
  TextEditingController? timePickController;

  List<XFile>? imageFileList = [];

  String shiftA = '', shiftB = '', shiftC = '';
  String safetyOpt = '', qualityOpt = '', deliveryOpt = '', costOpt = '';
  String moldingOpt = '',
      utilityOpt = '',
      productionOpt = '',
      engineerOpt = '',
      otherOpt = '';

  bool isShiftA = false, isShiftB = false, isShiftC = false;
  bool isSafety = false, isQuality = false, isDelivery = false, isCost = false;
  bool isMolding = false,
      isUtility = false,
      isProduction = false,
      isEngineering = false,
      isOther = false;

  final DateTime now = DateTime.now();

  void getTime() {
    showTimePicker(
            context: context,
            initialTime: TimeOfDay(hour: now.hour, minute: now.minute))
        .then((value) {
      setState(() {
        timePickController =
            TextEditingController(text: value!.format(context));
      });
    });
  }

  void selectImages() async {
    try {
      final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
      if (selectedImages!.isNotEmpty) {
        imageFileList!.addAll(selectedImages);
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
    } catch (e) {
      print(e);
    }
  }

  void saveStepFillDua() {
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
                        isShiftA = !isShiftA;
                        shiftA = 'Shift A';
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
                              child: Checkbox(
                                  value: isShiftA,
                                  onChanged: (value) {
                                    if (value != null) {
                                      setState(() {
                                        isShiftA = value;
                                        shiftA = 'Shift A';
                                      });
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
                        isShiftB = !isShiftB;
                        shiftB = 'Shift B';
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
                              child: Checkbox(
                                  value: isShiftB,
                                  onChanged: (value) {
                                    if (value != null) {
                                      setState(() {
                                        isShiftB = value;
                                        shiftB = 'Shift B';
                                      });
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
                        isShiftC = !isShiftC;
                        shiftC = 'Shift C';
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
                              child: Checkbox(
                                  value: isShiftC,
                                  onChanged: (value) {
                                    if (value != null) {
                                      setState(() {
                                        isShiftC = value;
                                        shiftC = 'Shift C';
                                      });
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
                              child: Checkbox(
                                  value: isSafety,
                                  onChanged: (value) {
                                    setState(() {
                                      isSafety = !isSafety;
                                      safetyOpt = 'Safety';
                                    });
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
                              child: Checkbox(
                                  value: isQuality,
                                  onChanged: (value) {
                                    setState(() {
                                      isQuality = !isQuality;
                                      qualityOpt = 'Quality';
                                    });
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
                              child: Checkbox(
                                  value: isDelivery,
                                  onChanged: (value) {
                                    setState(() {
                                      isDelivery = !isDelivery;
                                      deliveryOpt = 'Delivery';
                                    });
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
                                child: Checkbox(
                                    value: isCost,
                                    onChanged: (value) {
                                      setState(() {
                                        isCost = !isCost;
                                        costOpt = 'Cost';
                                      });
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
                              child: Checkbox(
                                  value: isMolding,
                                  onChanged: (value) {
                                    setState(() {
                                      isMolding = !isMolding;
                                      moldingOpt = 'Molding';
                                    });
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
                              child: Checkbox(
                                  value: isUtility,
                                  onChanged: (value) {
                                    setState(() {
                                      isUtility = !isUtility;
                                      utilityOpt = 'Utility';
                                    });
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
                              child: Checkbox(
                                  value: isProduction,
                                  onChanged: (value) {
                                    setState(() {
                                      isProduction = !isProduction;
                                      productionOpt = 'Production';
                                    });
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
                                child: Checkbox(
                                    value: isEngineering,
                                    onChanged: (value) {
                                      setState(() {
                                        isEngineering = !isEngineering;
                                        engineerOpt = 'Engineering';
                                      });
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
                              child: Checkbox(
                                  value: isOther,
                                  onChanged: (value) {
                                    setState(() {
                                      isOther = !isOther;
                                      otherOpt = 'Other';
                                    });
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
              onTap: () => selectImages(),
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
}
