import 'package:event_planning_app/firebase_utils.dart';
import 'package:event_planning_app/model/myUser.dart';
import 'package:event_planning_app/providers/app_language_provider.dart';
import 'package:event_planning_app/providers/app_theme_provider.dart';
import 'package:event_planning_app/providers/user_provider.dart';
import 'package:event_planning_app/ui/auth/forget_password/forget_password_screen.dart';
import 'package:event_planning_app/ui/auth/register/register_screen.dart';
import 'package:event_planning_app/ui/home_screen/home_screen.dart';
import 'package:event_planning_app/utils/MyAppColors.dart';
import 'package:event_planning_app/utils/MyAppStyles.dart';
import 'package:event_planning_app/utils/dialog_utils.dart';
import 'package:event_planning_app/utils/myAssetsManager.dart';
import 'package:event_planning_app/widgets/custom_elevated_button.dart';
import 'package:event_planning_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'loginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isObscure = true;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Image.asset(
                  MyAssetsManager.logo,
                  width: width * 0.3,
                  height: height * 0.33,
                ),
                CustomTextField(
                    controller: emailController,
                    validator: (text){
                      if(text == null || text.trim().isEmpty){
                        return AppLocalizations.of(context)!.please_enter_email;
                      }
                      final bool emailValid =
                      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(text);
                      if(!emailValid){
                        return AppLocalizations.of(context)!.please_enter_valid_email;
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    hintText: AppLocalizations.of(context)!.email,
                    style: TextStyle(color: themeProvider.appTheme==ThemeMode.light?MyAppColors.blackColor:MyAppColors.whiteColor),
                    prefixIcon: Image.asset(MyAssetsManager.emailIcon)),
                SizedBox(height: height * 0.02),
                CustomTextField(
                  controller: passwordController,
                  validator: (text){
                    if(text == null || text.trim().isEmpty){
                      return AppLocalizations.of(context)!.please_enter_password;
                    }
                    if(text.length < 6){
                      return AppLocalizations.of(context)!.password_must_be_at_least_6_characters;
                    }
                    return null;
                  },
                  keyboardType: TextInputType.phone,
                  obscureText: isObscure,
                  hintText: AppLocalizations.of(context)!.password,
                  style: TextStyle(color: themeProvider.appTheme==ThemeMode.light?MyAppColors.blackColor:MyAppColors.whiteColor),
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
                        TextSpan(text: AppLocalizations.of(context)!.doNotHaveAccount,style: themeProvider.appTheme==ThemeMode.light?MyAppStyles.medium16Black:MyAppStyles.medium16White),
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
                      InkWell(
                        onTap:(){
                          languageProvider.changeLanguage('en');
                          },
                          child: Image.asset(MyAssetsManager.usaFlag)),
                      InkWell(
                          onTap:(){
                            languageProvider.changeLanguage('ar');
                          },
                          child: Image.asset(MyAssetsManager.egyptFlag))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void login() async {
    if (formKey.currentState?.validate() == true) {
      DialogUtils.showLoading(context: context, message: 'Loading..');
      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text
        );
        var user = await FirebaseUtils.readUserFromFireStore(credential.user?.uid ?? '');
        if (user == null) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context: context, message: AppLocalizations.of(context)!.no_user_found_for_that_email,
              title: AppLocalizations.of(context)!.error, posActionName: AppLocalizations.of(context)!.ok);
          return;
        }
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(user);
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(context: context, message: AppLocalizations.of(context)!.login_successfully,
            title: AppLocalizations.of(context)!.success, posActionName: AppLocalizations.of(context)!.ok,
            posAction: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            });
      } on FirebaseAuthException catch (e) {
        DialogUtils.hideLoading(context);
        if (e.code == 'user-not-found') {
          DialogUtils.showMessage(context: context, message: AppLocalizations.of(context)!.no_user_found_for_that_email,
              title: AppLocalizations.of(context)!.error, posActionName: AppLocalizations.of(context)!.ok);
        } else if (e.code == 'wrong-password') {
          DialogUtils.showMessage(context: context, message: AppLocalizations.of(context)!.wrong_password_provided_for_that_user,
              title: AppLocalizations.of(context)!.error, posActionName: AppLocalizations.of(context)!.ok);
        } else if (e.code == 'invalid-credential') {
          DialogUtils.showMessage(context: context, message: AppLocalizations.of(context)!.the_supplied_auth_credential_is_incorrect_malformed_or_has_expired,
              title: AppLocalizations.of(context)!.error, posActionName: AppLocalizations.of(context)!.ok);
        } else if (e.code == 'network-request-failed') {
          DialogUtils.showMessage(context: context, message: AppLocalizations.of(context)!.network_error,
              title: AppLocalizations.of(context)!.error, posActionName: AppLocalizations.of(context)!.ok);
        }
      } catch (e) {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(context: context, message: e.toString(),
            title: AppLocalizations.of(context)!.error, posActionName: AppLocalizations.of(context)!.ok);
      }
    }
  }

}