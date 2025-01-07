import 'package:event_planning_app/model/event.dart';
import 'package:event_planning_app/providers/app_theme_provider.dart';
import 'package:event_planning_app/providers/events_list_provider.dart';
import 'package:event_planning_app/ui/home_screen/tabs/home/event_details/edit_event/edit_event_screen.dart';
import 'package:event_planning_app/utils/MyAppColors.dart';
import 'package:event_planning_app/utils/MyAppStyles.dart';
import 'package:event_planning_app/utils/myAssetsManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventDetailsScreen extends StatefulWidget {
  static const String routeName = 'eventDetails';

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as Event;
    var eventListProvider = Provider.of<EventsListProvider>(context);
    int eventIndex = eventListProvider.eventsList.indexOf(args);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: MyAppColors.primaryLight,
        ),
        title: Text(
          AppLocalizations.of(context)!.event_details,
          style: MyAppStyles.regular22Primary,
        ),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () async {
              final updatedEvent = await Navigator.of(context).pushNamed(
                EditEventScreen.routeName,
                arguments: {'event': args, 'index': eventIndex},
              );
              if (updatedEvent != null) {
                setState(() {
                  args = updatedEvent as Event;
                });
              }
            },
            child: Image.asset(MyAssetsManager.editIcon),
          ),
          SizedBox(width: width * 0.02),
          InkWell(
            onTap: () {},
            child: Image.asset(MyAssetsManager.deleteIcon),
          ),
          SizedBox(width: width * 0.02),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  args.imagePath,
                  height: height * 0.3,
                  width: width,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: height * 0.02),
              Text(args.title, style: MyAppStyles.medium24Primary),
              SizedBox(height: height * 0.02),
              Container(
                padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: MyAppColors.primaryLight,
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: height * 0.02,
                        horizontal: width * 0.04,
                      ),
                      margin: EdgeInsets.symmetric(
                        vertical: height * 0.01,
                        horizontal: width * 0.01,
                      ),
                      decoration: BoxDecoration(
                        color: MyAppColors.primaryLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.calendar_month_outlined,
                        color: themeProvider.appTheme == ThemeMode.light
                            ? MyAppColors.whiteColor
                            : MyAppColors.blackColor,
                      ),
                    ),
                    SizedBox(width: width * 0.02),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat('dd MMMM yyyy').format(args.eventDate),
                            style: MyAppStyles.medium16Primary,
                          ),
                          SizedBox(height: height * 0.01),
                          Text(
                            args.eventTime,
                            style: MyAppStyles.medium16Black,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.02),
              Container(
                padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: MyAppColors.primaryLight,
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: height * 0.02,
                        horizontal: width * 0.04,
                      ),
                      margin: EdgeInsets.symmetric(
                        vertical: height * 0.01,
                        horizontal: width * 0.01,
                      ),
                      decoration: BoxDecoration(
                        color: MyAppColors.primaryLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.my_location_outlined,
                        color: themeProvider.appTheme == ThemeMode.light
                            ? MyAppColors.whiteColor
                            : MyAppColors.blackColor,
                      ),
                    ),
                    SizedBox(width: width * 0.02),
                    Expanded(
                      child: Text(
                        AppLocalizations.of(context)!
                            .chooseEventLocation,
                        style: MyAppStyles.medium16Primary,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: MyAppColors.primaryLight,
                    )
                  ],
                ),
              ),
              SizedBox(height: height * 0.02),
              Text(
                  AppLocalizations.of(context)!.description,
                  style: MyAppStyles.medium16Black),
              Text(args.description, style: MyAppStyles.medium16Black)
            ],
          ),
        ),
      ),
    );
  }
}