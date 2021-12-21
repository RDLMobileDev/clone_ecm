import 'package:flutter/material.dart';

void showCustomDialog(
    {required BuildContext context,
    required String assetPath,
    required String title,
    required String message,
    bool isNegativeButton = true,
    required String positiveButtonTitle,
    required VoidCallback positiveCallback}) {
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
                margin: const EdgeInsets.only(left: 16, right: 16),
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
                assetPath,
                width: 150,
              )),
            ),
            Container(
              margin: const EdgeInsets.only(top: 8),
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                      color: Color(0xFF404446),
                      fontFamily: 'Rubik',
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 8, left: 16, right: 16),
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
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
                Visibility(
                  visible: isNegativeButton,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(top: 20, right: 5),
                        width: 130,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: const Color(0xffcf0000)),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                        child: const Center(
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                color: Color(0xffcf0000),
                                fontFamily: 'Rubik',
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        )),
                  ),
                ),
                InkWell(
                  onTap: () {
                    positiveCallback();
                    Navigator.of(context).pop();
                  },
                  child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      width: 130,
                      height: 40,
                      decoration: const BoxDecoration(
                          color: Color(0xFF00AEDB),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Center(
                        child: Text(
                          positiveButtonTitle,
                          style: const TextStyle(
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
