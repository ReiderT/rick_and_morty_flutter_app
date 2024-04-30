import 'package:flutter/material.dart';
import 'package:rick_and_morty_api/view/theme/app_theme.dart';
import 'package:rick_and_morty_api/view/theme/text_styles.dart';

class CustomTextField extends StatelessWidget {

  final String? title;
  final TextEditingController? controller;
  final bool? obscureText;
  final InputDecoration? decoration;
  final void Function(String)? onSubmitted;

  const CustomTextField({
    super.key,
    this.title,
    this.controller,
    this.obscureText, 
    this.decoration,
    this.onSubmitted
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          title ?? '',
          style: TextStyles.body2(),
        ),
        const SizedBox(height: 5.0,),
        TextField(
          controller: controller,
          obscureText: obscureText ?? false,
          style: TextStyle(color: AppDarkTheme.whiteColor),
          decoration: decoration,
          cursorColor: AppDarkTheme.primaryColor,
          //onChanged: onSubmitted,
          onSubmitted: onSubmitted,
        )
      ]
    );
  }
}
