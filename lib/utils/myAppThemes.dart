import 'package:event_planning_app/utils/MyAppColors.dart';
import 'package:event_planning_app/utils/MyAppStyles.dart';
import 'package:flutter/material.dart';

class MyAppThemes{
  static final ThemeData lightTheme = ThemeData(
    primaryColor: MyAppColors.primaryLight,
    scaffoldBackgroundColor: MyAppColors.whiteColor,
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
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: MyAppColors.transparentColor
    )
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: MyAppColors.primaryDark,
    scaffoldBackgroundColor: MyAppColors.primaryDark,
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
    bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: MyAppColors.transparentColor
      )
  );
}