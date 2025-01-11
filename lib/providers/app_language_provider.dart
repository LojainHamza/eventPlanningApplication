import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguageProvider extends ChangeNotifier {
  /// Current language (default: English)
  String appLanguage = 'en';

  /// Load saved language from Shared Preferences
  Future<void> loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    appLanguage = prefs.getString('appLanguage') ?? 'en'; // Default to English
    notifyListeners();
  }

  /// Change language and save it
  Future<void> changeLanguage(String newLanguage) async {
    if (appLanguage == newLanguage) {
      return;
    }
    appLanguage = newLanguage;
    notifyListeners();

    /// Save the selected language in Shared Preferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('appLanguage', newLanguage);
  }
}
