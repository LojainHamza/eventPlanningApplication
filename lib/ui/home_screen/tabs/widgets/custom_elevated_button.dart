import 'package:event_planning_app/utils/MyAppColors.dart';
import 'package:event_planning_app/utils/MyAppStyles.dart';
import 'package:event_planning_app/utils/myAssetsManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomElevatedButton extends StatelessWidget {
  Color? backgroundColor;
  Widget? prefixIconButton;
  CustomElevatedButton({this.backgroundColor, this.prefixIconButton});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? MyAppColors.primaryLight,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            padding: EdgeInsets.symmetric(
                vertical: height*0.02,
                horizontal: width*0.05
            )
        ),
        onPressed: (){},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            prefixIconButton ?? const SizedBox(),
            SizedBox(width: width*0.02),
            Text(AppLocalizations.of(context)!.logout,style: MyAppStyles.medium20White,)
          ],
        )
    );
  }
}
