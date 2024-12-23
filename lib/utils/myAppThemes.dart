import 'package:event_planning_app/utils/MyAppColors.dart';
import 'package:event_planning_app/utils/MyAppStyles.dart';
import 'package:flutter/material.dart';

class MyAppThemes{
  static final ThemeData lightTheme = ThemeData(
    primaryColor: MyAppColors.primaryLight,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      showUnselectedLabels: true,
      unselectedLabelStyle: MyAppStyles.bold12White,
      selectedLabelStyle: MyAppStyles.bold12White,
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: MyAppColors.primaryLight,
      shape: StadiumBorder(
          side: BorderSide(
          color: MyAppColors.whiteColor,
          width: 4
        )
      ),
    ),
    scaffoldBackgroundColor: MyAppColors.whiteColor
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: MyAppColors.primaryDark,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      showUnselectedLabels: true,
        unselectedLabelStyle: MyAppStyles.bold12White,
        selectedLabelStyle: MyAppStyles.bold12White,
        elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: MyAppColors.primaryDark,
        shape: StadiumBorder(
          side: BorderSide(
          color: MyAppColors.whiteColor,
          width: 4
        )
      )
    ),
    scaffoldBackgroundColor: MyAppColors.primaryDark
  );
}