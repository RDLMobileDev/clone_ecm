// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, duplicate_ignore, unnecessary_const, sized_box_for_whitespace

import 'package:flutter/material.dart';

class DetailEcm extends StatefulWidget {
  @override
  _DetailEcmState createState() => _DetailEcmState();
}

class _DetailEcmState extends State<DetailEcm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff00AEDB),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          "Preventive Maintance",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 12),
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/img_ava.png')),
                ),
              ),
              const Text(
                "Budi",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff00AEDB)),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                // color: Colors.amberAccent,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .center, //Center Column contents vertically,
                    crossAxisAlignment: CrossAxisAlignment
                        .center, //Center Column contents horizontally,
                    children: [
                      Icon(Icons.location_on_outlined, color: Colors.grey),
                      const Text(
                        "Factory 3 · 05/10/2021",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      )
                    ],
                  ),
                ),
              ),
              const Text("Machine : MC 5 2500T (32ZAC004)"),
              _buildDivider(),
              Container(
                width: MediaQuery.of(context).size.width,
                child: const Text("Incident",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87)),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: const Text(
                    "Shift A - 15:00 · Effect : Safety · Mistake : Molding",
                    style: TextStyle(fontSize: 14, color: Colors.grey)),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: const Text("SELANG HTM GETAS ",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87)),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/images/img_selang1.png')),
                          color: Colors.amberAccent,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/images/img_selang2.png')),
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                  ],
                ),
              ),
              _buildDivider(),
              Container(
                child: _buildItemAnalyst(),
              ),
              _buildDivider(),
              Container(
                child: _buildItemCheck(),
              ),
              _buildDivider(),
              Container(
                child: _buildItemRepairing(),
              ),
              _buildDivider(),
              Container(
                child: _buildImprovement(),
              ),
              _buildDivider(),
              Container(
                child: _buildWorkingTime(),
              ),
              _buildDivider(),
              Container(
                child: _buildCost(),
              ),
              _buildDivider(),
              Container(
                child: _buildSparePart(),
              ),
              _buildDivider(),
              Container(
                child: _buildSign(),
              ),
              _buildDivider(),
              Container(
                child: _buildTotalCost(),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: _buildButtonDecline(),
                  ),
                  Container(
                    child: _buildButtonAdd(),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      color: Colors.grey,
      height: 2,
      width: MediaQuery.of(context).size.width,
    );
  }

  Widget _buildItemAnalyst() {
    return Container(
        child: Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: const Text("Why Analisis",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87)),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            SizedBox(
              width: 100,
              child: Text("Why 1"),
            ),
            Text(" : "),
            Expanded(
              flex: 4,
              child: Text("pipe clogged with oil"),
            )
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            SizedBox(
              width: 100,
              child: Text("Why 2"),
            ),
            Text(" : "),
            Expanded(
              flex: 4,
              child: Text(
                  "Silica gel that broke from the dryer filter due to not being replaced for too long"),
            )
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            SizedBox(
              width: 100,
              child: Text("Why 3"),
            ),
            Text(" : "),
            Expanded(
              flex: 4,
              child: Text("there are debris from gram compressor dirt"),
            )
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            SizedBox(
              width: 100,
              child: Text("How"),
            ),
            Text(" : "),
            Expanded(
              flex: 4,
              child: Text("REPLACE HOSE WITH SPARE"),
            )
          ],
        ),
      ],
    ));
  }

  Widget _buildItemCheck() {
    return Container(
        child: Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: const Text("Item Checking",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87)),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: const Text("1. SELANG BRIGESTON PASCA ART ",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87)),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              child: Text("Standart"),
            ),
            Text(" : "),
            Expanded(
              flex: 4,
              child: Text("Solid colour and strong"),
            )
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              child: Text("Actual"),
            ),
            Text(" : "),
            Expanded(
              flex: 4,
              child: Text("Color is faded and there are rips"),
            )
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              child: Text("Time"),
            ),
            Text(" : "),
            Expanded(
              flex: 4,
              child: Text("15.00 - 17.00"),
            )
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              child: Text("Note"),
            ),
            Text(" : "),
            Expanded(
              flex: 4,
              child: Text("there are debris from gram compressor dirt"),
            )
          ],
        ),
      ],
    ));
  }

  Widget _buildItemRepairing() {
    return Container(
        child: Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: const Text("Item Repairing",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87)),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: const Text("1. SELANG BRIGESTON PASCA ART ",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87)),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              child: Text("Time"),
            ),
            Text(" : "),
            Expanded(
              flex: 4,
              child: Text("16:00-17:00"),
            )
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              child: Text("Repairing"),
            ),
            Text(" : "),
            Expanded(
              flex: 4,
              child: Text("REPLACE HOSE WITH SPARE"),
            )
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              child: Text("Note"),
            ),
            Text(" : "),
            Expanded(
              flex: 4,
              child: Text("there are debris from gram compressor dirt"),
            )
          ],
        ),
      ],
    ));
  }

  Widget _buildImprovement() {
    return Container(
        child: Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: const Text("Improvement/Kaizen",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87)),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              child: Text("Idea"),
            ),
            Text(" : "),
            Expanded(
              flex: 4,
              child: Text("Make all parameter can measuremed"),
            )
          ],
        ),
      ],
    ));
  }

  Widget _buildWorkingTime() {
    return Container(
        child: Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: const Text("Working Time",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87)),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              child: Text("Check & Repair"),
            ),
            Text(" : "),
            Expanded(
              flex: 4,
              child: Text("1 H 0 M + 1 H 0 M = 2 H 0 M"),
            )
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              child: Text("Break time"),
            ),
            Text(" : "),
            Expanded(
              flex: 4,
              child: Text("1 H 0 M"),
            )
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              child: Text("Line stop"),
            ),
            Text(" : "),
            Expanded(
              flex: 4,
              child: Text("2 H 0 M - 1 H 0 M = 1 H 0 M"),
            )
          ],
        ),
      ],
    ));
  }

  Widget _buildCost() {
    return Container(
        child: Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: const Text("Cost",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87)),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Text("In-House M/P Cost (Rp)"),
            ),
            Text("90.000"),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Text("Out-House (Rp) : "),
            ),
            Text("00.00"),
          ],
        ),
      ],
    ));
  }

  Widget _buildSparePart() {
    return Container(
        child: Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: const Text("Sparepart",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87)),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 4,
              child: Text("SELANG BRIGESTON PASCA ART- (1)"),
            ),
            Text("Rp.88.333"),
          ],
        ),
      ],
    ));
  }

  Widget _buildSign() {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: const Text("E-Sign",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87)),
        ),
        SizedBox(
          height: 10,
        ),
        Text("1. Sudin - T/L"),
        Text("2. Ario - Staff"),
      ],
    ));
  }

  Widget _buildTotalCost() {
    return Container(
        child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 4,
              child: Text("Total Cost (Rp) :",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87)),
            ),
            Text("Rp.88.333"),
          ],
        ),
      ],
    ));
  }

  Widget _buildButtonAdd() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.44,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor:
                    MaterialStateProperty.all<Color>(const Color(0xff00AEDB)),
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(horizontal: 0, vertical: 14)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                )),
                textStyle:
                    MaterialStateProperty.all(TextStyle(fontSize: 16.0))),
            onPressed: () {
              // saveData();
            },
            child: Text(
              'Add Signature',
              style: TextStyle(
                fontFamily: 'NunitoSans',
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonDecline() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.44,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.all<Color>(Colors.redAccent),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(horizontal: 0, vertical: 14)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        side: BorderSide(color: Colors.redAccent))),
                textStyle:
                    MaterialStateProperty.all(TextStyle(fontSize: 16.0))),
            onPressed: () {},
            child: Text(
              'Decline',
              style: TextStyle(
                fontFamily: 'Rubick',
                color: Colors.redAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
