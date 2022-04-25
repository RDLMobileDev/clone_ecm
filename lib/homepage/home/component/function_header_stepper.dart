import 'package:e_cm/homepage/dashboard.dart';
import 'package:e_cm/homepage/home/services/api_remove_cache.dart';
import 'package:e_cm/homepage/home/services/remove_ecm_cancel_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

Future confirmBackToHome(BuildContext context) async {
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
                "assets/images/img_attendance_logout.png",
                width: 150,
              )),
            ),
            Container(
              margin: EdgeInsets.only(top: 8),
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  "Konfirmasi",
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
                  "Anda yakin ingin membatalkan pengisian Form E-CM?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xFF404446),
                      fontFamily: 'Rubik',
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 20, right: 5),
                      width: 130,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Color(0xFF00AEDB)),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Center(
                        child: Text(
                          "Tidak",
                          style: TextStyle(
                              color: Color(0xFF00AEDB),
                              fontFamily: 'Rubik',
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                      )),
                ),
                InkWell(
                  onTap: () {
                    cancelEcmRemoveData(context);
                  },
                  child: Container(
                      margin: EdgeInsets.only(top: 20),
                      width: 130,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Color(0xffcf0000),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Center(
                        child: Text(
                          "Ya",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Rubik',
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                      )),
                ),
              ],
            )
          ],
        );
      });
}

void showCustomDialog(BuildContext context) => showDialog(
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          height: 250,
          child: Stack(
            children: <Widget>[
              Container(
                // color: Colors.redAccent,
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      "Informasi",
                      style: TextStyle(
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Simbol",
                          style: TextStyle(fontFamily: 'Rubik', fontSize: 12),
                        ),
                        Text(
                          "*",
                          style: TextStyle(
                              fontFamily: 'Rubik',
                              fontSize: 14,
                              color: Colors.redAccent),
                        ),
                        Text(
                          "(wajib diisi)",
                          style: TextStyle(fontFamily: 'Rubik', fontSize: 12),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      height: 1,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Rule line stop",
                        style: TextStyle(fontFamily: 'Rubik', fontSize: 12),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(left: 20),
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("1. > 10 menit = G/L wajib tanda tangan",
                                style: TextStyle(
                                    fontFamily: 'Rubik', fontSize: 12)),
                            SizedBox(
                              height: 4,
                            ),
                            Text("2.  > 15 menit = C/L wajib tanda tangan",
                                style: TextStyle(
                                    fontFamily: 'Rubik', fontSize: 12)),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                                "3. > 20 menit = MGR wajib tanda tangan + cost > Juta",
                                style: TextStyle(
                                    fontFamily: 'Rubik', fontSize: 12)),
                            SizedBox(
                              height: 4,
                            ),
                            Text("4.  > 40 menit = GM wajib tanda tangan",
                                style: TextStyle(
                                    fontFamily: 'Rubik', fontSize: 12)),
                          ],
                        )),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, right: 10),
                width: MediaQuery.of(context).size.width,
                height: 40,
                // color: Colors.greenAccent,
                alignment: Alignment.topRight,
                child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Icon(Icons.clear_rounded)),
              ),
            ],
          ),
        ),
      ),
      context: context,
      barrierDismissible: false,
    );

void cancelEcmRemoveData(BuildContext context) async {
  final prefs = await _prefs;
  String tokenUser = prefs.getString("tokenKey") ?? "";
  String idEcm = prefs.getString("idEcm") ?? "";

  if ((tokenUser.isNotEmpty || tokenUser != "") &&
      (idEcm.isNotEmpty || idEcm != "")) {
    var response = await removeEcmCancelUser.removeEcmLast(tokenUser, idEcm);

    if (response['response']['status'] == 200) {
      removeStepCacheFillEcm();
      removeCacheFillEcm();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Dashboard()),
          ModalRoute.withName("/"));
    } else {
      removeStepCacheFillEcm();
      removeCacheFillEcm();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Dashboard()),
          ModalRoute.withName("/"));
    }
  } else {
    removeStepCacheFillEcm();
    removeCacheFillEcm();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Dashboard()),
        ModalRoute.withName("/"));
  }

  // isStepSatuFill = true;
  // isStepDuaFill = false;
  // isStepTigaFill = false;
  // isStepEmpatFill = false;
  // isStepLimaFill = false;
  // isStepEnamFill = false;
  // isStepTujuhFill = false;
  // isStepDelapanFill = false;
}
