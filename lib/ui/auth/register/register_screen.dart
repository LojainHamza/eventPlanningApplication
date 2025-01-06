import 'package:event_planning_app/firebase_utils.dart';
import 'package:event_planning_app/model/myUser.dart';
import 'package:event_planning_app/ui/home_screen/home_screen.dart';
import 'package:event_planning_app/utils/MyAppColors.dart';
import 'package:event_planning_app/utils/MyAppStyles.dart';
import 'package:event_planning_app/utils/dialog_utils.dart';
import 'package:event_planning_app/utils/myAssetsManager.dart';
import 'package:event_planning_app/widgets/custom_elevated_button.dart';
import 'package:event_planning_app/widgets/custom_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'registerScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isObscure = true;
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var rePasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

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
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Image.asset(
                  MyAssetsManager.logo,
                  width: width * 0.3,
                  height: height * 0.28,
                ),
                CustomTextField(
                  controller: nameController,
                    validator: (text){
                      if(text == null || text.trim().isEmpty){
                        return AppLocalizations.of(context)!.please_enter_name;
                      }
                      return null;
                    },
                    hintText: AppLocalizations.of(context)!.name,
                    prefixIcon: Image.asset(MyAssetsManager.nameIcon)
                ),
                SizedBox(height: height * 0.02),
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
                    prefixIcon: Image.asset(MyAssetsManager.emailIcon)
                ),
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
                  controller: rePasswordController,
                  validator: (text){
                    if(text == null || text.trim().isEmpty){
                      return AppLocalizations.of(context)!.please_re_enter_password;
                    }
                    if(text.length < 6){
                      return AppLocalizations.of(context)!.password_must_be_at_least_6_characters;
                    }
                    if(text != passwordController.text){
                      return AppLocalizations.of(context)!.re_password_does_not_match_password;
                    }
                    return null;
                  },
                  keyboardType: TextInputType.phone,
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
      ),
    );
  }
  void register()async{
    if(formKey.currentState?.validate() == true){
      DialogUtils.showLoading(context: context, message: AppLocalizations.of(context)!.loading);
      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        MyUser myUser = MyUser(
            id: credential.user?.uid?? '',
            name: nameController.text,
            email: emailController.text);
        await FirebaseUtils.addUserToFireStore(myUser);
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(context: context, message: AppLocalizations.of(context)!.registered_successfully,
        title: AppLocalizations.of(context)!.success,posActionName: AppLocalizations.of(context)!.ok,
        posAction: (){
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context: context, message: AppLocalizations.of(context)!.the_password_provided_is_too_weak,
          title: AppLocalizations.of(context)!.error,posActionName: AppLocalizations.of(context)!.ok);
        } else if (e.code == 'email-already-in-use') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context: context, message: AppLocalizations.of(context)!.the_account_already_exists_for_that_email,
          title: AppLocalizations.of(context)!.error,posActionName: AppLocalizations.of(context)!.ok);
        }
        else if (e.code == 'network-request-failed') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context: context, message: AppLocalizations.of(context)!.network_error,
              title: AppLocalizations.of(context)!.error,posActionName: AppLocalizations.of(context)!.ok);
        }
      } catch (e) {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(context: context, message: e.toString(),
        title: AppLocalizations.of(context)!.error,posActionName: AppLocalizations.of(context)!.ok);
      }
    }
    //Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
  }
}