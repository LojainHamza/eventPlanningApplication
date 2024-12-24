import 'package:event_planning_app/utils/MyAppStyles.dart';
import 'package:event_planning_app/utils/myAppColors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  Color? borderColor;
  String? hintText;
  String? labelText;
  TextStyle? hintStyle;
  TextStyle? labelStyle;
  TextStyle? style;
  Widget? prefixIcon;
  Widget? suffixIcon;
  bool obscureText;

  CustomTextField({this.borderColor,required this.hintText, this.labelText, this.hintStyle, this.labelStyle, this.style, this.prefixIcon, this.suffixIcon, this.obscureText=false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      obscuringCharacter: '*',
      cursorColor: MyAppColors.blackColor,
      style: style ?? MyAppStyles.medium16Black,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        hintStyle: hintStyle ?? MyAppStyles.medium16Gray,
        labelStyle: labelStyle ?? MyAppStyles.medium16Gray,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: borderColor ?? MyAppColors.grayColor,
            width: 2
          )
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
                color: borderColor ?? MyAppColors.grayColor,
                width: 2
            )
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
                color: MyAppColors.redColor,
                width: 2
            )
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
                color: MyAppColors.redColor,
                width: 2
            )
        ),
      ),
    );
  }
}
