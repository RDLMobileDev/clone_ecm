// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, avoid_unnecessary_containers, avoid_print, prefer_const_literals_to_create_immutables, invalid_use_of_visible_for_testing_member

import 'dart:convert';
import 'dart:io';

import 'package:e_cm/homepage/home/services/apifillnewdua.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  String bahasa = "Bahasa Indonesia";
  bool bahasaSelected = false;

  String incident = '';
  String shift_a = '';
  String shift_b = '';
  String shift_ns = '';
  String hm = '';

  String type_problem = '';
  String safety = '';
  String quality = '';
  String delivery = '';
  String cost = '';
  String percentage = '';
  String utility = '';

  String molding = '';
  String production = '';
  String engineering = '';
  String other = '';
  String picture = '';

  String addmax = '';
  String select_image = '';
  String gallery = '';
  String camera = '';
  String crop = '';
  String addmore = '';
  String picture_analis = '';

  String checkKlasifikasiType = "";

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
        incident = dataLang['step_2']['incident'];
        shift_a = dataLang['step_2']['shift_a'];
        shift_b = dataLang['step_2']['shift_b'];
        shift_ns = dataLang['step_2']['shift_ns'];
        hm = dataLang['step_2']['hm'];
        type_problem = dataLang['step_2']['type_problem'];
        safety = dataLang['step_2']['safety'];
        quality = dataLang['step_2']['quality'];
        delivery = dataLang['step_2']['delivery'];
        cost = dataLang['step_2']['cost'];

        percentage = dataLang['step_2']['percentage'];
        utility = dataLang['step_2']['utility'];
        molding = dataLang['step_2']['molding'];
        production = dataLang['step_2']['production'];
        engineering = dataLang['step_2']['engineering'];
        other = dataLang['step_2']['other'];
        picture_analis = dataLang['step_2']['picture'];
        addmax = dataLang['step_2']['addmax'];
        select_image = dataLang['step_2']['select_image'];
        gallery = dataLang['step_2']['gallery'];
        camera = dataLang['step_2']['camera'];
        crop = dataLang['step_2']['crop'];
        addmore = dataLang['step_2']['add_more'];
        // picture = dataLang['step_2']['picture'];
      });
    }
  }

  void getLanguageId() async {
    var response = await rootBundle.loadString("assets/lang/lang-id.json");
    var dataLang = json.decode(response)['data'];

    if (mounted) {
      setState(() {});
      incident = dataLang['step_2']['incident'];
      shift_a = dataLang['step_2']['shift_a'];
      shift_b = dataLang['step_2']['shift_b'];
      shift_ns = dataLang['step_2']['shift_ns'];
      hm = dataLang['step_2']['hm'];
      type_problem = dataLang['step_2']['type_problem'];
      safety = dataLang['step_2']['safety'];
      quality = dataLang['step_2']['quality'];
      delivery = dataLang['step_2']['delivery'];
      cost = dataLang['step_2']['cost'];

      percentage = dataLang['step_2']['percentage'];
      utility = dataLang['step_2']['utility'];
      molding = dataLang['step_2']['molding'];
      production = dataLang['step_2']['production'];
      engineering = dataLang['step_2']['engineering'];
      other = dataLang['step_2']['other'];
      picture_analis = dataLang['step_2']['picture'];
      addmax = dataLang['step_2']['addmax'];
      select_image = dataLang['step_2']['select_image'];
      gallery = dataLang['step_2']['gallery'];
      camera = dataLang['step_2']['camera'];
      crop = dataLang['step_2']['crop'];
      addmore = dataLang['step_2']['add_more'];
      // picture = dataLang['step_2']['picture'];
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

  final ImagePicker imagePicker = ImagePicker();
  TextEditingController? timePickController;
  TextEditingController problemTypeController = TextEditingController();

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
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(
                // Using 24-Hour format
                alwaysUse24HourFormat: true),
            // If you want 12-Hour format, just change alwaysUse24HourFormat to false or remove all the builder argument
            child: child!);
      },
    ).then((value) {
      String formattedTime =
          localizations.formatTimeOfDay(value!, alwaysUse24HourFormat: true);
      setState(() {
        timePickController = TextEditingController(text: formattedTime);
      });
      prefs.setString("timePickState", formattedTime);
      prefs.setString("timeBool", "1");
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
          prefs.setString("imageUploadBool", "1");
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
    final prefs = await _prefs;
    if (imageFileList!.length < 4) {
      try {
        final XFile? selectedImages =
            await imagePicker.pickImage(source: ImageSource.camera);
        if (selectedImages != null) {
          imageFileList!.add(selectedImages);

          imageProblemPath.add(selectedImages.path);
          prefs.setStringList("imagesKetPath", imageProblemPath);
          prefs.setString("imageUploadBool", "1");
        } else {
          // imageFileList!.clear();
          Fluttertoast.showToast(
              msg: "Foto tidak dipilih",
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
    var idEcmKey = prefs.getString("idEcm") ?? "";
    var shiftAkey = prefs.getString("shiftA") ?? "";
    var shiftBkey = prefs.getString("shiftB") ?? "";
    var shiftCkey = prefs.getString("shiftC") ?? "";

    var safetyOptKey = prefs.getString("safetyOpt") ?? "";
    var qualityOptKey = prefs.getString("qualityOpt") ?? "";
    var deliveryOptKey = prefs.getString("deliveryOpt") ?? "";
    var costOptKey = prefs.getString("costOpt") ?? "";

    var moldingOptKey = prefs.getString("moldingOpt") ?? "";
    var utilityOptKey = prefs.getString("utilityOpt") ?? "";
    var productionOptKey = prefs.getString("productionOpt") ?? "";
    var engineerOptKey = prefs.getString("engineerOpt") ?? "";
    var otherOptKey = prefs.getString("otherOpt") ?? "";

    var problemTypeState = prefs.getString("problemTypeState") ?? "";
    // var imagesKeyName = prefs.getStringList("imagesKeyName");
    var imagesKetPath = prefs.getStringList("imagesKetPath") ?? [];
    var timePickState = prefs.getString("timePickState") ?? "";

    // print(files.length);

    if (timePickState.isNotEmpty &&
        problemTypeState.isNotEmpty &&
        imagesKetPath.isNotEmpty) {
      var result = await fillNewDua(
        token: tokenUser,
        shiftA: shiftAkey,
        shiftB: shiftBkey,
        shiftNs: shiftCkey,
        time: timePickState,
        problem: problemTypeState,
        safety: safetyOptKey,
        quality: qualityOptKey,
        delivery: deliveryOptKey,
        cost: costOptKey,
        molding: moldingOptKey,
        utility: utilityOptKey,
        production: productionOptKey,
        engineering: engineerOptKey,
        other: otherOptKey,
        ecmId: idEcmKey,
        // images: files
        // imagesName: imagesKeyName,
        imagesPath: imagesKetPath,
      );

      print(result);

      goToStepFillTiga('Data step 2 Disimpan');
    } else {
      goToStepFillTiga('Data tidak disimpan, cek semua input field');
    }
  }

  void goToStepFillTiga(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.greenAccent,
        textColor: Colors.white,
        fontSize: 16);
  }

  void setFormStep2AfterChoosing() async {
    final prefs = await _prefs;

    String shiftA = prefs.getString("shiftA") ?? "";
    String shiftB = prefs.getString("shiftB") ?? "";
    String shiftC = prefs.getString("shiftC") ?? "";

    String? timePickState = prefs.getString("timePickState");
    String? problemTypeState = prefs.getString("problemTypeState");

    String safetyOpt = prefs.getString("safetyOpt") ?? "";
    String qualityOpt = prefs.getString("qualityOpt") ?? "";
    String deliveryOpt = prefs.getString("deliveryOpt") ?? "";
    String costOpt = prefs.getString("costOpt") ?? "";

    String moldingOpt = prefs.getString("moldingOpt") ?? "";
    String utilityOpt = prefs.getString("utilityOpt") ?? "";
    String productionOpt = prefs.getString("productionOpt") ?? "";
    String engineerOpt = prefs.getString("engineerOpt") ?? "";
    String otherOpt = prefs.getString("otherOpt") ?? "";
    List<String> imagesKetPath = prefs.getStringList("imagesKetPath") ?? [];

    // PERCENTAGE MISTAKE
    if (moldingOpt.isNotEmpty && moldingOpt != "" && moldingOpt == "1") {
      setState(() {
        isMolding = !isMolding;
      });
    }

    if (utilityOpt.isNotEmpty && utilityOpt != "" && utilityOpt == "1") {
      setState(() {
        isUtility = !isUtility;
      });
    }

    if (productionOpt.isNotEmpty &&
        productionOpt != "" &&
        productionOpt == "1") {
      setState(() {
        isProduction = !isProduction;
      });
    }

    if (engineerOpt.isNotEmpty && engineerOpt != "" && engineerOpt == "1") {
      setState(() {
        isEngineering = !isEngineering;
      });
    }

    if (otherOpt.isNotEmpty && otherOpt != "" && otherOpt == "1") {
      setState(() {
        isOther = !isOther;
      });
    }

    // PROBLEM TYPE
    if (safetyOpt.isNotEmpty && safetyOpt != "" && safetyOpt == "1") {
      setState(() {
        isSafety = !isSafety;
      });
    }

    if (qualityOpt.isNotEmpty && qualityOpt != "" && qualityOpt == "1") {
      setState(() {
        isQuality = !isQuality;
      });
    }

    if (deliveryOpt.isNotEmpty && deliveryOpt != "" && deliveryOpt == "1") {
      setState(() {
        isDelivery = !isDelivery;
      });
    }

    if (costOpt.isNotEmpty && costOpt != "" && costOpt == "1") {
      setState(() {
        isCost = !isCost;
      });
    }

    // SHIFT
    if (shiftA.isNotEmpty && shiftA != "" && shiftA == "1") {
      setState(() {
        incidentGroup = '1';
      });
    } else if (shiftB.isNotEmpty && shiftB != "" && shiftB == "1") {
      setState(() {
        incidentGroup = '2';
      });
    } else if (shiftC.isNotEmpty && shiftC != "" && shiftC == "1") {
      setState(() {
        incidentGroup = '3';
      });
    }

    if (imagesKetPath.isNotEmpty) {
      imageProblemPath.addAll(imagesKetPath);
    } else {
      print("asdjfghasdjk");
    }

    // TIME AND DESC PROBLEM
    if (timePickState != null && problemTypeState != null) {
      setState(() {
        timePickController = TextEditingController(text: timePickState);
        problemTypeController = TextEditingController(text: problemTypeState);
      });
    }
  }

  void checkKlasifikasiTypeValue() async {
    final prefs = await _prefs;

    String klasifikasiType = prefs.getString("namaKlasifikasi") ?? "";

    if (klasifikasiType != "" && klasifikasiType.isNotEmpty) {
      setState(() {
        checkKlasifikasiType = klasifikasiType;
      });
    }
  }

  @override
  void initState() {
    print("step 2 init");
    super.initState();
    setLang();
    setBahasa();
    setFormStep2AfterChoosing();
    checkKlasifikasiTypeValue();
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
                  text: incident,
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
                    onTap: () async {
                      final prefs = await _prefs;
                      setState(() {
                        incidentGroup = '1';
                        shiftA = '1';
                        shiftB = '0';
                        shiftC = '0';
                      });
                      prefs.setString("shiftA", shiftA);
                      prefs.setString("shiftB", shiftB);
                      prefs.setString("shiftC", shiftC);
                      prefs.setString("shiftBool", "1");
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.28,
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
                                      prefs.setString("shiftBool", "1");
                                    }
                                  })),
                          Text(shift_a)
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final prefs = await _prefs;
                      setState(() {
                        incidentGroup = '2';
                        shiftA = '0';
                        shiftB = '1';
                        shiftC = '0';
                      });
                      prefs.setString("shiftA", shiftA);
                      prefs.setString("shiftB", shiftB);
                      prefs.setString("shiftC", shiftC);
                      prefs.setString("shiftBool", "1");
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.28,
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
                                      prefs.setString(
                                          "insidenShift", incidentGroup!);
                                      prefs.setString("shiftBool", "1");
                                    }
                                  })),
                          Text(shift_b)
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final prefs = await _prefs;
                      setState(() {
                        incidentGroup = '3';
                        shiftA = '0';
                        shiftB = '0';
                        shiftC = '1';
                      });
                      prefs.setString("shiftA", shiftA);
                      prefs.setString("shiftB", shiftB);
                      prefs.setString("shiftC", shiftC);
                      prefs.setString("shiftBool", "1");
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.28,
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
                                      prefs.setString("shiftBool", "1");
                                    }
                                  })),
                          Text(shift_ns)
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
                decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    prefixIcon: Icon(Icons.access_time),
                    suffixIcon: Icon(Icons.arrow_drop_down),
                    hintText: hm,
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
                controller: problemTypeController,
                maxLines: 5,
                maxLength: 500,
                onChanged: (value) async {
                  final prefs = await _prefs;
                  prefs.setString("problemTypeState", value);
                  prefs.setString("ketikProblemBool", "1");
                },
                style: const TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: type_problem),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () async {
                      final prefs = await _prefs;
                      setState(() {
                        isSafety = !isSafety;
                        safetyOpt = '1';
                        // qualityOpt = '0';
                        // deliveryOpt = '0';
                        // costOpt = '0';
                      });
                      prefs.setString("safetyOpt", safetyOpt);
                      // prefs.setString("qualityOpt", qualityOpt);
                      // prefs.setString("deliveryOpt", deliveryOpt);
                      // prefs.setString("costOpt", costOpt);
                      prefs.setString("typeProblemBool", "1");
                    },
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
                                  onChanged: (value) async {
                                    final prefs = await _prefs;
                                    if (value != null) {
                                      setState(() {
                                        isSafety = !isSafety;
                                        safetyOpt = '1';
                                        // qualityOpt = '0';
                                        // deliveryOpt = '0';
                                        // costOpt = '0';
                                      });
                                      prefs.setString("safetyOpt", safetyOpt);
                                      // prefs.setString("qualityOpt", qualityOpt);
                                      // prefs.setString(
                                      //     "deliveryOpt", deliveryOpt);
                                      // prefs.setString("costOpt", costOpt);
                                      prefs.setString("typeProblemBool", "1");
                                    }
                                  })),
                          Text(
                            safety,
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
                    onTap: () async {
                      final prefs = await _prefs;
                      setState(() {
                        isQuality = !isQuality;
                        // safetyOpt = '0';
                        qualityOpt = '1';
                        // deliveryOpt = '0';
                        // costOpt = '0';
                      });
                      // prefs.setString("safetyOpt", safetyOpt);
                      prefs.setString("qualityOpt", qualityOpt);
                      // prefs.setString("deliveryOpt", deliveryOpt);
                      // prefs.setString("costOpt", costOpt);
                      prefs.setString("typeProblemBool", "1");
                    },
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
                                  onChanged: (value) async {
                                    final prefs = await _prefs;
                                    if (value != null) {
                                      setState(() {
                                        isQuality = !isQuality;
                                        safetyOpt = '0';
                                        qualityOpt = '1';
                                        deliveryOpt = '0';
                                        costOpt = '0';
                                      });
                                      // prefs.setString("safetyOpt", safetyOpt);
                                      prefs.setString("qualityOpt", qualityOpt);
                                      // prefs.setString("deliveryOpt", deliveryOpt);
                                      // prefs.setString("costOpt", costOpt);
                                      prefs.setString("typeProblemBool", "1");
                                    }
                                  })),
                          Text(
                            quality,
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
              onTap: () async {
                final prefs = await _prefs;
                setState(() {
                  isDelivery = !isDelivery;
                  // safetyOpt = '0';
                  // qualityOpt = '0';
                  deliveryOpt = '1';
                  // costOpt = '0';
                });
                // prefs.setString("safetyOpt", safetyOpt);
                // prefs.setString("qualityOpt", qualityOpt);
                prefs.setString("deliveryOpt", deliveryOpt);
                // prefs.setString("costOpt", costOpt);
                prefs.setString("typeProblemBool", "1");
              },
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
                                  onChanged: (value) async {
                                    final prefs = await _prefs;
                                    if (value != null) {
                                      setState(() {
                                        isDelivery = !isDelivery;
                                        // safetyOpt = '0';
                                        // qualityOpt = '0';
                                        deliveryOpt = '1';
                                        // costOpt = '0';
                                      });
                                      // prefs.setString("safetyOpt", safetyOpt);
                                      // prefs.setString("qualityOpt", qualityOpt);
                                      prefs.setString(
                                          "deliveryOpt", deliveryOpt);
                                      // prefs.setString("costOpt", costOpt);
                                      prefs.setString("typeProblemBool", "1");
                                    }
                                  })),
                          Text(
                            delivery,
                            style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF72777A),
                                fontStyle: FontStyle.normal),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        final prefs = await _prefs;
                        setState(() {
                          isCost = !isCost;
                          // safetyOpt = '0';
                          // qualityOpt = '0';
                          // deliveryOpt = '0';
                          costOpt = '1';
                        });
                        // prefs.setString("safetyOpt", safetyOpt);
                        // prefs.setString("qualityOpt", qualityOpt);
                        // prefs.setString("deliveryOpt", deliveryOpt);
                        prefs.setString("costOpt", costOpt);
                        prefs.setString("typeProblemBool", "1");
                      },
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
                                    onChanged: (value) async {
                                      final prefs = await _prefs;
                                      if (value != null) {
                                        setState(() {
                                          isCost = !isCost;
                                          // safetyOpt = '0';
                                          // qualityOpt = '0';
                                          // deliveryOpt = '0';
                                          costOpt = '1';
                                        });
                                        // prefs.setString("safetyOpt", safetyOpt);
                                        // prefs.setString(
                                        //     "qualityOpt", qualityOpt);
                                        // prefs.setString(
                                        //     "deliveryOpt", deliveryOpt);
                                        prefs.setString("costOpt", costOpt);
                                        prefs.setString("typeProblemBool", "1");
                                      }
                                    })),
                            Text(
                              cost,
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

            // percentage mistake
            checkKlasifikasiType == "Breakdown Maintenance"
                ? Container()
                : Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 16),
                          child: RichText(
                            text: TextSpan(
                              text: percentage,
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
                                onTap: () async {
                                  final prefs = await _prefs;
                                  setState(() {
                                    isMolding = !isMolding;
                                    moldingOpt = '1';
                                    // utilityOpt = '0';
                                    // productionOpt = '0';
                                    // engineerOpt = '0';
                                    // otherOpt = '0';
                                  });
                                  prefs.setString("moldingOpt", moldingOpt);
                                  // prefs.setString("utilityOpt", utilityOpt);
                                  // prefs.setString("productionOpt", productionOpt);
                                  // prefs.setString("engineerOpt", engineerOpt);
                                  // prefs.setString("otherOpt", otherOpt);
                                  prefs.setString("percentBool", "1");
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.40,
                                  height: 40,
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0xFF979C9E)),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: Checkbox(
                                              value: isMolding,
                                              onChanged: (value) async {
                                                final prefs = await _prefs;
                                                if (value != null) {
                                                  setState(() {
                                                    isMolding = !isMolding;
                                                    moldingOpt = '1';
                                                    // utilityOpt = '0';
                                                    // productionOpt = '0';
                                                    // engineerOpt = '0';
                                                    // otherOpt = '0';
                                                  });
                                                  prefs.setString(
                                                      "moldingOpt", moldingOpt);
                                                  // prefs.setString("utilityOpt", utilityOpt);
                                                  // prefs.setString(
                                                  //     "productionOpt", productionOpt);
                                                  // prefs.setString(
                                                  //     "engineerOpt", engineerOpt);
                                                  // prefs.setString("otherOpt", otherOpt);
                                                  prefs.setString(
                                                      "percentBool", "1");
                                                }
                                              })),
                                      Text(
                                        molding,
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
                                onTap: () async {
                                  final prefs = await _prefs;
                                  setState(() {
                                    isUtility = !isUtility;
                                    // moldingOpt = '0';
                                    utilityOpt = '1';
                                    // productionOpt = '0';
                                    // engineerOpt = '0';
                                    // otherOpt = '0';
                                  });
                                  // prefs.setString("moldingOpt", moldingOpt);
                                  prefs.setString("utilityOpt", utilityOpt);
                                  // prefs.setString("productionOpt", productionOpt);
                                  // prefs.setString("engineerOpt", engineerOpt);
                                  // prefs.setString("otherOpt", otherOpt);
                                  prefs.setString("percentBool", "1");
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.40,
                                  height: 40,
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0xFF979C9E)),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: Checkbox(
                                              value: isUtility,
                                              onChanged: (value) async {
                                                final prefs = await _prefs;
                                                if (value != null) {
                                                  setState(() {
                                                    isUtility = !isUtility;
                                                    // moldingOpt = '0';
                                                    utilityOpt = '1';
                                                    // productionOpt = '0';
                                                    // engineerOpt = '0';
                                                    // otherOpt = '0';
                                                  });
                                                  // prefs.setString("moldingOpt", moldingOpt);
                                                  prefs.setString(
                                                      "utilityOpt", utilityOpt);
                                                  // prefs.setString(
                                                  //     "productionOpt", productionOpt);
                                                  // prefs.setString(
                                                  //     "engineerOpt", engineerOpt);
                                                  // prefs.setString("otherOpt", otherOpt);
                                                  prefs.setString(
                                                      "percentBool", "1");
                                                }
                                              })),
                                      Text(
                                        utility,
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
                          onTap: () async {
                            final prefs = await _prefs;
                            setState(() {
                              isProduction = !isProduction;
                              // moldingOpt = '0';
                              // utilityOpt = '0';
                              productionOpt = '1';
                              // engineerOpt = '0';
                              // otherOpt = '0';
                            });
                            // prefs.setString("moldingOpt", moldingOpt);
                            // prefs.setString("utilityOpt", utilityOpt);
                            prefs.setString("productionOpt", productionOpt);
                            // prefs.setString("engineerOpt", engineerOpt);
                            // prefs.setString("otherOpt", otherOpt);
                            prefs.setString("percentBool", "1");
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.40,
                                  height: 40,
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0xFF979C9E)),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: Checkbox(
                                              value: isProduction,
                                              onChanged: (value) async {
                                                final prefs = await _prefs;
                                                if (value != null) {
                                                  setState(() {
                                                    isProduction =
                                                        !isProduction;
                                                    // moldingOpt = '0';
                                                    // utilityOpt = '0';
                                                    productionOpt = '1';
                                                    // engineerOpt = '0';
                                                    // otherOpt = '0';
                                                  });
                                                  // prefs.setString("moldingOpt", moldingOpt);
                                                  // prefs.setString("utilityOpt", utilityOpt);
                                                  prefs.setString(
                                                      "productionOpt",
                                                      productionOpt);
                                                  // prefs.setString(
                                                  //     "engineerOpt", engineerOpt);
                                                  // prefs.setString("otherOpt", otherOpt);
                                                  prefs.setString(
                                                      "percentBool", "1");
                                                }
                                              })),
                                      Text(
                                        production,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Color(0xFF72777A),
                                            fontStyle: FontStyle.normal),
                                      )
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    final prefs = await _prefs;
                                    setState(() {
                                      isEngineering = !isEngineering;
                                      // moldingOpt = '0';
                                      // utilityOpt = '0';
                                      // productionOpt = '0';
                                      engineerOpt = '1';
                                      otherOpt = '0';
                                    });
                                    // prefs.setString("moldingOpt", moldingOpt);
                                    // prefs.setString("utilityOpt", utilityOpt);
                                    // prefs.setString("productionOpt", productionOpt);
                                    prefs.setString("engineerOpt", engineerOpt);
                                    // prefs.setString("otherOpt", otherOpt);
                                    prefs.setString("percentBool", "1");
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.40,
                                    height: 40,
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0xFF979C9E)),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                            width: 30,
                                            height: 30,
                                            child: Checkbox(
                                                value: isEngineering,
                                                onChanged: (value) async {
                                                  final prefs = await _prefs;
                                                  if (value != null) {
                                                    setState(() {
                                                      isEngineering =
                                                          !isEngineering;
                                                      // moldingOpt = '0';
                                                      // utilityOpt = '0';
                                                      // productionOpt = '0';
                                                      engineerOpt = '1';
                                                      // otherOpt = '0';
                                                    });
                                                    // prefs.setString(
                                                    //     "moldingOpt", moldingOpt);
                                                    // prefs.setString(
                                                    //     "utilityOpt", utilityOpt);
                                                    // prefs.setString(
                                                    //     "productionOpt", productionOpt);
                                                    prefs.setString(
                                                        "engineerOpt",
                                                        engineerOpt);
                                                    // prefs.setString("otherOpt", otherOpt);
                                                    prefs.setString(
                                                        "percentBool", "1");
                                                  }
                                                })),
                                        Text(
                                          engineering,
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
                          onTap: () async {
                            final prefs = await _prefs;
                            setState(() {
                              isOther = !isOther;
                              // moldingOpt = '0';
                              // utilityOpt = '0';
                              // productionOpt = '0';
                              // engineerOpt = '0';
                              otherOpt = '1';
                            });
                            // prefs.setString("moldingOpt", moldingOpt);
                            // prefs.setString("utilityOpt", utilityOpt);
                            // prefs.setString("productionOpt", productionOpt);
                            // prefs.setString("engineerOpt", engineerOpt);
                            prefs.setString("otherOpt", otherOpt);
                            prefs.setString("percentBool", "1");
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.40,
                                  height: 40,
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0xFF979C9E)),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: Checkbox(
                                              value: isOther,
                                              onChanged: (value) async {
                                                final prefs = await _prefs;
                                                if (value != null) {
                                                  setState(() {
                                                    isOther = !isOther;
                                                    // moldingOpt = '0';
                                                    // utilityOpt = '0';
                                                    // productionOpt = '0';
                                                    // engineerOpt = '0';
                                                    otherOpt = '1';
                                                  });
                                                  // prefs.setString("moldingOpt", moldingOpt);
                                                  // prefs.setString("utilityOpt", utilityOpt);
                                                  // prefs.setString(
                                                  //     "productionOpt", productionOpt);
                                                  // prefs.setString(
                                                  //     "engineerOpt", engineerOpt);
                                                  prefs.setString(
                                                      "otherOpt", otherOpt);
                                                  prefs.setString(
                                                      "percentBool", "1");
                                                }
                                              })),
                                      Text(
                                        other,
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
                      ],
                    ),
                  ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: RichText(
                text: TextSpan(
                  text: picture_analis,
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
            imageProblemPath.isNotEmpty
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Row(
                          children: imageProblemPath.map((img) {
                            return Container(
                              width: 120,
                              height: 120,
                              margin: EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: FileImage(File(img)),
                                      fit: BoxFit.fill),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                            );
                          }).toList(),
                        ),
                        InkWell(
                          onTap: () {
                            imageFileList!.length != 4
                                ? showBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return optionPickImage(context);
                                    })
                                : () {
                                    Fluttertoast.showToast(
                                        msg: "Foto sudah ada 4",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Color(0xFF00AEDB),
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  };
                          },
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFF979C9E)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                Icon(
                                  Icons.add_a_photo,
                                  color: Color(0xFF979C9E),
                                  size: 50,
                                ),
                                Text(
                                  addmore,
                                  style: const TextStyle(
                                      color: Color(0xFF979C9E),
                                      fontSize: 14,
                                      fontFamily: 'Rubik',
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : InkWell(
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
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Icon(
                              Icons.add_a_photo,
                              color: Color(0xFF979C9E),
                              size: 50,
                            ),
                            Text(
                              addmax,
                              style: const TextStyle(
                                  color: Color(0xFF979C9E),
                                  fontSize: 14,
                                  fontFamily: 'Rubik',
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        )),
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
            child: Center(child: Text(select_image)),
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
                        Text(camera)
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
                        Text(gallery)
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
