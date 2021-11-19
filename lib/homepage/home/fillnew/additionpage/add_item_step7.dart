import 'package:flutter/material.dart';

class AddItemFillTujuh extends StatefulWidget {
  const AddItemFillTujuh({Key? key}) : super(key: key);

  @override
  _AddItemFillTujuhState createState() => _AddItemFillTujuhState();
}

class _AddItemFillTujuhState extends State<AddItemFillTujuh> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF00AEDB),
      child: Column(
        children: [
          Container(
            color: Color(0xFF0277BD),
            margin: const EdgeInsets.only(top: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Part Name",
                  style: TextStyle(
                      fontFamily: 'Rubik',
                      color: Color(0xFF404446),
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 4),
            height: 40,
            decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF979C9E)),
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            child: TextFormField(
              style: const TextStyle(
                  fontFamily: 'Rubik',
                  color: Color(0xFF979C9E),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal),
              decoration: const InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  hintText: 'Type Item Name'),
            ),
          ),
          Container(
            color: Color(0xFF00B0FF),
            height: 40,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Quantity (Used) :",
                  style: TextStyle(
                      fontFamily: 'Rubik',
                      color: Color(0xFF404446),
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
