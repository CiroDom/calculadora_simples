import 'package:flutter/material.dart';

class Temas {
  static ThemeData modo_light = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.pink,
    iconTheme: IconThemeData(color: Colors.pink),
  );

  static ThemeData modo_dark = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.pink,
  );

}