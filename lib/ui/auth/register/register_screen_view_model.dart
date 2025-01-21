import 'package:event_planning_app/ui/auth/register/register_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterScreenViewModel extends ChangeNotifier{
  //todo: hold data & handle logic
  late RegisterNavigator navigator;

  void register(String email,String password)async{
    navigator.showMyLoading('Loading..');
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // MyUser myUser = MyUser(
      //     id: credential.user?.uid ?? '',
      //     name: nameController.text,
      //     email: emailController.text);
      // var userProvider = Provider.of<UserProvider>(context, listen: false);
      // userProvider.updateUser(myUser);
      // await FirebaseUtils.addUserToFireStore(myUser);
      navigator.hideMyLoading();
      navigator.showMyMessage('Registered Successfully');
      // DialogUtils.showMessage(context: context, message: AppLocalizations.of(context)!.registered_successfully,
      //     title: AppLocalizations.of(context)!.success, posActionName: AppLocalizations.of(context)!.ok,
      //     posAction: () {
      //       Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      //     });
    } on FirebaseAuthException catch (e) {
      navigator.hideMyLoading();
      if (e.code == 'weak-password') {
        navigator.showMyMessage('The Password Provided Is Too Weak');
        // DialogUtils.showMessage(context: context, message: AppLocalizations.of(context)!.the_password_provided_is_too_weak,
        //     title: AppLocalizations.of(context)!.error, posActionName: AppLocalizations.of(context)!.ok);
      } else if (e.code == 'email-already-in-use') {
        navigator.showMyMessage('The Account Already Exists For That Email');
        // DialogUtils.showMessage(context: context, message: AppLocalizations.of(context)!.the_account_already_exists_for_that_email,
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