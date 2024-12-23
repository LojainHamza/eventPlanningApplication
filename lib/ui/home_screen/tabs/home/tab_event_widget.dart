import 'package:event_planning_app/utils/MyAppStyles.dart';
import 'package:event_planning_app/utils/myAppColors.dart';
import 'package:flutter/material.dart';

class TabEventWidget extends StatelessWidget {
  String eventName;
  bool isSelected;
  TabEventWidget({required this.eventName,required this.isSelected});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width*0.05,
        vertical: height*0.005
      ),
      decoration: BoxDecoration(
        color: isSelected? MyAppColors.whiteColor:MyAppColors.transparentColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: MyAppColors.whiteColor,
          width: 2
        )
      ),
      child: Text(eventName,
      style: isSelected? MyAppStyles.medium16Primary:MyAppStyles.medium16White,),
    );
  }
}
