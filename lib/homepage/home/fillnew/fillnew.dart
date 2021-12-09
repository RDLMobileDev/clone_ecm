// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, avoid_print
import 'package:e_cm/homepage/home/fillnew/stepfillnew/stepfilldelapan.dart';
import 'package:e_cm/homepage/home/fillnew/stepfillnew/stepfilldua.dart';
import 'package:e_cm/homepage/home/fillnew/stepfillnew/stepfillempat.dart';
import 'package:e_cm/homepage/home/fillnew/stepfillnew/stepfillenam.dart';
import 'package:e_cm/homepage/home/fillnew/stepfillnew/stepfilllima.dart';
import 'package:e_cm/homepage/home/fillnew/stepfillnew/stepfillsatu.dart';
import 'package:e_cm/homepage/home/fillnew/stepfillnew/stepfilltiga.dart';
import 'package:e_cm/homepage/home/fillnew/stepfillnew/stepfilltujuh.dart';
import 'package:flutter/foundation.dart';
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
  final StepFillEmpat _stepFillEmpat = StepFillEmpat();
  final StepFillLima _stepFillLima = StepFillLima();

  int _currentStep = 0;
  final int _stepTotal = 8;
  int _stepClicked = 1;

  tapped(int step) {
    print(step);
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 7 ? setState(() => _currentStep += 1) : null;

    print(_currentStep);
    if (_currentStep == 1) {
      _stepFillSatu.getSaveFillSatu();
    } else if (_currentStep == 2) {
      _stepFillDua.getSaveFillDua();
    } else if (_currentStep == 3) {
      _stepFillTiga.getSaveStepFillTiga();
    } else if (_stepFillEmpat == 4) {
      _stepFillEmpat.getSaveStepFillEmpat();
    } else if (_stepFillLima == 5) {
      _stepFillLima.getSavedStepFillLima();
    }

      if (_currentStep == 7) {
        setState(() {
          textNext = 'Finish';
        });
        if (prefs.getString("copyToBool")!.isNotEmpty) {
          var res = _stepFillDelapan.getMethodPostStep();
          prefs.remove("classBool");
          prefs.remove("dateBool");
          prefs.remove("teamMemberBool");
          prefs.remove("locationBool");
          prefs.remove("machineNameBool");
          prefs.remove("machineDetailBool");
          prefs.remove("shiftBool");
          prefs.remove("timeBool");
          prefs.remove("ketikProblemBool");
          prefs.remove("percentBool");
          prefs.remove("imageUploadBool");
          prefs.remove("whyBool1");
          prefs.remove("whyBool2");
          prefs.remove("whyBool3");
          prefs.remove("howBool");
          prefs.remove("itemStep4Bool");
          prefs.remove("itemRepairBool");
          prefs.remove("userNameBool");
          prefs.remove("ideaBool");
          prefs.remove("breakTimeBool");
          prefs.remove("outHouseHBool");
          prefs.remove("outHouseMpBool");
          prefs.remove("outHouseCostBool");
          prefs.remove("sparePartBool");
          prefs.remove("copyToBool");
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return SimpleDialog(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 16, right: 16),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.topRight,
                        child: Image.asset(
                          "assets/icons/X.png",
                          width: 20,
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                          child: Image.asset(
                        "assets/icons/done.png",
                        width: 150,
                      )),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(
                          "Thank you",
                          style: TextStyle(
                              color: Color(0xFF404446),
                              fontFamily: 'Rubik',
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8, left: 16, right: 16),
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(
                          "Your form has been saved and waiting to approved",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(0xFF404446),
                              fontFamily: 'Rubik',
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context);
                        showSummary();
                      },
                      child: Container(
                          margin: EdgeInsets.only(top: 20, left: 16, right: 16),
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Color(0xFF00AEDB),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Center(
                            child: Text(
                              "View Summary",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Rubik',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          )),
                    )
                  ],
                );
              });
        } else {
          Fluttertoast.showToast(
              msg: 'Pilih satu field Copy to',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              fontSize: 16);
        }
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(
          msg: 'You are in step ${_currentStep + 1}, form must be filled',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.greenAccent,
          textColor: Colors.white,
          fontSize: 16);
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
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => SimpleDialog(
                          title: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(bottom: 16),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'Information',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(
                                    text: TextSpan(
                                        text: 'Symbol',
                                        style: TextStyle(
                                            color: Color(0xFF404446),
                                            fontSize: 16,
                                            fontFamily: 'Rubik',
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w400),
                                        children: [
                                          TextSpan(
                                            text: ' * ',
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 16,
                                                fontFamily: 'Rubik',
                                                fontWeight: FontWeight.w400),
                                          ),
                                          TextSpan(
                                            text: '(required to filled)',
                                            style: TextStyle(
                                                color: Color(0xFF404446),
                                                fontSize: 16,
                                                fontFamily: 'Rubik',
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w400),
                                          )
                                        ]),
                                  ),
                                ),
                                Divider(
                                  height: 8,
                                  color: Color(0xFFCDCFD0),
                                ),
                                Text(
                                  "Rule line stop",
                                  style: TextStyle(
                                      color: Color(0xFF404446),
                                      fontSize: 16,
                                      fontFamily: 'Rubik',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.left,
                                )
                              ],
                            ),
                          ),
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              child: ListTile(
                                title: const Text(
                                    '1. > 10 minutes = G/L require e-sign > 15'),
                                onTap: () =>
                                    Navigator.pop(context, 'asd@mail.com'),
                              ),
                            ),
                            Container(
                              height: 30,
                              width: 30,
                              child: ListTile(
                                title: const Text(
                                    '2. minutes = C/L require e-sign > 20'),
                                onTap: () =>
                                    Navigator.pop(context, 'asd@mail.com'),
                              ),
                            ),
                            Container(
                              height: 30,
                              width: 30,
                              child: ListTile(
                                title: const Text(
                                    '3. minutes = MGR require e-sign + cost >'),
                                onTap: () =>
                                    Navigator.pop(context, 'asd@mail.com'),
                              ),
                            ),
                            Container(
                              height: 30,
                              width: 30,
                              child: ListTile(
                                title: const Text(
                                    '4. 1 million > 40 minutes = GM require e-sign'),
                                onTap: () =>
                                    Navigator.pop(context, 'asd@mail.com'),
                              ),
                            ),
                          ],
                        ));
              },
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
                onStepTapped: (step) => tapped(step),
                onStepContinue: continued,
                onStepCancel: cancel,
                controlsBuilder: (context, {onStepCancel, onStepContinue}) {
                  return Container(
                    margin: const EdgeInsets.only(top: 8),
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
                                "Next $_stepClicked/$_stepTotal",
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

  Widget showSummary() {
    return SimpleDialog(
      children: [
         InkWell(
           onTap: (){
             setState(() {
               
             });
           },
           child: Container(
            margin: EdgeInsets.only(left: 16, right: 16),
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.topRight,
            child: Image.asset(
              "assets/icons/X.png",
              width: 20,
            ),
                 ),
         ),
        Container(
          margin: EdgeInsets.only(top: 10),
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          child: Text("Summary",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black54,
            fontFamily: 'Rubik',
            fontSize: 18
          ),)
        ),
        Container(
          margin: EdgeInsets.only(top: 8),
          width: MediaQuery.of(context).size.width*0.7,
          child: Row(children: <Widget>[
            Container(
              child: Text("Line stop",
              style: TextStyle(
                color: Colors.black54,
                fontFamily: 'Rubik',
                fontSize: 16,
              ),),
            ),
            Container(
              child: Text("1 H 0 M",
              style: TextStyle(
                color: Colors.black54,
                fontFamily: 'Rubik',
                fontSize: 16,
              ),),
            ),
          ],),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(left: 20, right: 20),
          height: 2,
          color: Colors.grey,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(right: 20, left: 20),
          child: Text("E-CM must approved by",
          style: TextStyle(
            fontFamily: 'Rubik',
            color: Colors.black54,
            fontSize: 16
          ),),

        ),
        Container(
          margin: EdgeInsets.only(top: 8, left: 16, right: 16),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 30,
                      height: 30,
                      child: Image.asset("assets/images/img_ava.png"),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      width: MediaQuery.of(context).size.width*0.5,
                      child: Text("Dadi",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                      ),),
                    ),

                    Container(
                      width: MediaQuery.of(context).size.width*0.2,
                      child: Text(" - ",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                      ),),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width*0.2,
                      child: Text("GM",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                      ),),
                    ),
                  ],
                ),
              )
            ],
          )
        ),
        InkWell(
          onTap: () {
            Navigator.of(context);
          },
          child: Container(
              margin: EdgeInsets.only(top: 20, left: 16, right: 16),
              width: MediaQuery.of(context).size.width,
              height: 40,
              decoration: BoxDecoration(
                  color: Color(0xFF00AEDB),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Center(
                child: Text(
                  "Done",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Rubik',
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              )),
        )
      ],
    );
  }
}
