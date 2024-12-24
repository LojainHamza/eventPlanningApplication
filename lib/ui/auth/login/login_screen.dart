import 'package:event_planning_app/ui/auth/forget_password/forget_password_screen.dart';
import 'package:event_planning_app/ui/auth/register/register_screen.dart';
import 'package:event_planning_app/ui/home_screen/home_screen.dart';
import 'package:event_planning_app/utils/MyAppColors.dart';
import 'package:event_planning_app/utils/MyAppStyles.dart';
import 'package:event_planning_app/utils/myAssetsManager.dart';
import 'package:event_planning_app/widgets/custom_elevated_button.dart';
import 'package:event_planning_app/widgets/custom_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'loginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                MyAssetsManager.logo,
                width: width * 0.3,
                height: height * 0.33,
              ),
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
              SizedBox(height: height * 0.01),
              TextButton(
                  onPressed: (){
                    Navigator.of(context).pushNamed(ForgetPassword.routeName);
                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(AppLocalizations.of(context)!.forgetPassword,
                      style: MyAppStyles.bold16Primary.copyWith(
                      decoration: TextDecoration.underline,
                        decorationColor: MyAppColors.primaryLight,
                        decorationThickness: 1.5
                    ),
                   ),
                  )
              ),
              SizedBox(height: height * 0.01),
              CustomElevatedButton(text: AppLocalizations.of(context)!.login,
                onButtonClicked: login
              ),
              SizedBox(height: height * 0.03),
              Text.rich(
                textAlign: TextAlign.center,
                  TextSpan(
                    children: [
                      TextSpan(text: AppLocalizations.of(context)!.doNotHaveAccount,style: MyAppStyles.medium16Black),
                      WidgetSpan(
                        child: SizedBox(width: width*0.03),
                      ),
                      TextSpan(text: AppLocalizations.of(context)!.createAccount,
                          recognizer: TapGestureRecognizer()..onTap = (){
                        Navigator.of(context).pushNamed(RegisterScreen.routeName);
                      },
                          style: MyAppStyles.bold16Primary.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: MyAppColors.primaryLight,
                      ))
                    ]
                  )
              ),
              SizedBox(height: height * 0.03),
              Row(
                children: [
                  const Expanded(
                    child: Divider(
                      thickness: 2,
                      indent: 20,
                      endIndent: 20,
                      color: MyAppColors.primaryLight,
                    ),
                  ),
                  Text(AppLocalizations.of(context)!.or,style: MyAppStyles.medium16Primary,),
                  const Expanded(
                    child: Divider(
                      thickness: 2,
                      indent: 20,
                      endIndent: 20,
                      color: MyAppColors.primaryLight,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.02),
              CustomElevatedButton(text: AppLocalizations.of(context)!.loginWithGoogle,
              onButtonClicked: (){
                // todo: navigate to login with google screen
              },
              textStyle: MyAppStyles.medium20Primary,
              prefixIcon: Image.asset(MyAssetsManager.googleIcon),
              backgroundColor: MyAppColors.transparentColor),
              SizedBox(height: height * 0.03),
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
  void login(){
    Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
  }
}