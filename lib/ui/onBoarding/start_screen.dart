import 'package:event_planning_app/providers/app_language_provider.dart';
import 'package:event_planning_app/providers/app_theme_provider.dart';
import 'package:event_planning_app/ui/onBoarding/onBoarding_view.dart';
import 'package:event_planning_app/utils/MyAppColors.dart';
import 'package:event_planning_app/utils/MyAppStyles.dart';
import 'package:event_planning_app/utils/myAssetsManager.dart';
import 'package:event_planning_app/widgets/custom_elevated_button.dart';
import 'package:event_planning_app/widgets/language_or_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class StartScreen extends StatelessWidget {
  static const String routeName = 'startScreen';

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeProvider.appTheme==ThemeMode.light?MyAppColors.whiteColor:MyAppColors.primaryDark,
        title: Image.asset(MyAssetsManager.eventTitleImage),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.03, vertical: height * 0.01),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Image.asset(MyAssetsManager.onBoarding1,
                      height: height * 0.45,
                      width: width * 0.85,
                      fit: BoxFit.fill)),
              SizedBox(height: height * 0.02),
              Text(AppLocalizations.of(context)!.title1onBoarding,
                  style: MyAppStyles.bold20Primary),
              SizedBox(height: height * 0.02),
              Text(AppLocalizations.of(context)!.description1onBoarding,
                  style: themeProvider.appTheme == ThemeMode.light?MyAppStyles.medium16Black:MyAppStyles.medium16White),
              SizedBox(height: height * 0.02),
              LanguageOrTheme(
                  text: AppLocalizations.of(context)!.language,
                  firstImage: MyAssetsManager.usaFlag,
                  onFirstImageTap: () {
                    languageProvider.changeLanguage('en');
                  },
                  secondImage: MyAssetsManager.egyptFlag,
                  onSecondImageTap: () {
                    languageProvider.changeLanguage('ar');
                  }),
              SizedBox(height: height * 0.02),
              LanguageOrTheme(
                text: AppLocalizations.of(context)!.theme,
                firstImage: MyAssetsManager.sunUnSelected,
                onFirstImageTap: () {
                  themeProvider.changeTheme(ThemeMode.light);
                },
                secondImage: MyAssetsManager.moonSelected,
                onSecondImageTap: () {
                  themeProvider.changeTheme(ThemeMode.dark);
                },
              ),
              SizedBox(height: height * 0.02),
              CustomElevatedButton(
                  text: AppLocalizations.of(context)!.letsStart,
                  onButtonClicked: () {
                    Navigator.of(context)
                        .pushReplacementNamed(OnboardingView.routeName);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
