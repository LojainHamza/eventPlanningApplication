import 'package:event_planning_app/providers/app_language_provider.dart';
import 'package:event_planning_app/utils/MyAppColors.dart';
import 'package:event_planning_app/utils/MyAppStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () {
              // change language to english
              languageProvider.changeLanguage('en');
            },
            child: languageProvider.appLanguage == 'en'?
            getSelectedItemWidget(AppLocalizations.of(context)!.english):
            getUnSelectedItemWidget(AppLocalizations.of(context)!.english),
          ),
          SizedBox(height: height * 0.02),
          InkWell(
              onTap: () {
                // change language to arabic
                languageProvider.changeLanguage('ar');
              },
              child: languageProvider.appLanguage == 'ar'?
          getSelectedItemWidget(AppLocalizations.of(context)!.arabic):
          getUnSelectedItemWidget(AppLocalizations.of(context)!.arabic)),
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