import 'package:flutter/material.dart';

class AppLanguageProvider extends ChangeNotifier{
  /// data
  String appLanguage = 'en';
  /// function
  void changeLanguage(String newLanguage){
    if(appLanguage == newLanguage){
      return;
    }
    appLanguage = newLanguage;
    notifyListeners();
  }
}