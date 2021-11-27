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

class FillNew extends StatefulWidget {
  const FillNew({Key? key}) : super(key: key);

  @override
  _FillNewState createState() => _FillNewState();
}

class _FillNewState extends State<FillNew> {
  final StepFillSatu _stepFillSatu = StepFillSatu();
  final StepFillDua _stepFillDua = StepFillDua();
  final StepFillTiga _stepFillTiga = StepFillTiga();
  final StepFillEnam _stepFillEnam = StepFillEnam();
  final StepFillDelapan _stepFillDelapan = StepFillDelapan();

  int _currentStep = 0;
  final int _stepTotal = 8;
  int _stepClicked = 1;
  String textNext = 'Next';

  tapped(int step) {
    print(step);
    setState(() => _currentStep = step);
  }

  continued() {
    // _stepFillSatu.getSaveFillSatu();
    _currentStep < 7 ? setState(() => _currentStep += 1) : null;
    if (_currentStep < 7) {
      if (_currentStep == 1) {
        _stepFillSatu.getSaveFillSatu();
      } else if (_currentStep == 2) {
        _stepFillDua.getSaveFillDua();
      } else if (_currentStep == 3) {
        _stepFillTiga.getSaveStepFillTiga();
      } else if (_currentStep == 6) {
        _stepFillEnam.getSaveFillEnam();
      }

      if (_stepClicked != 8) {
        setState(() => _stepClicked += 1);
      }

      print("step sekarang: ${_currentStep.toString()}");
      print("button step next: ${_stepClicked.toString()}");
    } else if (_currentStep == 7) {
      setState(() {
        textNext = 'Finish';
      });
      // _stepFillDelapan.getMethodPostStep();
    }
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
    if (_stepClicked != 2) {
      setState(() => _stepClicked -= 1);
    } else if (_stepClicked == 2) {
      Navigator.of(context).pop();
    }
    print(_stepClicked);
  }

  void showDialogFinishStep() {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 390,
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    alignment: Alignment.topRight,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      "assets/icons/X.png",
                      width: 20,
                    ),
                  ),
                ),
                Image.asset(
                  "assets/icons/done.png",
                  width: 200,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 34),
                  child: Text(
                    "Thank you",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontFamily: 'Rubik',
                        color: Color(0xFF404446),
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: Text(
                    "Your form has been saved and waiting to approved by staff",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        height: 1.5,
                        fontFamily: 'Rubik',
                        decoration: TextDecoration.none,
                        color: Color(0xFF404446),
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                      ..pop()
                      ..pop();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 24),
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Color(0xFF00AEDB),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Center(
                      child: Text(
                        "Done",
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            decoration: TextDecoration.none,
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                )
              ],
            ),
            margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
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
                steps: [
                  Step(
                    title: Text(''),
                    content: StepFillSatu(),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
