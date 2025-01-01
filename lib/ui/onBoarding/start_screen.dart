import 'package:event_planning_app/ui/onBoarding/onBoarding_view.dart';
import 'package:event_planning_app/utils/MyAppStyles.dart';
import 'package:event_planning_app/utils/myAssetsManager.dart';
import 'package:event_planning_app/widgets/custom_elevated_button.dart';
import 'package:event_planning_app/widgets/language_or_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StartScreen extends StatelessWidget {
  static const String routeName = 'startScreen';

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(MyAssetsManager.eventTitleImage),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width*0.03,
            vertical: height*0.01
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image.asset(MyAssetsManager.onBoarding1,height: height*0.45,width: width*0.85,fit: BoxFit.fill)),
              SizedBox(height: height*0.02),
              Text(AppLocalizations.of(context)!.title1onBoarding,style: MyAppStyles.bold20Primary),
              SizedBox(height: height*0.02),
              Text(AppLocalizations.of(context)!.description1onBoarding,style: MyAppStyles.medium16Black),
              SizedBox(height: height*0.02),
              LanguageOrTheme(text: AppLocalizations.of(context)!.language, firstImage: MyAssetsManager.usaFlag, secondImage: MyAssetsManager.egyptFlag),
              SizedBox(height: height*0.02),
              LanguageOrTheme(text: AppLocalizations.of(context)!.theme, firstImage: MyAssetsManager.sunUnSelected, secondImage: MyAssetsManager.moonSelected),
              SizedBox(height: height*0.02),
              CustomElevatedButton(text: AppLocalizations.of(context)!.letsStart,
                  onButtonClicked: (){Navigator.of(context).pushReplacementNamed(OnboardingView.routeName);
              })
          
            ],
          ),
        ),
      ),
    );
  }
}
