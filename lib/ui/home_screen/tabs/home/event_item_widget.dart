import 'package:event_planning_app/providers/app_theme_provider.dart';
import 'package:event_planning_app/utils/MyAppColors.dart';
import 'package:event_planning_app/utils/MyAppStyles.dart';
import 'package:event_planning_app/utils/myAssetsManager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class EventItemWidget extends StatefulWidget {

  @override
  State<EventItemWidget> createState() => _EventItemWidgetState();
}

class _EventItemWidgetState extends State<EventItemWidget> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Container(
      height: height*0.3,
      margin: EdgeInsets.symmetric(
        vertical: height*0.01
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: MyAppColors.primaryLight,
          width: 2
        ),
        image: const DecorationImage(image: AssetImage(MyAssetsManager.birthdayLight),fit: BoxFit.fill),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: width*0.02,
              vertical: height*0.005
            ),
            margin: EdgeInsets.symmetric(
              horizontal: width*0.01,
              vertical: height*0.005
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: themeProvider.appTheme == ThemeMode.light? MyAppColors.whiteColor : MyAppColors.primaryDark
            ),
            child: Column(
              children: [
                Text('22',style: MyAppStyles.bold20Primary),
                Text('Dec',style: MyAppStyles.bold20Primary)
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: width*0.02,
                vertical: height*0.005
            ),
            margin: EdgeInsets.symmetric(
                horizontal: width*0.02,
                vertical: height*0.01
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color:  themeProvider.appTheme == ThemeMode.light? MyAppColors.whiteColor : MyAppColors.primaryDark
            ),
            child: Row(
              children: [
                Expanded(
                    child: Text('This is a Birthtday Party',style: themeProvider.appTheme == ThemeMode.light?MyAppStyles.medium14Black:MyAppStyles.medium14White)),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isSelected = !isSelected;
                    });
                  },
                  child: Image.asset(
                    isSelected ? MyAssetsManager.loveSelected : MyAssetsManager.loveUnSelected,
                    color: MyAppColors.primaryLight,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
