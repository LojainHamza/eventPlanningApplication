import 'package:event_planning_app/ui/auth/login/login_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreenViewModel extends ChangeNotifier{
  //todo: hold data & handle logic
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  late LoginNavigator navigator;

  void login()async{
    if (formKey.currentState?.validate() == true) {
    navigator.showMyMessage('Loading..');
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
      );
      // var user = await FirebaseUtils.readUserFromFireStore(credential.user?.uid ?? '');
      // if (user == null) {
      //   DialogUtils.hideLoading(context);
      //   DialogUtils.showMessage(context: context, message: AppLocalizations.of(context)!.no_user_found_for_that_email,
      //       title: AppLocalizations.of(context)!.error, posActionName: AppLocalizations.of(context)!.ok);
      //   return;
      // }
      // var userProvider = Provider.of<UserProvider>(context, listen: false);
      // userProvider.updateUser(user);
      navigator.hideMyLoading();
      navigator.showMyMessage('Login Successfully');
      // DialogUtils.showMessage(context: context, message: AppLocalizations.of(context)!.login_successfully,
      //     title: AppLocalizations.of(context)!.success, posActionName: AppLocalizations.of(context)!.ok,
      //     posAction: () {
      //       Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      //     });
    } on FirebaseAuthException catch (e) {
      navigator.hideMyLoading();
      if (e.code == 'user-not-found') {
        navigator.showMyMessage('No User Found For That Email');
        // DialogUtils.showMessage(context: context, message: AppLocalizations.of(context)!.no_user_found_for_that_email,
        //     title: AppLocalizations.of(context)!.error, posActionName: AppLocalizations.of(context)!.ok);
      } else if (e.code == 'wrong-password') {
        navigator.showMyMessage('Wrong Password Provided For That Email');
        // DialogUtils.showMessage(context: context, message: AppLocalizations.of(context)!.wrong_password_provided_for_that_user,
        //     title: AppLocalizations.of(context)!.error, posActionName: AppLocalizations.of(context)!.ok);
      } else if (e.code == 'invalid-credential') {
        navigator.showMyMessage('The Supplied Auth Credential Is Incorrect Malformed Or Has Expired');
        // DialogUtils.showMessage(context: context, message: AppLocalizations.of(context)!.the_supplied_auth_credential_is_incorrect_malformed_or_has_expired,
        //     title: AppLocalizations.of(context)!.error, posActionName: AppLocalizations.of(context)!.ok);
      } else if (e.code == 'network-request-failed') {
        navigator.showMyMessage('Network Error');
        // DialogUtils.showMessage(context: context, message: AppLocalizations.of(context)!.network_error,
        //     title: AppLocalizations.of(context)!.error, posActionName: AppLocalizations.of(context)!.ok);
      }
    } catch (e) {
      navigator.hideMyLoading();
      navigator.showMyMessage(e.toString());
      // DialogUtils.showMessage(context: context, message: e.toString(),
      //     title: AppLocalizations.of(context)!.error, posActionName: AppLocalizations.of(context)!.ok);
    }
  }
}
}