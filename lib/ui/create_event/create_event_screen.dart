import 'package:event_planning_app/utils/MyAppColors.dart';
import 'package:flutter/material.dart';

class CreateEventScreen extends StatelessWidget {
  static const String routeName = 'createEvent';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyAppColors.primaryLight,
      ),
    );
  }
}
