import 'package:event_planning_app/providers/app_language_provider.dart';
import 'package:event_planning_app/providers/app_theme_provider.dart';
import 'package:event_planning_app/ui/home_screen/language_bottom_sheet.dart';
import 'package:event_planning_app/ui/home_screen/theme_bottom_sheet.dart';
import 'package:event_planning_app/utils/MyAppColors.dart';
import 'package:event_planning_app/utils/MyAppStyles.dart';
import 'package:event_planning_app/utils/myAssetsManager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileTap extends StatefulWidget {
  const ProfileTap({super.key});

  @override
  State<ProfileTap> createState() => _ProfileTapState();
}

class _ProfileTapState extends State<ProfileTap> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyAppColors.primaryLight,
        toolbarHeight: height*0.2,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(60)
            )
        ),
        title: Row(
          children: [
            Image.asset(MyAssetsManager.routeLogo),
            SizedBox(width: width*0.03),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('John Safwat',style: MyAppStyles.bold24White,),
                Text('johnsafwat.route@gmail.com',style: MyAppStyles.medium16White,)
              ],
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.language,
                style: themeProvider.appTheme == ThemeMode.light?
                MyAppStyles.bold20Black:
                MyAppStyles.bold20White
            ),
            SizedBox(height: height * 0.02),
            InkWell(
              onTap: () {
                showLanguageBottomSheet();
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: MyAppColors.primaryLight, width: 2)),
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
                          color: MyAppColors.primaryLight,
                          size: 30)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.02),
            Text(AppLocalizations.of(context)!.theme,
                style: themeProvider.appTheme == ThemeMode.light?
                MyAppStyles.bold20Black:
                MyAppStyles.bold20White
            ),
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
                          color: MyAppColors.primaryLight,
                          size: 30)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: height*0.2),
            InkWell(
                onTap: (){},
                child: Image.asset(MyAssetsManager.logoutButton)),
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