import 'package:flutter/material.dart';

class LineStepper extends StatelessWidget {
  const LineStepper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.045,
      height: 3,
      color: const Color(0xFFCDCFD0),
    );
  }
}
