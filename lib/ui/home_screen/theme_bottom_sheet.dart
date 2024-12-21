import 'package:event_planning_app/providers/app_language_provider.dart';
import 'package:event_planning_app/providers/app_theme_provider.dart';
import 'package:event_planning_app/utils/MyAppColors.dart';
import 'package:event_planning_app/utils/MyAppStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ThemeBottomSheet extends StatefulWidget {
  const ThemeBottomSheet({super.key});

  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () {
              // change theme to dark
              themeProvider.changeTheme(ThemeMode.dark);
            },
            child: themeProvider.isDarkMode()?
            getSelectedItemWidget(AppLocalizations.of(context)!.dark):
            getUnSelectedItemWidget(AppLocalizations.of(context)!.dark),
          ),
          SizedBox(height: height * 0.02),
          InkWell(
              onTap: () {
                // change theme to light
                themeProvider.changeTheme(ThemeMode.light);
              },
              child: themeProvider.isDarkMode()?
          getUnSelectedItemWidget(AppLocalizations.of(context)!.light):
          getSelectedItemWidget(AppLocalizations.of(context)!.light)),
        ],
      ),
    );
  }

  Widget getSelectedItemWidget(String text){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: MyAppStyles.bold20Primary,
        ),
        const Icon(
          Icons.check,
          size: 25,
          color: MyAppColors.primaryLight,
        )
      ],
    );
  }
  Widget getUnSelectedItemWidget(String text){
    return Text(
      text,
      style: MyAppStyles.bold20Black,
    );
  }
}
