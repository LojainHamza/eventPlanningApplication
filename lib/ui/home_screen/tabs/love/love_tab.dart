import 'package:event_planning_app/providers/app_theme_provider.dart';
import 'package:event_planning_app/providers/events_list_provider.dart';
import 'package:event_planning_app/ui/home_screen/tabs/home/event_item_widget.dart';
import 'package:event_planning_app/utils/MyAppColors.dart';
import 'package:event_planning_app/utils/MyAppStyles.dart';
import 'package:event_planning_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoveTab extends StatefulWidget {
  @override
  _LoveTabState createState() => _LoveTabState();
}

class _LoveTabState extends State<LoveTab> {
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var eventsListProvider = Provider.of<EventsListProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var filteredEvents = eventsListProvider.favoritesList.where((event) {
      return event.title.toLowerCase().contains(searchText.toLowerCase()) ||
          event.description.toLowerCase().contains(searchText.toLowerCase()) ||
          event.eventName.toLowerCase().contains(searchText.toLowerCase()) ||
          event.eventDate.toString().contains(searchText) ||
          event.eventTime.toLowerCase().contains(searchText.toLowerCase());
    }).toList();

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: height * 0.05),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.02),
              child: CustomTextField(
                onChanged: (text) {
                  setState(() {
                    searchText = text!;
                  });
                },
                style: themeProvider.appTheme==ThemeMode.light?MyAppStyles.medium16Black:MyAppStyles.medium16White,
                borderColor: MyAppColors.primaryLight,
                hintText: AppLocalizations.of(context)!.search_for_event,
                hintStyle: MyAppStyles.bold14Primary,
                prefixIcon: const Icon(Icons.search, color: MyAppColors.primaryLight),
              ),
            ),
            Expanded(
              child: filteredEvents.isEmpty
                  ? Center(
                child: Text(
                  AppLocalizations.of(context)!.no_fav_events_yet,
                  style: themeProvider.appTheme == ThemeMode.light
                      ? MyAppStyles.medium16Black
                      : MyAppStyles.medium16White,
                ),
              )
                  : Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                child: ListView.builder(
                  itemCount: filteredEvents.length,
                  itemBuilder: (context, index) {
                    return EventItemWidget(event: filteredEvents[index]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
