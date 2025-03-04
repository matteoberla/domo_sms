import 'package:domo_sms/styles.dart';
import 'package:flutter/material.dart';

class PinNumber extends StatelessWidget {
  final TextEditingController textEditingController;
  final OutlineInputBorder outlineInputBorder;
  const PinNumber(
      {super.key,
      required this.textEditingController,
      required this.outlineInputBorder});

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      color: transparent,
      width: 50.0,
      child: TextField(
        controller: textEditingController,
        enabled: false,
        obscureText: true,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(16.0),
            border: outlineInputBorder,
            filled: true,
            fillColor: Colors.white30),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 21.0,
          color: isDark ? Colors.black : Colors.white,
        ),
      ),
    );
  }
}
