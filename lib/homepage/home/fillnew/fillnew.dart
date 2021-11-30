// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, avoid_print

import 'package:e_cm/homepage/home/fillnew/additionpage/add_item_step7.dart';
import 'package:e_cm/homepage/home/fillnew/stepfillnew/stepfilldelapan.dart';
import 'package:e_cm/homepage/home/fillnew/stepfillnew/stepfilldua.dart';
import 'package:e_cm/homepage/home/fillnew/stepfillnew/stepfillempat.dart';
import 'package:e_cm/homepage/home/fillnew/stepfillnew/stepfillenam.dart';
import 'package:e_cm/homepage/home/fillnew/stepfillnew/stepfilllima.dart';
import 'package:e_cm/homepage/home/fillnew/stepfillnew/stepfillsatu.dart';
import 'package:e_cm/homepage/home/fillnew/stepfillnew/stepfilltiga.dart';
import 'package:e_cm/homepage/home/fillnew/stepfillnew/stepfilltujuh.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FillNew extends StatefulWidget {
  const FillNew({Key? key}) : super(key: key);

  @override
  _FillNewState createState() => _FillNewState();
}

class _FillNewState extends State<FillNew> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final StepFillSatu _stepFillSatu = StepFillSatu();
  final StepFillDua _stepFillDua = StepFillDua();
  final StepFillTiga _stepFillTiga = StepFillTiga();
  final StepFillEnam _stepFillEnam = StepFillEnam();
  final StepFillDelapan _stepFillDelapan = StepFillDelapan();

  List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  List<Step> get _steps => [
        Step(
          title: Text(''),
          content: Form(key: _formKeys[_currentStep], child: StepFillSatu()),
          isActive: _currentStep >= 0,
          // state: _currentStep >= 0
          //     ? StepState.complete
          //     : StepState.disabled,
        ),
        Step(
          title: Text(''),
          content: StepFillDua(),
          isActive: _currentStep >= 1,
          // state: _currentStep >= 1
          //     ? StepState.complete
          //     : StepState.disabled,
        ),
        Step(
          title: Text(''),
          content: StepFillTiga(),
          isActive: _currentStep >= 2,
          // state: _currentStep >= 2
          //     ? StepState.complete
          //     : StepState.disabled,
        ),
        Step(
          title: Text(''),
          content: StepFillEmpat(),
          isActive: _currentStep >= 3,
          // state: _currentStep >= 3
          //     ? StepState.complete
          //     : StepState.disabled,
        ),
        Step(
          title: Text(''),
          content: StepFillLima(),
          isActive: _currentStep >= 4,
          // state: _currentStep >= 4
          //     ? StepState.complete
          //     : StepState.disabled,
        ),
        Step(
          title: Text(''),
          content: StepFillEnam(),
          isActive: _currentStep >= 5,
          // state: _currentStep >= 5
          //     ? StepState.complete
          //     : StepState.disabled,
        ),
        Step(
          title: Text(''),
          content: StepFillTujuh(),
          isActive: _currentStep >= 6,
          // state: _currentStep >= 6
          //     ? StepState.complete
          //     : StepState.disabled,
        ),
        Step(
          title: Text(''),
          content: StepFillDelapan(),
          isActive: _currentStep >= 7,
          // state: _currentStep >= 0
          //     ? StepState.complete
          //     : StepState.disabled,
        ),
      ];

  int _currentStep = 0;
  final int _stepTotal = 8;
  int _stepClicked = 1;
  String textNext = 'Next';

  tapped(int step) {
    print(step);
    setState(() => _currentStep = step);
  }

  continued() async {
    final prefs = await _prefs;
    if (_formKeys[0].currentState!.validate() &&
        prefs.getString("classBool")!.isNotEmpty &&
        prefs.getString("dateBool")!.isNotEmpty &&
        prefs.getString("teamMemberBool")!.isNotEmpty &&
        prefs.getString("locationBool")!.isNotEmpty &&
        prefs.getString("machineNameBool")!.isNotEmpty &&
        prefs.getString("machineDetailBool")!.isNotEmpty) {
      _stepFillSatu.getSaveFillSatu();
      setState(() {
        _currentStep++;
      });
    }
    // _stepFillSatu.getSaveFillSatu();
    // _currentStep < 7 ? setState(() => _currentStep += 1) : null;
    // if (_currentStep < 7) {
    //   if (_currentStep == 1) {
    //     _stepFillSatu.getSaveFillSatu();
    //   } else if (_currentStep == 2) {
    //     _stepFillDua.getSaveFillDua();
    //   } else if (_currentStep == 3) {
    //     _stepFillTiga.getSaveStepFillTiga();
    //   } else if (_currentStep == 6) {
    //     _stepFillEnam.getSaveFillEnam();
    //   }

    //   if (_stepClicked != 8) {
    //     setState(() => _stepClicked += 1);
    //   }

    //   print("step sekarang: ${_currentStep.toString()}");
    //   print("button step next: ${_stepClicked.toString()}");
    // } else if (_currentStep == 7) {
    //   setState(() {
    //     textNext = 'Finish';
    //     setState(() => _stepClicked += 1);
    //   });
    //   // _stepFillDelapan.getMethodPostStep();
    // }
    // print(_stepClicked);
    // if (_stepClicked == 10) {
    //   _stepFillDelapan.getMethodPostStep();
    //   Fluttertoast.showToast(
    //       msg: 'Data successfully saved',
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.BOTTOM,
    //       timeInSecForIosWeb: 2,
    //       backgroundColor: Colors.greenAccent,
    //       textColor: Colors.white,
    //       fontSize: 16);

    //   Navigator.of(context).pop();
    // }
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
    if (_stepClicked == 10) {
      setState(() => _stepClicked -= 2);
    } else if (_stepClicked == 2) {
      Navigator.of(context).pop();
    } else {
      setState(() => _stepClicked -= 1);
    }

    if (_currentStep != 7) {
      setState(() {
        textNext = 'Next';
      });
    }

    print("di: $_currentStep");
    print(_stepClicked);
  }

  Future _resetDialogBox() async {
    setStateIfMounted(() {
      return showDialog<String>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return Container(
            child: const Text("data"),
          );
        },
      );
    });
  }

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  @override
  void initState() {
    _stepClicked += 1;

    super.initState();
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
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.info_outline,
                color: Colors.white,
              ))
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(
              child: Stepper(
                type: StepperType.horizontal,
                physics: ScrollPhysics(),
                currentStep: _currentStep,
                // onStepTapped: (step) => tapped(step),
                onStepContinue: continued,
                onStepCancel: cancel,
                controlsBuilder: (context, {onStepCancel, onStepContinue}) {
                  print(onStepContinue);
                  return Container(
                    margin: const EdgeInsets.only(top: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InkWell(
                          onTap: () => cancel(),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Color(0xFF00AEDB)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Center(
                              child: Text(
                                "Back",
                                style: TextStyle(
                                    fontFamily: 'Rubik',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF00AEDB)),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => continued(),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Color(0xFF00AEDB),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Center(
                              child: Text(
                                textNext == 'Next'
                                    ? "$textNext $_stepClicked/$_stepTotal"
                                    : textNext,
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
                // ignore: prefer_const_literals_to_create_immutables
                steps: _steps,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
