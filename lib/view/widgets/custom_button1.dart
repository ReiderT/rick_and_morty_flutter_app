import 'package:flutter/material.dart';
import 'package:rick_and_morty_api/view/theme/app_theme.dart';

class CustomButton1 extends StatelessWidget {

  final VoidCallback? onPressed;
  final String? text;
  final double? fontSize;
  final Color? buttonColor;
  final TextStyle? style;

  const CustomButton1({
    super.key,
    this.onPressed,
    this.text,
    this.fontSize,
    this.buttonColor,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        //height: 46.0,
        padding: const EdgeInsets.only(left: 12.0, top: 24.0, right: 12.0, bottom: 24.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              AppDarkTheme.primaryColor,
              AppDarkTheme.primaryColor2
            ]
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Center(
          child: Text(
            text ?? '',
            style: style,
          ),
        ),
      ),
    );
  }
}