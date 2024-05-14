import 'package:flutter/material.dart';
import 'package:rick_and_morty_api/view/theme/app_theme.dart';

class CustomGradient extends StatelessWidget {

  const CustomGradient({
    super.key,
    this.gradient,
    required this.widget,
    this.alignment = false,
  });

  final Gradient? gradient;
  final Widget widget;
  final bool alignment;

  static Gradient defaultGradient = LinearGradient (
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      AppDarkTheme.primaryColor,
      AppDarkTheme.primaryColor2,
    ]
  );

  @override
  Widget build(BuildContext context) {

    ShaderMask shaderMask = ShaderMask(
      shaderCallback: (Rect bounds) {
        return (gradient ?? defaultGradient).createShader(bounds);
      },
      child: widget,
    );

    return alignment ? shaderMask : Center(child: shaderMask);
  }
}