import 'package:event_planning_app/providers/app_theme_provider.dart';
import 'package:event_planning_app/utils/MyAppStyles.dart';
import 'package:event_planning_app/utils/myAppColors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabEventWidget extends StatelessWidget {
  final String eventName;
  final bool isSelected;

  TabEventWidget({required this.eventName, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.05,
        vertical: height * 0.005,
      ),
      decoration: BoxDecoration(
        color: isSelected
            ? (themeProvider.appTheme == ThemeMode.light
            ? MyAppColors.whiteColor
            : MyAppColors.primaryLight)
            : MyAppColors.transparentColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: themeProvider.appTheme == ThemeMode.light
              ? MyAppColors.whiteColor
              : MyAppColors.primaryLight,
          width: 2,
        ),
      ),
      child: Text(
        eventName,
        style: TextStyle(
          color: isSelected
              ? (themeProvider.appTheme == ThemeMode.light
              ? MyAppColors.primaryLight
              : MyAppColors.whiteColor)
              : MyAppColors.whiteColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
