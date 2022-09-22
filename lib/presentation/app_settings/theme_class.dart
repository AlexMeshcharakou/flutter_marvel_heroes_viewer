import 'package:flutter/material.dart';

class ThemeClass {
  static ThemeData lightTheme = ThemeData(primarySwatch: Colors.red);

  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.dark(
        primary: Colors.red[900]!, secondary: Colors.red[900]!, surface: Colors.red[900]!, onSecondary: Colors.white),
  );
}
