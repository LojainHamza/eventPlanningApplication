import 'package:event_planning_app/providers/app_theme_provider.dart';
import 'package:event_planning_app/ui/home_screen/tabs/home/event_item_widget.dart';
import 'package:event_planning_app/ui/home_screen/tabs/home/tab_event_widget.dart';
import 'package:event_planning_app/utils/MyAppStyles.dart';
import 'package:event_planning_app/utils/myAppColors.dart';
import 'package:event_planning_app/utils/myAssetsManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int selectedIndex = 0 ;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    List<String> eventsNameList = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.eating,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.workshop,
      AppLocalizations.of(context)!.book_club,
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeProvider.appTheme == ThemeMode.light?MyAppColors.primaryLight:MyAppColors.primaryDark,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context)!.welcome_back,style: MyAppStyles.regular14White),
                Text('John Safwat',style: MyAppStyles.bold24White)
              ],
            ),
            Row(
              children: [
                const Icon(Icons.sunny,color: MyAppColors.whiteColor),
                SizedBox(width: width*0.02),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: MyAppColors.whiteColor
                  ),
                  child: Text('EN',style: MyAppStyles.bold14Primary),
                )
              ],
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: width*0.03,
              vertical: height*0.01
            ),
            height: height*0.15,
            decoration: BoxDecoration(
              color: themeProvider.appTheme == ThemeMode.light?MyAppColors.primaryLight:MyAppColors.primaryDark,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35),
              )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const ImageIcon(AssetImage(MyAssetsManager.mapUnSelected),color: MyAppColors.whiteColor),
                    Text('Cairo , Egypt',style: MyAppStyles.medium14White)
                  ],
                ),
                DefaultTabController(
                    length: eventsNameList.length,
                    child: TabBar(
                      onTap: (index){
                        selectedIndex = index;
                        setState(() {

                        });
                      },
                      isScrollable: true,
                        indicatorColor: MyAppColors.transparentColor,
                        dividerColor: MyAppColors.transparentColor,
                        tabAlignment: TabAlignment.start,
                        labelPadding: EdgeInsets.symmetric(
                          horizontal: width*0.01,
                          vertical: height*0.02
                        ),
                        tabs: eventsNameList.map((eventName){
                          return TabEventWidget(eventName: eventName, isSelected: selectedIndex == eventsNameList.indexOf(eventName));
                        }).toList())
                ),

              ],
            ),
          ),
          Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width*0.04,
                  vertical: height*0.01
                ),
                child: ListView.builder(
                    itemCount: 20,
                    itemBuilder: (context,index){
                      return EventItemWidget();
                    }
                ),
              )
          )
        ],
      ),
    );
  }
}
