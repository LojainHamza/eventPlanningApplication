import 'package:event_planning_app/utils/MyAppColors.dart';
import 'package:flutter/material.dart';

class MyAppThemes{
  static final ThemeData lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      color: MyAppColors.primaryLight
    )
  );
  static final ThemeData darkTheme = ThemeData(
      appBarTheme: const AppBarTheme(
          color: MyAppColors.primaryDark
      )
  );
}