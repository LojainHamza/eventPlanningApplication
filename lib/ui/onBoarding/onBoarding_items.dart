import 'package:event_planning_app/ui/onBoarding/onBoarding_model.dart';
import 'package:event_planning_app/utils/MyAppStyles.dart';
import 'package:event_planning_app/utils/myAssetsManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnBoardingItems {
  List<OnBoardingModel> items;

  OnBoardingItems(BuildContext context)
      : items = [
    OnBoardingModel(
      image: MyAssetsManager.onBoarding2,
      title: AppLocalizations.of(context)!.title2onBoarding,
      description: AppLocalizations.of(context)!.description2onBoarding,
    ),
    OnBoardingModel(
      image: MyAssetsManager.onBoarding3,
      title: AppLocalizations.of(context)!.title3onBoarding,
      description: AppLocalizations.of(context)!.description3onBoarding,
    ),
    OnBoardingModel(
      image: MyAssetsManager.onBoarding4,
      title: AppLocalizations.of(context)!.title4onBoarding,
      description: AppLocalizations.of(context)!.description4onBoarding,
    ),
  ];
}
