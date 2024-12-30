import 'package:event_planning_app/providers/events_list_provider.dart';
import 'package:event_planning_app/ui/home_screen/tabs/home/event_item_widget.dart';
import 'package:event_planning_app/utils/MyAppColors.dart';
import 'package:event_planning_app/utils/MyAppStyles.dart';
import 'package:event_planning_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoveTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var eventsListProvider = Provider.of<EventsListProvider>(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: height * 0.05),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.02),
              child: CustomTextField(
                style: MyAppStyles.medium16Primary,
                borderColor: MyAppColors.primaryLight,
                hintText: AppLocalizations.of(context)!.search_for_event,
                hintStyle: MyAppStyles.bold14Primary,
                prefixIcon: const Icon(Icons.search, color: MyAppColors.primaryLight),
              ),
            ),
            Expanded(
              child: eventsListProvider.favoritesList.isEmpty
                  ? Center(
                child: Text(
                  AppLocalizations.of(context)!.no_fav_events_yet,
                  style: MyAppStyles.medium18Black,
                ),
              )
                  : ListView.builder(
                itemCount: eventsListProvider.favoritesList.length,
                itemBuilder: (context, index) {
                  return EventItemWidget(event: eventsListProvider.favoritesList[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
