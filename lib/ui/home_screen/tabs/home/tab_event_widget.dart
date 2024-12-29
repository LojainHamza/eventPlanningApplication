import 'package:event_planning_app/providers/app_theme_provider.dart';
import 'package:event_planning_app/utils/myAppColors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabEventWidget extends StatelessWidget {
  final String eventName;
  final bool isSelected;
  final Color backgroundColor;
  final TextStyle selectedTextStyle;
  final TextStyle unSelectedTextStyle;
  final Color? borderColor;

  TabEventWidget({
    required this.eventName,
    required this.isSelected,
    required this.backgroundColor,
    required this.selectedTextStyle,
    required this.unSelectedTextStyle,
    this.borderColor,
  });

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
        color: isSelected ? backgroundColor : MyAppColors.transparentColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: borderColor ?? MyAppColors.primaryLight,
          width: 2,
        ),
      ),
      child: Text(
        eventName,
        style: isSelected
            ? (themeProvider.appTheme == ThemeMode.light
            ? selectedTextStyle
            : selectedTextStyle.copyWith(color: MyAppColors.blackColor))
            : (themeProvider.appTheme == ThemeMode.light
            ? unSelectedTextStyle
            : unSelectedTextStyle.copyWith(color: MyAppColors.primaryLight)),
      ),
    );
  }
}

/*
import 'package:event_planning_app/providers/app_theme_provider.dart';
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

 */
