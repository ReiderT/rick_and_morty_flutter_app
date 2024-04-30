import 'package:flutter/material.dart';

abstract class AppDarkTheme {

  static Color whiteColor = const Color(0xFFF5F5F5);
  static Color grayColor = const Color(0xFF90919D);
  static Color primaryColor = const Color(0xFF00F5A0);
  static Color primaryColor2 = const Color(0xFF00D9F5);
  static Color black900 = const Color(0xFF12111A);
  static Color black800 = const Color(0xFF191825);
  static Color black600 = const Color(0xFF242235);
  static Color black700 = const Color(0xFF1B1A28);
  static Color buttonActiveLabel = const Color(0xFF0C134F);
  static Color pink400 = const Color(0xFFFFA3FD);
  static Color green500 = const Color(0xFF16FF00);
  static Color red400 = const Color(0xFFFC4A4A);

  static ThemeData dark = ThemeData(
    useMaterial3: true,
    fontFamily: 'Nunito',
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: AppDarkTheme.black600,
      surfaceTintColor: AppDarkTheme.black600,
      iconTheme: const IconThemeData(
        color: Colors.white,
      )
    ),
    scaffoldBackgroundColor: AppDarkTheme.black900,
  );
}