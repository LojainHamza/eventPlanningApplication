import 'package:event_planning_app/utils/MyAppColors.dart';
import 'package:event_planning_app/utils/MyAppStyles.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  Color? backgroundColor;
  Color? borderSideColor;
  Widget? prefixIcon;
  String text;
  TextStyle? textStyle;
  Function onButtonClicked;
  CustomElevatedButton({required this.text, this.textStyle, this.backgroundColor, this.borderSideColor, this.prefixIcon, required this.onButtonClicked});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
            backgroundColor: backgroundColor ?? MyAppColors.primaryLight,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: borderSideColor ?? MyAppColors.primaryLight,
                    width: 2
              ),
            ),
            padding: EdgeInsets.symmetric(
                vertical: height*0.02,
                horizontal: width*0.05
            ),
        ),
        onPressed: (){
          onButtonClicked();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            prefixIcon ?? const SizedBox(),
            SizedBox(width: width*0.02),
            Text(text,style: textStyle ?? MyAppStyles.medium20White,)
          ],
        )
    );
  }
}
