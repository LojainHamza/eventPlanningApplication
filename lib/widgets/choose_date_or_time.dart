import 'package:event_planning_app/providers/app_theme_provider.dart';
import 'package:event_planning_app/utils/MyAppColors.dart';
import 'package:event_planning_app/utils/MyAppStyles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChooseDateOrTime extends StatelessWidget {
  String iconName;
  String eventNameOrTime;
  String chooseEventNameOrTime;
  Function onChooseDateOrTime;
  ChooseDateOrTime({required this.iconName,required this.eventNameOrTime,required this.chooseEventNameOrTime,required this.onChooseDateOrTime});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Row(
      children: [
        Image.asset(iconName,color: themeProvider.appTheme == ThemeMode.light? MyAppColors.blackColor:MyAppColors.whiteColor),
        SizedBox(width: width*0.04),
        Expanded(child: Text(eventNameOrTime,style: themeProvider.appTheme == ThemeMode.light?MyAppStyles.medium16Black:MyAppStyles.medium16White)),
        TextButton(onPressed: (){
          onChooseDateOrTime();
        },
            child: Text(chooseEventNameOrTime,style: MyAppStyles.medium16Primary))
      ],
    );
  }
}
