


import 'package:flutter/material.dart';

class AppTheme {
  final lightTheme = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: const Color(0xFF448AFF)
  );

  final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorSchemeSeed: Color(0xFF98A6FF)
  );
}