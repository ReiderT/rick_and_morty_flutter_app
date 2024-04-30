import 'package:flutter/material.dart';
import 'package:rick_and_morty_api/view/theme/app_theme.dart';

abstract class TextFieldStyle1 {

  static InputDecoration textFieldDecoration({
    Color? focusedBorderColor,
    String? hintText,
    bool? obscureText,
    bool? filled,
    Color? fillColor,
    TextAlign? textAlign,
  }) {
    return InputDecoration(
      fillColor: fillColor ?? AppDarkTheme.black600, 
      filled: filled ?? true,
      hintText: hintText ?? '',
      hintStyle: TextStyle(color: AppDarkTheme.grayColor),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: BorderSide(color: AppDarkTheme.black600),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: BorderSide(color: AppDarkTheme.primaryColor),
      ),  
    );
  }

}