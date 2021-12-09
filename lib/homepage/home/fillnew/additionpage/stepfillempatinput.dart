// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';

class StepFillEmpatInput extends StatefulWidget {
  const StepFillEmpatInput({Key? key}) : super(key: key);

  @override
  _StepFillEmpatInputState createState() => _StepFillEmpatInputState();
}

class _StepFillEmpatInputState extends State<StepFillEmpatInput> {
  TextEditingController? endTimePickController;
  TextEditingController? startTimePickController;
  final TextEditingController tecItem = TextEditingController();
  final TextEditingController tecStandard = TextEditingController();
  final TextEditingController tecActual = TextEditingController();
  final TextEditingController tecName = TextEditingController();

  Map<String, bool> noteOptions = {"ok": false, "limit": false, "ng": false};

  Map<String, bool> formValidations = {
    "item": false,
    "standard": false,
    "actual": false,
    "note": false,
    "start": false,
    "end": false,
    "name": false,
  };

  final DateTime now = DateTime.now();

  void getEndTime() {
    showTimePicker(
            context: context,
            initialTime: TimeOfDay(hour: now.hour, minute: now.minute))
        .then((value) {
      setState(() {
        formValidations["end"] = true;
        endTimePickController =
            TextEditingController(text: value!.format(context));
      });
    });
  }

  void getStartTime() {
    showTimePicker(
            context: context,
            initialTime: TimeOfDay(hour: now.hour, minute: now.minute))
        .then((value) {
      setState(() {
        formValidations["start"] = true;
        startTimePickController =
            TextEditingController(text: value!.format(context));
      });
    });
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
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              // ignore: prefer_const_constructors
              child: RichText(
                text: TextSpan(
                  text: 'Item Name ',
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
              width: MediaQuery.of(context).size.width,
              height: 40,
              margin: const EdgeInsets.only(top: 10),
              child: TextField(
                controller: tecItem,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 18),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    filled: true,
                    hintText: 'Type Item Name'),
                maxLines: 1,
                onChanged: (value) {
                  setState(() {
                    formValidations["item"] = value.isNotEmpty;
                  });
                },
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 10),
              child: RichText(
                text: TextSpan(
                  text: 'Standard ',
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
              width: MediaQuery.of(context).size.width,
              height: 40,
              margin: const EdgeInsets.only(top: 10),
              child: TextField(
                controller: tecStandard,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 18),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    filled: true,
                    hintText: 'Type Standard'),
                maxLines: 1,
                onChanged: (value) {
                  setState(
                    () {
                      formValidations["standard"] = value.isNotEmpty;
                      print(formValidations);
                    },
                  );
                },
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 10),
              child: RichText(
                text: TextSpan(
                  text: 'Actual ',
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
              width: MediaQuery.of(context).size.width,
              height: 40,
              margin: EdgeInsets.only(top: 10),
              child: TextField(
                controller: tecActual,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 18),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    filled: true,
                    hintText: 'Type Actual'),
                maxLines: 1,
                onChanged: (value) {
                  setState(() {
                    formValidations["actual"] = value.isNotEmpty;
                  });
                },
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 10),
              child: RichText(
                text: TextSpan(
                  text: 'Note ',
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
              height: 40,
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 10, right: 10),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: (noteOptions["ok"] ?? false)
                                ? Color(0xFF00AEDB)
                                : Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Colors.transparent),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          noteOptions["ok"] = !(noteOptions["ok"] ?? false);
                          noteOptions["limit"] = false;
                          noteOptions["ng"] = false;

                          formValidations["note"] =
                              noteOptions.containsValue(true);
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.circle_outlined,
                              color: (noteOptions["ok"] ?? false)
                                  ? Color(0xFF00AEDB)
                                  : Colors.grey,
                              size: 20,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'OK',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Rubik',
                                color: (noteOptions["ok"] ?? false)
                                    ? Color(0xFF00AEDB)
                                    : Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        noteOptions["limit"] = !(noteOptions["limit"] ?? false);
                        noteOptions["ok"] = false;
                        noteOptions["ng"] = false;

                        formValidations["note"] =
                            noteOptions.containsValue(true);
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 10, right: 10),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: (noteOptions["limit"] ?? false)
                                  ? Color(0xFF00AEDB)
                                  : Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Colors.transparent),
                      // ignore: prefer_const_literals_to_create_immutables
                      child: Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: <Widget>[
                          Icon(
                            Icons.change_history_outlined,
                            color: (noteOptions["limit"] ?? false)
                                ? Color(0xFF00AEDB)
                                : Colors.grey,
                            size: 20,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Limit',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Rubik',
                              color: (noteOptions["limit"] ?? false)
                                  ? Color(0xFF00AEDB)
                                  : Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        noteOptions["ng"] = !(noteOptions["ng"] ?? false);
                        noteOptions["limit"] = false;
                        noteOptions["ok"] = false;

                        formValidations["note"] =
                            noteOptions.containsValue(true);
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: (noteOptions["ng"] ?? false)
                                ? Color(0xFF00AEDB)
                                : Colors.grey,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Colors.transparent),
                      // ignore: prefer_const_literals_to_create_immutables
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Icon(
                            Icons.close,
                            color: (noteOptions["ng"] ?? false)
                                ? Color(0xFF00AEDB)
                                : Colors.grey,
                            size: 20,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'N/G',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Rubik',
                              color: (noteOptions["ng"] ?? false)
                                  ? Color(0xFF00AEDB)
                                  : Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 10),
              child: RichText(
                text: TextSpan(
                  text: 'Start Time ',
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
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.only(top: 10),
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: Icon(Icons.access_time, color: Colors.grey),
                  ),
                  Expanded(
                    child: TextFormField(
                      onTap: () => getStartTime(),
                      readOnly: true,
                      controller: startTimePickController,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          fillColor: Colors.white,
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          filled: true,
                          hintText: 'HH:MM'),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: Icon(Icons.arrow_drop_down, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 10),
              child: RichText(
                text: TextSpan(
                  text: 'End Time ',
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
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.only(top: 10),
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: Icon(Icons.access_time, color: Colors.grey),
                  ),
                  Expanded(
                    child: TextFormField(
                      onTap: () => getEndTime(),
                      readOnly: true,
                      controller: endTimePickController,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          fillColor: Colors.white,
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          filled: true,
                          hintText: 'HH:MM'),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: Icon(Icons.arrow_drop_down, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 10),
              child: RichText(
                text: TextSpan(
                  text: 'Name ',
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
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 10),
              height: 40,
              child: TextFormField(
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 18),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    filled: true,
                    suffixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                      size: 30,
                    ),
                    hintText: 'Type Name'),
                maxLines: 1,
                controller: tecName,
                onChanged: (value) {
                  setState(() {
                    formValidations["name"] = value.isNotEmpty;
                  });
                },
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 50),
              height: 40,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          formValidations.containsValue(false)
                              ? Colors.grey
                              : Color(0xFF00AEDB)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ))),
                  onPressed:
                      formValidations.containsValue(false) ? null : () {},
                  child: Text(
                    'Save Checking',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
