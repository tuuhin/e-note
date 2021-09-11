import 'package:flutter/material.dart';

class ColorPalette {
  static const Color mainPrimaryCOlor = Colors.blue;

  static const Color mainBackgroundColor = Colors.white;

  static const TextStyle cancelText =
      TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w600);

  static const TextStyle deleteStyle =
      TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.w600);

  static const TextStyle normalText = TextStyle(color: Colors.black);

  static const UnderlineInputBorder noBorder =
      UnderlineInputBorder(borderSide: BorderSide.none);

  static const containerDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
        topRight: Radius.circular(25), topLeft: Radius.circular(25)),
  );
}
