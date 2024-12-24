import 'package:event_planning_app/ui/home_screen/home_screen.dart';
import 'package:event_planning_app/utils/MyAppColors.dart';
import 'package:event_planning_app/utils/MyAppStyles.dart';
import 'package:event_planning_app/utils/myAssetsManager.dart';
import 'package:event_planning_app/widgets/custom_elevated_button.dart';
import 'package:event_planning_app/widgets/custom_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'registerScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.register,style: MyAppStyles.medium18Black),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                MyAssetsManager.logo,
                width: width * 0.3,
                height: height * 0.28,
              ),
              CustomTextField(
                  hintText: AppLocalizations.of(context)!.name,
                  prefixIcon: Image.asset(MyAssetsManager.nameIcon)),
              SizedBox(height: height * 0.02),
              CustomTextField(
                  hintText: AppLocalizations.of(context)!.email,
                  prefixIcon: Image.asset(MyAssetsManager.emailIcon)),
              SizedBox(height: height * 0.02),
              CustomTextField(
                obscureText: isObscure,
                hintText: AppLocalizations.of(context)!.password,
                prefixIcon: Image.asset(MyAssetsManager.passwordIcon),
                suffixIcon: IconButton(
                  icon: Icon(
                    isObscure ? Icons.visibility_off : Icons.visibility,
                    color: MyAppColors.grayColor,
                  ),
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                ),
              ),
              SizedBox(height: height * 0.02),
              CustomTextField(
                obscureText: isObscure,
                hintText: AppLocalizations.of(context)!.rePassword,
                prefixIcon: Image.asset(MyAssetsManager.passwordIcon),
                suffixIcon: IconButton(
                  icon: Icon(
                    isObscure ? Icons.visibility_off : Icons.visibility,
                    color: MyAppColors.grayColor,
                  ),
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                ),
              ),
              SizedBox(height: height * 0.01),
              CustomElevatedButton(text: AppLocalizations.of(context)!.createAccount,
              onButtonClicked: register),
              SizedBox(height: height * 0.03),
              Text.rich(
                textAlign: TextAlign.center,
                  TextSpan(
                    children: [
                      TextSpan(text: AppLocalizations.of(context)!.alreadyHaveAccount,style: MyAppStyles.medium16Black),
                      WidgetSpan(
                        child: SizedBox(width: width*0.03),
                      ),
                      TextSpan(text: AppLocalizations.of(context)!.login,
                          recognizer: TapGestureRecognizer()..onTap=(){
                        Navigator.of(context).pop();
                          },style: MyAppStyles.bold16Primary.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: MyAppColors.primaryLight
                      ))
                    ]
                  )
              ),
              SizedBox(height: height * 0.02),
              Container(
                width: width*0.15,
                padding: EdgeInsets.symmetric(
                  horizontal: width*0.002
                ),
                decoration: BoxDecoration(
                  color: MyAppColors.transparentColor,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: MyAppColors.primaryLight
                  )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(MyAssetsManager.usaFlag),
                    Image.asset(MyAssetsManager.egyptFlag)
                  ],
                ),
              ),
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