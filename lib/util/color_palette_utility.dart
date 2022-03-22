import 'package:flutter/material.dart';

class ColorPaletteUtility {
  static Color orange = Color(0xFFFAA61A);
  static Color green = Color(0xFF7BC142);
  static Color yellow = Color(0xFFFDEC0A);
  static Color white = Color.fromRGBO(255, 255, 255, 1);
  
  static ButtonStyle elevatedButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Color(0xFF7BC142)),
    foregroundColor: MaterialStateProperty.all(Colors.white),
  );

  static ButtonStyle textButtonStyle = ButtonStyle(
    foregroundColor: MaterialStateProperty.all(Colors.black),
  );
}