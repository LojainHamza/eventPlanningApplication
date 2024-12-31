import 'package:event_planning_app/utils/MyAppColors.dart';
import 'package:event_planning_app/utils/MyAppStyles.dart';
import 'package:event_planning_app/utils/myAssetsManager.dart';
import 'package:flutter/material.dart';

class LanguageOrTheme extends StatelessWidget {
  String text;
  String firstImage;
  String secondImage;
  LanguageOrTheme({required this.text,required this.firstImage,required this.secondImage});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Expanded(child: Text(text,style: MyAppStyles.medium20Primary)),
        Container(
          width: width*0.15,
          padding: EdgeInsets.symmetric(
              horizontal: width*0.002
          ),
          decoration: BoxDecoration(
              color: MyAppColors.transparentColor,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                  color: MyAppColors.primaryLight
              )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(firstImage),
              Image.asset(secondImage)
            ],
          ),
        ),
      ],
    );
  }
}
