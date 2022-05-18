import 'package:flutter/material.dart';

Future dialogProgressSendData(BuildContext context) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Container(
          child: const Center(
            child: CircularProgressIndicator(
              value: null,
              strokeWidth: 4,
            ),
          ),
        );
      },
    );
