// ignore_for_file: sized_box_for_whitespace, avoid_print, unnecessary_const, use_key_in_widget_constructors, prefer_const_constructors

import 'package:e_cm/homepage/home/model/classificationmodel.dart';
import 'package:e_cm/homepage/home/model/locationmodel.dart';
import 'package:e_cm/homepage/home/services/classificationservice.dart';
import 'package:e_cm/homepage/home/services/locationservice.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StepFillSatu extends StatefulWidget {
  final StepFillSatuState stepFillSatuState = StepFillSatuState();

  void getSaveFillSatu() {
    stepFillSatuState.saveFillNewSatu();
  }

  @override
  StepFillSatuState createState() => StepFillSatuState();
}

class StepFillSatuState extends State<StepFillSatu> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  String dateSelected = 'DD/MM/YYYY';
  String? locationSelected;
  String? machineSelected;

  List<ClassificationModel> _listClassification = [];
  List<LocationModel> _listLocation = [];

  // static const menuItems = <String>['Factory 1', 'Factory 2', 'Factory 3'];
  static const machineItems = <String>['3ZAC0004', '3ZAC0005', '3ZAC0006'];

  List<DropdownMenuItem<LocationModel>>? _dropDownMenuLocations;

  final List<DropdownMenuItem<String>> _dropDownMachineItems = machineItems
      .map((value) => DropdownMenuItem(
            value: value,
            child: Text(value),
          ))
      .toList();

  // test call method from outside class (fillnew)
  void saveFillNewSatu() {
    print("fill new satu");
  }

  void getDateFromDialog() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1990),
            lastDate: DateTime(2022))
        .then((value) {
      if (value != null) {
        DateTime _fromDate = DateTime.now();
        _fromDate = value;
        final String date = DateFormat.yMd().format(_fromDate);
        setState(() {
          dateSelected = date;
        });
      }
    });
  }

  Future<List<ClassificationModel>> getClassificationData() async {
    _listClassification = await classificationService.getClassificationData();
    return await classificationService.getClassificationData();
  }

  Future<List<LocationModel>> getListLocation() async {
    final SharedPreferences prefs = await _prefs;
    String? tokenUser = prefs.getString("tokenKey").toString();
    _listLocation = await locationService.getLocationData(tokenUser);

    _dropDownMenuLocations = _listLocation
        .map((value) => DropdownMenuItem(
              value: value,
              child: Text(value.nama),
            ))
        .toList();

    return await locationService.getLocationData(tokenUser);
  }

  @override
  void initState() {
    getClassificationData();
    getListLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: const Text(
                "Classification",
                style: TextStyle(
                    fontFamily: 'Rubik',
                    color: Color(0xFF404446),
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 8),
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder(
                future: getClassificationData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: _listClassification.map((data) {
                        return Card(
                          elevation: 2,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            width: MediaQuery.of(context).size.width * 0.26,
                            child: Center(
                              child: Text(
                                data.nama,
                                style: TextStyle(
                                    fontFamily: 'Rubik',
                                    color: Color(0xFF404446),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }
                  return Center(
                    child: Text(
                      'Loading Classification...',
                      style: TextStyle(
                          fontFamily: 'Rubik',
                          color: Color(0xFF404446),
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: RichText(
                text: TextSpan(
                  text: 'Date ',
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
              onTap: () => getDateFromDialog(),
              child: Container(
                margin: const EdgeInsets.only(top: 4),
                padding: const EdgeInsets.all(5),
                height: 40,
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFF979C9E)),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const SizedBox(
                        width: 40,
                        height: 40,
                        child: Icon(Icons.calendar_today)),
                    Text(
                      dateSelected,
                      style: const TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                        width: 40,
                        height: 40,
                        child: Icon(Icons.arrow_drop_down))
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: RichText(
                text: TextSpan(
                  text: 'Team Member ',
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
              padding: const EdgeInsets.all(5),
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF979C9E)),
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: TextFormField(
                style: const TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    suffixIcon: Icon(Icons.search),
                    hintText: 'Type name',
                    contentPadding: const EdgeInsets.only(top: 5, left: 5),
                    hintStyle: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: RichText(
                text: TextSpan(
                  text: 'Location ',
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
              padding: const EdgeInsets.all(5),
              width: MediaQuery.of(context).size.width,
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF979C9E)),
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: FutureBuilder(
                future: getListLocation(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return DropdownButton(
                      isExpanded: true,
                      items: _dropDownMenuLocations,
                      value: locationSelected,
                      hint: const Text('Select factory'),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            locationSelected = value as String?;
                          });
                        }
                      },
                    );
                  }

                  return Center(
                    child: Text('Loading location...'),
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: RichText(
                text: TextSpan(
                  text: 'Machine Name ',
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
              padding: const EdgeInsets.all(5),
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF979C9E)),
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: TextFormField(
                style: const TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    suffixIcon: Icon(Icons.search),
                    hintText: 'Type machine',
                    contentPadding: const EdgeInsets.only(top: 5, left: 5),
                    hintStyle: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: RichText(
                text: TextSpan(
                  text: 'Machine Number ',
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
              padding: const EdgeInsets.all(5),
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF979C9E)),
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: DropdownButton(
                isExpanded: true,
                items: _dropDownMachineItems,
                value: machineSelected,
                hint: const Text('-Machine selected-'),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      machineSelected = value as String?;
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
