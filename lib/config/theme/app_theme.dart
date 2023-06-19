

import 'package:flutter/material.dart';

ThemeData appThemeData() {
    return ThemeData(
          primarySwatch: Colors.blue,

          appBarTheme: AppBarTheme(
            backgroundColor: Colors.blue.shade900
          ),

          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: Colors.blue.shade900
          ),

          drawerTheme: DrawerThemeData(
            
          )
        );
  }

ThemeData appThemeDataDark() {
    return ThemeData(
      colorScheme: ColorScheme(
        background: Colors.black54, 
        brightness: Brightness.dark,
        primary: Colors.blue.shade900,
        onPrimary: Colors.blue.shade100,
        secondary: Colors.blue.shade600,
        onSecondary: Colors.blue,
        error: Colors.red,
        onError: Colors.red,
        onBackground: Colors.blue.shade800, 
        onSurface:  Colors.white, 
        surface:  Colors.blue.shade800,
      ),

    drawerTheme: DrawerThemeData(

    )
    );
  }