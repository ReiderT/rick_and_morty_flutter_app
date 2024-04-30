import 'package:flutter/material.dart';
import 'package:rick_and_morty_api/view/theme/app_theme.dart';

class CustomGradient extends StatelessWidget {

  final Gradient? gradient;
  final Widget widget;

  const CustomGradient({
    super.key,
    this.gradient,
    required this.widget,
  });

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
    return Center(
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return (gradient != null) ? 
           gradient!.createShader(bounds)
           : defaultGradient.createShader(bounds);
        },
        child: widget,
      ),
    );
  }
}