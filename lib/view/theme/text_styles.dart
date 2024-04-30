import 'package:flutter/material.dart';
import 'package:rick_and_morty_api/view/theme/app_theme.dart';

abstract class TextStyles {

  static FontWeight fontWeightRegular = FontWeight.normal;  
  static FontWeight fontWeightMedium = FontWeight.w500; 
  static FontWeight fontWeightSemiBold = FontWeight.w600; 
  static FontWeight fontWeightBold = FontWeight.bold;

  static TextStyle body1({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    return TextStyle (
      fontFamily: 'Nunito',
      color: color ?? AppDarkTheme.whiteColor,
      fontSize: fontSize ?? 16.0,
      fontWeight: fontWeight ?? fontWeightBold,
    );
  }

  static TextStyle body2({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    return TextStyle (
      fontFamily: 'Nunito',
      color: color ?? AppDarkTheme.whiteColor,
      fontSize: fontSize ?? 14.0,
      fontWeight: fontWeight ?? fontWeightBold,
    );
  }

  static TextStyle display1({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    return TextStyle (
      fontFamily: 'Nunito',
      color: color ?? AppDarkTheme.whiteColor,
      fontSize: fontSize ?? 28.0,
      fontWeight: fontWeightSemiBold,
    );
  }

  static TextStyle display2({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    return TextStyle (
      fontFamily: 'Nunito',
      color: color ?? AppDarkTheme.whiteColor,
      fontSize: fontSize ?? 32.0,
      fontWeight: fontWeightBold,
    );
  }

  static TextStyle display3({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    return TextStyle (
      fontFamily: 'Nunito',
      color: color ?? AppDarkTheme.whiteColor,
      fontSize: fontSize ?? 40.0,
      fontWeight: fontWeightMedium,
    );
  }
} 


