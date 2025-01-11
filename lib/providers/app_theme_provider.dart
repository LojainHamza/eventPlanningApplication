import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppThemeProvider extends ChangeNotifier {
  /// Data: Current app theme
  ThemeMode appTheme = ThemeMode.light;

  /// Load saved theme from Shared Preferences
  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool('isDarkMode') ?? false; // Default to light mode
    appTheme = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  /// Function to change theme and save it
  Future<void> changeTheme(ThemeMode newTheme) async {
    if (appTheme == newTheme) {
      return;
    }
    appTheme = newTheme;
    notifyListeners();

    /// Save the selected theme in Shared Preferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', appTheme == ThemeMode.dark);
  }

  /// Check if the current theme is dark mode
  bool isDarkMode() {
    return appTheme == ThemeMode.dark;
  }
}
