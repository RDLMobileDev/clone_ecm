// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';

class StepperNumber extends StatelessWidget {
  final bool isFilled;
  final String numberStep;
  const StepperNumber(
      {Key? key, required this.numberStep, required this.isFilled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            child: Center(
              child: Text(
                numberStep,
                style: const TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFF7F9FA)),
              ),
            ),
            decoration: BoxDecoration(
                color: isFilled == false
                    ? const Color(0xFFCDCFD0)
                    : const Color(0xFF00AEDB),
                shape: BoxShape.circle),
          ),
        ],
      ),
    );
  }
}
