import 'package:event_planning_app/providers/app_theme_provider.dart';
import 'package:event_planning_app/ui/home_screen/home_screen.dart';
import 'package:event_planning_app/utils/MyAppColors.dart';
import 'package:event_planning_app/utils/MyAppStyles.dart';
import 'package:event_planning_app/utils/myAssetsManager.dart';
import 'package:event_planning_app/widgets/custom_elevated_button.dart';
import 'package:event_planning_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ForgetPassword extends StatefulWidget {
  static const String routeName = 'forgetPassword';

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: themeProvider.appTheme==ThemeMode.light?MyAppColors.blackColor:MyAppColors.whiteColor
        ),
        backgroundColor: themeProvider.appTheme==ThemeMode.light?MyAppColors.whiteColor:MyAppColors.primaryDark,
        title: Text(AppLocalizations.of(context)!.forgetPassword,style: themeProvider.appTheme==ThemeMode.light?MyAppStyles.medium16Black:MyAppStyles.medium16White),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                MyAssetsManager.forgetPasswordImage,
                width: width * 0.5,
                height: height * 0.5,
              ),
              CustomTextField(
                  hintText: AppLocalizations.of(context)!.email,
                  style: TextStyle(color: themeProvider.appTheme==ThemeMode.light?MyAppColors.blackColor:MyAppColors.whiteColor),
                  prefixIcon: Image.asset(MyAssetsManager.emailIcon)),
              SizedBox(height: height * 0.05),
              CustomElevatedButton(text: AppLocalizations.of(context)!.resetPassword,
              onButtonClicked: (){
                // todo: reset password functionality
              }),
            ],
          ),
        ),
      ),
    );
  }
  void register(){
    Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
  }
}