import 'package:event_planning_app/model/myUser.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier{
  MyUser? currentUser;

  void updateUser(MyUser newUser){
    currentUser = newUser;
    notifyListeners();
  }

}