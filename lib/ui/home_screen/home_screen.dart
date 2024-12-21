import 'package:event_planning_app/providers/app_language_provider.dart';
import 'package:event_planning_app/providers/app_theme_provider.dart';
import 'package:event_planning_app/ui/home_screen/language_bottom_sheet.dart';
import 'package:event_planning_app/ui/home_screen/theme_bottom_sheet.dart';
import 'package:event_planning_app/utils/MyAppColors.dart';
import 'package:event_planning_app/utils/MyAppStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'homeScreen';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.language,
                style: MyAppStyles.bold20Black),
            SizedBox(height: height * 0.02),
            InkWell(
              onTap: () {
                showLanguageBottomSheet();
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border:
                        Border.all(color: MyAppColors.primaryLight, width: 2)),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          languageProvider.appLanguage == 'en'
                              ? AppLocalizations.of(context)!.english
                              : AppLocalizations.of(context)!.arabic,
                          style: MyAppStyles.bold20Primary),
                      SizedBox(height: height * 0.02),
                      const Icon(Icons.arrow_drop_down,
                          color: MyAppColors.primaryLight)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.02),
            Text(AppLocalizations.of(context)!.theme,
                style: MyAppStyles.bold20Black),
            SizedBox(height: height * 0.02),
            InkWell(
              onTap: () {
                showThemeBottomSheet();
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border:
                    Border.all(color: MyAppColors.primaryLight, width: 2)),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        themeProvider.isDarkMode()?
                          AppLocalizations.of(context)!.dark:
                        AppLocalizations.of(context)!.light,
                          style: MyAppStyles.bold20Primary),
                      SizedBox(height: height * 0.02),
                      const Icon(Icons.arrow_drop_down,
                          color: MyAppColors.primaryLight)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
        context: context, builder: (context) => LanguageBottomSheet());
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
        context: context, builder: (context) => ThemeBottomSheet());
  }
}
