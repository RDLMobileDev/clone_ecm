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
            children: [
              Container(
                width: 100,
                height: 100,
                color: Colors.redAccent,
              ),
              const Text("Lokasi & tanggal"),
              const Text("Lokasi & tanggal"),
              _buildDivider(),
              const Text("keterangan"),
              const Text("Lokasi & tanggal"),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      width: 200,
                      height: 200,
                      color: Colors.amberAccent,
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 200,
                      height: 200,
                      color: Colors.greenAccent,
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 200,
                      height: 200,
                      color: Colors.greenAccent,
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 200,
                      height: 200,
                      color: Colors.greenAccent,
                    )
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      color: Colors.grey,
      height: 2,
      width: MediaQuery.of(context).size.width,
    );
  }

  Widget _buildItemAnalyst() {
    return Container(
        child: Column(
      children: [
        const Text("Why Analisis"),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
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
          children: [
            Container(
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
          children: [
            Container(
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
          children: [
            Container(
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
        const Text("Item Checking"),
        const Text("SELANG BRIGESTON PASCA ART "),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
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
            Container(
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
            Container(
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
        const Text("Improvement/Kaizen"),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
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
        const Text("Item Checking"),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
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
            Container(
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
            Container(
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
        const Text("Cost"),
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
        const Text("Sparepart"),
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
}
