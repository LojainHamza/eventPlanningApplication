import 'package:event_planning_app/ui/create_event/create_event_screen.dart';
import 'package:event_planning_app/ui/home_screen/tabs/home/home_tab.dart';
import 'package:event_planning_app/ui/home_screen/tabs/love/love_tab.dart';
import 'package:event_planning_app/ui/home_screen/tabs/map/map_tab.dart';
import 'package:event_planning_app/ui/home_screen/tabs/profile/profile_tab.dart';
import 'package:event_planning_app/utils/MyAppColors.dart';
import 'package:event_planning_app/utils/myAssetsManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'homeScreen';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List <Widget> tabs = [HomeTab(),MapTab(),LoveTab(),ProfileTap()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: MyAppColors.transparentColor
        ),
        child: BottomAppBar(
          padding: EdgeInsets.zero,
          color: Theme.of(context).primaryColor,
          shape: const CircularNotchedRectangle(),
          notchMargin: 4,
          child: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (index){
              selectedIndex = index;
              setState(() {

              });
            },
              items: [
                buildBottomNavBarItem(index:0,iconSelectedName: MyAssetsManager.homeSelected, iconUnSelectedName: MyAssetsManager.homeUnSelected, label: AppLocalizations.of(context)!.home),
                buildBottomNavBarItem(index:1,iconSelectedName:MyAssetsManager.mapSelected, iconUnSelectedName: MyAssetsManager.mapUnSelected, label: AppLocalizations.of(context)!.map),
                buildBottomNavBarItem(index:2,iconSelectedName:MyAssetsManager.loveSelected, iconUnSelectedName: MyAssetsManager.loveUnSelected, label: AppLocalizations.of(context)!.love),
                buildBottomNavBarItem(index:3,iconSelectedName:MyAssetsManager.profileSelected,iconUnSelectedName: MyAssetsManager.profileUnSelected, label: AppLocalizations.of(context)!.profile),
              ],
            type: BottomNavigationBarType.fixed,
            selectedItemColor: MyAppColors.whiteColor,
            unselectedItemColor: MyAppColors.whiteColor,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            // add event
            // navigate to add event screen
            Navigator.of(context).pushNamed(CreateEventScreen.routeName);
          },
          child: const Icon(Icons.add,color: MyAppColors.whiteColor,size: 35,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: tabs[selectedIndex],
    );
  }
  BottomNavigationBarItem buildBottomNavBarItem({required int index ,
    required String iconUnSelectedName , required String iconSelectedName , required String label}){
    return BottomNavigationBarItem(
        icon: ImageIcon(AssetImage(selectedIndex == index? iconSelectedName : iconUnSelectedName)),
        label: label
    );
  }
}