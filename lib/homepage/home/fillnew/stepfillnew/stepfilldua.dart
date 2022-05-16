// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, avoid_unnecessary_containers, avoid_print, prefer_const_literals_to_create_immutables, invalid_use_of_visible_for_testing_member

import 'dart:convert';
import 'dart:io';

import 'package:e_cm/homepage/home/component/function_header_stepper.dart';
import 'package:e_cm/homepage/home/component/widget_fill_new.dart';
import 'package:e_cm/homepage/home/component/widget_line_stepper.dart';
import 'package:e_cm/homepage/home/fillnew/stepfillnew/stepfilltiga.dart';
import 'package:e_cm/homepage/home/services/apifillnewdua.dart';
import 'package:e_cm/util/shared_prefs_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../fillnew.dart';

class StepFillDua extends StatefulWidget {
  final StepFillDuaState stepFillDuaState = StepFillDuaState();

  StepFillDua({
    Key? key,
  }) : super(key: key);

  void getSaveFillDua() {
    stepFillDuaState.saveStepFillDua();
  }

  @override
  StepFillDuaState createState() => StepFillDuaState();
}

class StepFillDuaState extends State<StepFillDua> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String bahasa = "Bahasa Indonesia";
  bool bahasaSelected = false;

  String token = SharedPrefsUtil.getTokenUser();
  String ecmIdEdit = SharedPrefsUtil.getEcmIdEdit();
  String ecmId = SharedPrefsUtil.getEcmId();
  String userId = SharedPrefsUtil.getIdUser();

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
    // final prefs = await _prefs;
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
        timePickState = formattedTime;
        timePickController = TextEditingController(text: formattedTime);
      });
      // prefs.setString("timePickState", formattedTime);
      // prefs.setString("timeBool", "1");
    });
  }

  void selectImagesGallery() async {
    // final prefs = await _prefs;
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
          // prefs.setStringList("imagesKetPath", imageProblemPath);
          // prefs.setString("imageUploadBool", "1");
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
    // final prefs = await _prefs;
    if (imageFileList!.length < 4) {
      try {
        final XFile? selectedImages =
            await imagePicker.pickImage(source: ImageSource.camera);
        if (selectedImages != null) {
          imageFileList!.add(selectedImages);

          imageProblemPath.add(selectedImages.path);
          // prefs.setStringList("imagesKetPath", imageProblemPath);
          // prefs.setString("imageUploadBool", "1");
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
    String idEcmSendtoApi = ecmId.isEmpty || ecmId == "" ? ecmIdEdit : ecmId;

    if (timePickState.isNotEmpty &&
        problemTypeState.isNotEmpty &&
        imageProblemPath.isNotEmpty) {
      //  check if image path contain Uri or not

      // if (Uri.parse(imageProblemPath.first).isAbsolute) {
      //   print(imageProblemPath);
      //   goToStepFillTiga('Anda harus mengganti foto & upload ulang');
      // } else {

      // }

      // if (result['response']['status'] == 200) {
      //   ecmId.isNotEmpty || ecmId != ""
      // ? goToStepFillTiga('Data Step 2 disimpan')
      //       : goToStepFillTiga('Data Step 2 diperbarui');

      // } else {
      //   goToStepFillTiga('Data Step 2 gagal diperbarui');
      // }

      var result = await fillNewDua(
        token: token,
        shiftA: shiftA,
        shiftB: shiftB,
        shiftNs: shiftC,
        time: timePickState,
        problem: problemTypeState,
        safety: safetyOpt,
        quality: qualityOpt,
        delivery: deliveryOpt,
        cost: costOpt,
        molding: moldingOpt,
        utility: utilityOpt,
        production: productionOpt,
        engineering: engineerOpt,
        other: otherOpt,
        ecmId: idEcmSendtoApi,
        imagesPath: imageProblemPath,
      );

      print("data step 2 edit");
      print(result);

      if (result['response']['status'] == 200) {
        goToStepFillTiga('Data step 2 berhasil diubah');
        Get.to(StepFillTiga());
      } else {
        goToStepFillTiga('Data step 2 gagal diubah');
      }
    } else {
      goToStepFillTiga('Data gagal disimpan, cek semua input field');
    }
    try {} catch (e) {
      print(e);
      goToStepFillTiga('Data Step 2 gagal diperbarui');
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

  void getStep2DataForEdit() async {
    if ((ecmIdEdit.isNotEmpty || ecmIdEdit != "") ||
        (ecmId.isNotEmpty || ecmId != "")) {
      List<String> fotoStep2forEdit = [];

      try {
        var result = await getStepDuaDataForEdit(ecmIdEdit, token);

        if (result['response']['status'] == 200) {
          if (result['data'] != null) {
            print("getttt step 2 update");
            var dataStepDua = result['data'];

            setState(() {
              // set value for shift group
              if (dataStepDua['t_ecm_shifta'] == 1) {
                incidentGroup = '1';
                shiftA = '1';
                shiftB = '0';
                shiftC = '0';
              } else if (dataStepDua['t_ecm_shiftb'] == 1) {
                incidentGroup = '2';
                shiftA = '0';
                shiftB = '1';
                shiftC = '0';
              } else if (dataStepDua['t_ecm_shiftns'] == 1) {
                incidentGroup = '3';
                shiftA = '0';
                shiftB = '0';
                shiftC = '1';
              }

              // set value for date
              timePickController =
                  TextEditingController(text: dataStepDua['t_ecm_time']);
              timePickState = dataStepDua['t_ecm_time'];

              // set value for field input problem
              problemTypeController =
                  TextEditingController(text: dataStepDua['t_ecm_problem']);
              problemTypeState = dataStepDua['t_ecm_problem'];

              // set value for type of problem (safety and others)
              if (dataStepDua['t_ecm_safety'] != null) {
                isSafety = !isSafety;
                safetyOpt = dataStepDua['t_ecm_safety'].toString();
              }

              if (dataStepDua['t_ecm_quality'] != null) {
                isQuality = !isQuality;
                qualityOpt = dataStepDua['t_ecm_quality'].toString();
              }

              if (dataStepDua['t_ecm_delivery'] != null) {
                isDelivery = !isDelivery;
                deliveryOpt = dataStepDua['t_ecm_delivery'].toString();
              }

              if (dataStepDua['t_ecm_cost'] != null) {
                isCost = !isCost;
                costOpt = dataStepDua['t_ecm_cost'].toString();
              }

              // set value for PERCENTAGE MISTAKE
              if (dataStepDua['t_ecm_molding'] != null) {
                isMolding = !isMolding;
                moldingOpt = dataStepDua['t_ecm_molding'].toString();
              }

              if (dataStepDua['t_ecm_utility'] != null) {
                isUtility = !isUtility;
                utilityOpt = dataStepDua['t_ecm_utility'].toString();
              }

              if (dataStepDua['t_ecm_production'] != null) {
                isProduction = !isProduction;
                productionOpt = dataStepDua['t_ecm_production'].toString();
              }

              if (dataStepDua['t_ecm_engineering'] != null) {
                isEngineering = !isEngineering;
                engineerOpt = dataStepDua['t_ecm_engineering'].toString();
              }

              if (dataStepDua['t_ecm_other'] != null) {
                isOther = !isOther;
                otherOpt = dataStepDua['t_ecm_other'].toString();
              }
            });

            // set value for selected photo(s)

            if (dataStepDua['t_ecm_foto1'] != null) {
              fotoStep2forEdit.add(dataStepDua['t_ecm_foto1']);
            }

            if (dataStepDua['t_ecm_foto2'] != null) {
              fotoStep2forEdit.add(dataStepDua['t_ecm_foto2']);
            }

            if (dataStepDua['t_ecm_foto3'] != null) {
              fotoStep2forEdit.add(dataStepDua['t_ecm_foto3']);
            }

            if (dataStepDua['t_ecm_foto4'] != null) {
              fotoStep2forEdit.add(dataStepDua['t_ecm_foto4']);
            }

            setState(() {
              imageProblemPath.addAll(fotoStep2forEdit);
            });

            // setFormStep2AfterChoosing();
          }
        }
      } catch (e) {
        print(e);
      }
    }
  }

  void checkKlasifikasiTypeValue() async {
    // final prefs = await _prefs;

    String klasifikasiType = SharedPrefsUtil.getNamaKlasifikasi();

    print("nama klasifikasi => $klasifikasiType");

    if (klasifikasiType != "" && klasifikasiType.isNotEmpty) {
      setState(() {
        checkKlasifikasiType = klasifikasiType;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    print("step 2 init");

    setLang();
    setBahasa();

    getStep2DataForEdit();

    // setFormStep2AfterChoosing();
    checkKlasifikasiTypeValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF00AEDB),
        elevation: 1,
        title: Text(
          "E-CM Card",
          style: TextStyle(
              fontFamily: 'Rubik',
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () async {
              await confirmBackToHome(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  showCustomDialog(context);
                });
              },
              icon: Icon(
                Icons.info_outline,
                color: Colors.white,
              ))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StepperNumber(
                      numberStep: "1",
                      isFilled: false,
                    ),
                    LineStepper(),
                    StepperNumber(
                      numberStep: "2",
                      isFilled: true,
                    ),
                    LineStepper(),
                    StepperNumber(
                      numberStep: "3",
                      isFilled: false,
                    ),
                    LineStepper(),
                    StepperNumber(
                      numberStep: "4",
                      isFilled: false,
                    ),
                    LineStepper(),
                    StepperNumber(
                      numberStep: "5",
                      isFilled: false,
                    ),
                    LineStepper(),
                    StepperNumber(
                      numberStep: "6",
                      isFilled: false,
                    ),
                    LineStepper(),
                    StepperNumber(
                      numberStep: "7",
                      isFilled: false,
                    ),
                    LineStepper(),
                    StepperNumber(
                      numberStep: "8",
                      isFilled: false,
                    ),
                  ],
                ),
              ),

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
                        // final prefs = await _prefs;
                        setState(() {
                          incidentGroup = '1';
                          shiftA = '1';
                          shiftB = '0';
                          shiftC = '0';
                        });
                        // prefs.setString("shiftA", shiftA);
                        // prefs.setString("shiftB", shiftB);
                        // prefs.setString("shiftC", shiftC);
                        // prefs.setString("shiftBool", "1");
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
                                      // final prefs = await _prefs;
                                      if (value != null) {
                                        setState(() {
                                          incidentGroup = value as String;
                                          shiftA = '1';
                                          shiftB = '0';
                                          shiftC = '0';
                                        });
                                        // prefs.setString("shiftA", shiftA);
                                        // prefs.setString("shiftB", shiftB);
                                        // prefs.setString("shiftC", shiftC);
                                        // prefs.setString("shiftBool", "1");
                                      }
                                    })),
                            Text(shift_a)
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        // final prefs = await _prefs;
                        setState(() {
                          incidentGroup = '2';
                          shiftA = '0';
                          shiftB = '1';
                          shiftC = '0';
                        });
                        // prefs.setString("shiftA", shiftA);
                        // prefs.setString("shiftB", shiftB);
                        // prefs.setString("shiftC", shiftC);
                        // prefs.setString("shiftBool", "1");
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
                                      // final prefs = await _prefs;
                                      if (value != null) {
                                        setState(() {
                                          incidentGroup = value as String;
                                          shiftA = '0';
                                          shiftB = '1';
                                          shiftC = '0';
                                        });
                                        // prefs.setString("shiftA", shiftA);
                                        // prefs.setString("shiftB", shiftB);
                                        // prefs.setString("shiftC", shiftC);
                                        // prefs.setString(
                                        //     "insidenShift", incidentGroup!);
                                        // prefs.setString("shiftBool", "1");
                                      }
                                    })),
                            Text(shift_b)
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        // final prefs = await _prefs;
                        setState(() {
                          incidentGroup = '3';
                          shiftA = '0';
                          shiftB = '0';
                          shiftC = '1';
                        });
                        // prefs.setString("shiftA", shiftA);
                        // prefs.setString("shiftB", shiftB);
                        // prefs.setString("shiftC", shiftC);
                        // prefs.setString("shiftBool", "1");
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
                                      // final prefs = await _prefs;
                                      if (value != null) {
                                        setState(() {
                                          incidentGroup = value as String;
                                          shiftA = '0';
                                          shiftB = '0';
                                          shiftC = '1';
                                        });
                                        // prefs.setString("shiftA", shiftA);
                                        // prefs.setString("shiftB", shiftB);
                                        // prefs.setString("shiftC", shiftC);
                                        // prefs.setString("shiftBool", "1");
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
                    setState(() {
                      problemTypeState = value;
                    });
                    // final prefs = await _prefs;
                    // prefs.setString("problemTypeState", value);
                    // prefs.setString("ketikProblemBool", "1");
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
                        // final prefs = await _prefs;
                        setState(() {
                          isSafety = !isSafety;
                          if (isSafety == true) {
                            safetyOpt = '1';
                            print(true);
                          } else {
                            print(false);
                            safetyOpt = '0';
                          }
                          // qualityOpt = '0';
                          // deliveryOpt = '0';
                          // costOpt = '0';
                        });
                        // prefs.setString("safetyOpt", safetyOpt);
                        // prefs.setString("qualityOpt", qualityOpt);
                        // prefs.setString("deliveryOpt", deliveryOpt);
                        // prefs.setString("costOpt", costOpt);
                        // prefs.setString("typeProblemBool", "1");
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
                                      // final prefs = await _prefs;
                                      if (value != null) {
                                        setState(() {
                                          isSafety = !isSafety;
                                          if (isSafety == true) {
                                            safetyOpt = '1';
                                            print(true);
                                          } else {
                                            print(false);
                                            safetyOpt = '0';
                                          }
                                          // qualityOpt = '0';
                                          // deliveryOpt = '0';
                                          // costOpt = '0';
                                        });
                                        // prefs.setString("safetyOpt", safetyOpt);
                                        // prefs.setString("qualityOpt", qualityOpt);
                                        // prefs.setString(
                                        //     "deliveryOpt", deliveryOpt);
                                        // prefs.setString("costOpt", costOpt);
                                        // prefs.setString("typeProblemBool", "1");
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
                        // final prefs = await _prefs;
                        setState(() {
                          isQuality = !isQuality;
                          // safetyOpt = '0';
                          if (isQuality == true) {
                            qualityOpt = '1';
                            print(true);
                          } else {
                            print(false);
                            qualityOpt = '0';
                          }
                          // deliveryOpt = '0';
                          // costOpt = '0';
                        });
                        // prefs.setString("safetyOpt", safetyOpt);
                        // prefs.setString("qualityOpt", qualityOpt);
                        // prefs.setString("deliveryOpt", deliveryOpt);
                        // prefs.setString("costOpt", costOpt);
                        // prefs.setString("typeProblemBool", "1");
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
                                      // final prefs = await _prefs;
                                      if (value != null) {
                                        setState(() {
                                          isQuality = !isQuality;
                                          safetyOpt = '0';
                                          if (isQuality == true) {
                                            qualityOpt = '1';
                                            print(true);
                                          } else {
                                            print(false);
                                            qualityOpt = '0';
                                          }
                                          deliveryOpt = '0';
                                          costOpt = '0';
                                        });
                                        // prefs.setString("safetyOpt", safetyOpt);
                                        // prefs.setString("qualityOpt", qualityOpt);
                                        // prefs.setString("deliveryOpt", deliveryOpt);
                                        // prefs.setString("costOpt", costOpt);
                                        // prefs.setString("typeProblemBool", "1");
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
                  // final prefs = await _prefs;
                  setState(() {
                    isDelivery = !isDelivery;
                    // safetyOpt = '0';
                    // qualityOpt = '0';
                    if (isDelivery == true) {
                      deliveryOpt = '1';
                      print(true);
                    } else {
                      print(false);
                      deliveryOpt = '0';
                    }
                    // costOpt = '0';
                  });
                  // prefs.setString("safetyOpt", safetyOpt);
                  // prefs.setString("qualityOpt", qualityOpt);
                  // prefs.setString("deliveryOpt", deliveryOpt);
                  // prefs.setString("costOpt", costOpt);
                  // prefs.setString("typeProblemBool", "1");
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
                                      // final prefs = await _prefs;
                                      if (value != null) {
                                        setState(() {
                                          isDelivery = !isDelivery;
                                          // safetyOpt = '0';
                                          // qualityOpt = '0';
                                          if (isDelivery == true) {
                                            deliveryOpt = '1';
                                            print(true);
                                          } else {
                                            print(false);
                                            deliveryOpt = '0';
                                          }
                                          // costOpt = '0';
                                        });
                                        // prefs.setString("safetyOpt", safetyOpt);
                                        // prefs.setString("qualityOpt", qualityOpt);
                                        // prefs.setString(
                                        //     "deliveryOpt", deliveryOpt);
                                        // prefs.setString("costOpt", costOpt);
                                        // prefs.setString("typeProblemBool", "1");
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
                          // final prefs = await _prefs;
                          setState(() {
                            isCost = !isCost;
                            // safetyOpt = '0';
                            // qualityOpt = '0';
                            // deliveryOpt = '0';
                            if (isCost == true) {
                              costOpt = '1';
                              print(true);
                            } else {
                              print(false);
                              costOpt = '0';
                            }
                          });
                          // prefs.setString("safetyOpt", safetyOpt);
                          // prefs.setString("qualityOpt", qualityOpt);
                          // prefs.setString("deliveryOpt", deliveryOpt);
                          // prefs.setString("costOpt", costOpt);
                          // prefs.setString("typeProblemBool", "1");
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.40,
                          height: 40,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xFF979C9E)),
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
                                        // final prefs = await _prefs;
                                        if (value != null) {
                                          setState(() {
                                            isCost = !isCost;
                                            // safetyOpt = '0';
                                            // qualityOpt = '0';
                                            // deliveryOpt = '0';
                                            if (isCost == true) {
                                              costOpt = '1';
                                              print(true);
                                            } else {
                                              print(false);
                                              costOpt = '0';
                                            }
                                          });
                                          // prefs.setString("safetyOpt", safetyOpt);
                                          // prefs.setString(
                                          //     "qualityOpt", qualityOpt);
                                          // prefs.setString(
                                          //     "deliveryOpt", deliveryOpt);
                                          // prefs.setString("costOpt", costOpt);
                                          // prefs.setString("typeProblemBool", "1");
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
              checkKlasifikasiType != "Breakdown Maintenance"
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
                                    // final prefs = await _prefs;
                                    setState(() {
                                      isMolding = !isMolding;
                                      if (isMolding == true) {
                                        moldingOpt = '1';
                                        print(true);
                                      } else {
                                        print(false);
                                        moldingOpt = '0';
                                      }
                                      // utilityOpt = '0';
                                      // productionOpt = '0';
                                      // engineerOpt = '0';
                                      // otherOpt = '0';
                                    });
                                    // prefs.setString("moldingOpt", moldingOpt);
                                    // prefs.setString("utilityOpt", utilityOpt);
                                    // prefs.setString("productionOpt", productionOpt);
                                    // prefs.setString("engineerOpt", engineerOpt);
                                    // prefs.setString("otherOpt", otherOpt);
                                    // prefs.setString("percentBool", "1");
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
                                                value: isMolding,
                                                onChanged: (value) async {
                                                  // final prefs = await _prefs;
                                                  if (value != null) {
                                                    setState(() {
                                                      isMolding = !isMolding;
                                                      if (isMolding == true) {
                                                        moldingOpt = '1';
                                                        print(true);
                                                      } else {
                                                        print(false);
                                                        moldingOpt = '0';
                                                      }
                                                      // utilityOpt = '0';
                                                      // productionOpt = '0';
                                                      // engineerOpt = '0';
                                                      // otherOpt = '0';
                                                    });
                                                    // prefs.setString(
                                                    //     "moldingOpt", moldingOpt);
                                                    // prefs.setString("utilityOpt", utilityOpt);
                                                    // prefs.setString(
                                                    //     "productionOpt", productionOpt);
                                                    // prefs.setString(
                                                    //     "engineerOpt", engineerOpt);
                                                    // prefs.setString("otherOpt", otherOpt);
                                                    // prefs.setString(
                                                    //     "percentBool", "1");
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
                                    // final prefs = await _prefs;
                                    setState(() {
                                      isUtility = !isUtility;
                                      // moldingOpt = '0';
                                      if (isUtility == true) {
                                        utilityOpt = '1';
                                        print(true);
                                      } else {
                                        print(false);
                                        utilityOpt = '0';
                                      }
                                      // productionOpt = '0';
                                      // engineerOpt = '0';
                                      // otherOpt = '0';
                                    });
                                    // prefs.setString("moldingOpt", moldingOpt);
                                    // prefs.setString("utilityOpt", utilityOpt);
                                    // prefs.setString("productionOpt", productionOpt);
                                    // prefs.setString("engineerOpt", engineerOpt);
                                    // prefs.setString("otherOpt", otherOpt);
                                    // prefs.setString("percentBool", "1");
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
                                                value: isUtility,
                                                onChanged: (value) async {
                                                  // final prefs = await _prefs;
                                                  if (value != null) {
                                                    setState(() {
                                                      isUtility = !isUtility;
                                                      // moldingOpt = '0';
                                                      if (isUtility == true) {
                                                        utilityOpt = '1';
                                                        print(true);
                                                      } else {
                                                        print(false);
                                                        utilityOpt = '0';
                                                      }
                                                      // productionOpt = '0';
                                                      // engineerOpt = '0';
                                                      // otherOpt = '0';
                                                    });
                                                    // prefs.setString("moldingOpt", moldingOpt);
                                                    // prefs.setString(
                                                    //     "utilityOpt", utilityOpt);
                                                    // prefs.setString(
                                                    //     "productionOpt", productionOpt);
                                                    // prefs.setString(
                                                    //     "engineerOpt", engineerOpt);
                                                    // prefs.setString("otherOpt", otherOpt);
                                                    // prefs.setString(
                                                    //     "percentBool", "1");
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
                              // final prefs = await _prefs;
                              setState(() {
                                isProduction = !isProduction;
                                // moldingOpt = '0';
                                // utilityOpt = '0';
                                if (isProduction == true) {
                                  productionOpt = '1';
                                  print(true);
                                } else {
                                  print(false);
                                  productionOpt = '0';
                                }
                                // engineerOpt = '0';
                                // otherOpt = '0';
                              });
                              // prefs.setString("moldingOpt", moldingOpt);
                              // prefs.setString("utilityOpt", utilityOpt);
                              // prefs.setString("productionOpt", productionOpt);
                              // prefs.setString("engineerOpt", engineerOpt);
                              // prefs.setString("otherOpt", otherOpt);
                              // prefs.setString("percentBool", "1");
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
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
                                                value: isProduction,
                                                onChanged: (value) async {
                                                  // final prefs = await _prefs;
                                                  if (value != null) {
                                                    setState(() {
                                                      isProduction =
                                                          !isProduction;
                                                      // moldingOpt = '0';
                                                      // utilityOpt = '0';
                                                      if (isProduction ==
                                                          true) {
                                                        productionOpt = '1';
                                                        print(true);
                                                      } else {
                                                        print(false);
                                                        productionOpt = '0';
                                                      }
                                                      // engineerOpt = '0';
                                                      // otherOpt = '0';
                                                    });
                                                    // prefs.setString("moldingOpt", moldingOpt);
                                                    // prefs.setString("utilityOpt", utilityOpt);
                                                    // prefs.setString(
                                                    //     "productionOpt",
                                                    //     productionOpt);
                                                    // prefs.setString(
                                                    //     "engineerOpt", engineerOpt);
                                                    // prefs.setString("otherOpt", otherOpt);
                                                    // prefs.setString(
                                                    //     "percentBool", "1");
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
                                      // final prefs = await _prefs;
                                      setState(() {
                                        isEngineering = !isEngineering;
                                        // moldingOpt = '0';
                                        // utilityOpt = '0';
                                        // productionOpt = '0';
                                        if (isEngineering == true) {
                                          engineerOpt = '1';
                                          print(true);
                                        } else {
                                          print(false);
                                          engineerOpt = '0';
                                        }
                                        otherOpt = '0';
                                      });
                                      // prefs.setString("moldingOpt", moldingOpt);
                                      // prefs.setString("utilityOpt", utilityOpt);
                                      // prefs.setString("productionOpt", productionOpt);
                                      // prefs.setString("engineerOpt", engineerOpt);
                                      // prefs.setString("otherOpt", otherOpt);
                                      // prefs.setString("percentBool", "1");
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
                                                    // final prefs = await _prefs;
                                                    if (value != null) {
                                                      setState(() {
                                                        isEngineering =
                                                            !isEngineering;
                                                        // moldingOpt = '0';
                                                        // utilityOpt = '0';
                                                        // productionOpt = '0';
                                                        print(value);
                                                        if (isEngineering ==
                                                            true) {
                                                          engineerOpt = '1';
                                                          print(true);
                                                        } else {
                                                          print(false);
                                                          engineerOpt = '0';
                                                        }
                                                        // otherOpt = '0';
                                                      });
                                                      // prefs.setString(
                                                      //     "moldingOpt", moldingOpt);
                                                      // prefs.setString(
                                                      //     "utilityOpt", utilityOpt);
                                                      // prefs.setString(
                                                      //     "productionOpt", productionOpt);
                                                      // prefs.setString(
                                                      //     "engineerOpt",
                                                      //     engineerOpt);
                                                      // // prefs.setString("otherOpt", otherOpt);
                                                      // prefs.setString(
                                                      //     "percentBool", "1");
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
                              // final prefs = await _prefs;
                              setState(() {
                                isOther = !isOther;
                                // moldingOpt = '0';
                                // utilityOpt = '0';
                                // productionOpt = '0';
                                // engineerOpt = '0';
                                if (isOther == true) {
                                  otherOpt = '1';
                                  print(true);
                                } else {
                                  print(false);
                                  otherOpt = '0';
                                }
                              });
                              // prefs.setString("moldingOpt", moldingOpt);
                              // prefs.setString("utilityOpt", utilityOpt);
                              // prefs.setString("productionOpt", productionOpt);
                              // prefs.setString("engineerOpt", engineerOpt);
                              // prefs.setString("otherOpt", otherOpt);
                              // prefs.setString("percentBool", "1");
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
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
                                                value: isOther,
                                                onChanged: (value) async {
                                                  // final prefs = await _prefs;
                                                  if (value != null) {
                                                    setState(() {
                                                      isOther = !isOther;
                                                      // moldingOpt = '0';
                                                      // utilityOpt = '0';
                                                      // productionOpt = '0';
                                                      // engineerOpt = '0';
                                                      if (isOther == true) {
                                                        otherOpt = '1';
                                                        print(true);
                                                      } else {
                                                        print(false);
                                                        otherOpt = '0';
                                                      }
                                                    });
                                                    // prefs.setString("moldingOpt", moldingOpt);
                                                    // prefs.setString("utilityOpt", utilityOpt);
                                                    // prefs.setString(
                                                    //     "productionOpt", productionOpt);
                                                    // prefs.setString(
                                                    //     "engineerOpt", engineerOpt);
                                                    // prefs.setString(
                                                    //     "otherOpt", otherOpt);
                                                    // prefs.setString(
                                                    //     "percentBool", "1");
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
                margin: EdgeInsets.only(top: 16, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
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
                    InkWell(
                        onTap: () async {
                          setState(() {
                            imageProblemPath.clear();
                            imageFileList!.clear();
                          });
                        },
                        child: Text(
                          "Hapus Foto",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontFamily: 'Rubik',
                              fontSize: 16,
                              color: Colors.red,
                              fontWeight: FontWeight.w400),
                        ))
                  ],
                ),
              ),
              imageProblemPath.isNotEmpty
                  ? SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Row(
                            children: imageProblemPath.map((img) {
                              bool urlIstrue = Uri.parse(img).isAbsolute;
                              return Container(
                                width: 120,
                                height: 120,
                                margin: EdgeInsets.only(right: 8),
                                decoration: urlIstrue == true
                                    ? BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(img),
                                            fit: BoxFit.fill),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)))
                                    : BoxDecoration(
                                        image: DecorationImage(
                                            image: FileImage(File(img)),
                                            fit: BoxFit.fill),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                              );
                            }).toList(),
                          ),
                          InkWell(
                            onTap: () {
                              imageFileList!.length != 4
                                  ? showModalBottomSheet(
                                      context: context,
                                      builder: (context) =>
                                          optionPickImage(context))
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
                              print("panjang = " +
                                  imageFileList!.length.toString());
                              print("gambar = " +
                                  imageProblemPath.length.toString());
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
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => optionPickImage(context));
                      },
                      child: Container(
                          margin: const EdgeInsets.only(top: 4),
                          padding: const EdgeInsets.all(10),
                          height: 120,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xFF979C9E)),
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
              Container(
                margin: EdgeInsets.only(top: 26),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        // isStepSatuFill = true;
                        // isStepDuaFill = false;
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: Color(0xFF00AEDB))),
                        child: Center(
                          child: Text(
                            "Kembali",
                            style: TextStyle(
                                fontFamily: 'Rubik',
                                color: Color(0xFF00AEDB),
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => saveStepFillDua(),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Color(0xFF00AEDB)),
                        child: Center(
                          child: Text("Lanjut 3/8",
                              style: TextStyle(
                                  fontFamily: 'Rubik',
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400)),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
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
