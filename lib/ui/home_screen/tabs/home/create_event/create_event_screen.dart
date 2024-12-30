import 'package:event_planning_app/firebase_utils.dart';
import 'package:event_planning_app/model/event.dart';
import 'package:event_planning_app/providers/app_theme_provider.dart';
import 'package:event_planning_app/providers/events_list_provider.dart';
import 'package:event_planning_app/ui/home_screen/tabs/home/tab_event_widget.dart';
import 'package:event_planning_app/utils/MyAppColors.dart';
import 'package:event_planning_app/utils/MyAppStyles.dart';
import 'package:event_planning_app/utils/myAssetsManager.dart';
import 'package:event_planning_app/widgets/choose_date_or_time.dart';
import 'package:event_planning_app/widgets/custom_elevated_button.dart';
import 'package:event_planning_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CreateEventScreen extends StatefulWidget {
  static const String routeName = 'addEvent';

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  int selectedIndex = 0;
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController(); // title
  var descriptionController = TextEditingController(); // description
  DateTime? selectedDate;
  String formatedDate = ''; // date
  TimeOfDay? selectedTime;
  String formatedTime = ''; // time
  String selectedImage = '';
  String selectedEvent = '';
  late EventsListProvider eventListProvider;  // global

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    eventListProvider = Provider.of<EventsListProvider>(context);
    List<String> eventsNameList = [
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
    List<String> imagesList = [
      MyAssetsManager.sportLight,
      MyAssetsManager.birthdayLight,
      MyAssetsManager.meetingLight,
      MyAssetsManager.gamingLight,
      MyAssetsManager.eatingLight,
      MyAssetsManager.holidayLight,
      MyAssetsManager.exhibitionLight,
      MyAssetsManager.workshopLight,
      MyAssetsManager.bookClubLight,
    ];
    selectedImage = imagesList[selectedIndex];
    selectedEvent = eventsNameList[selectedIndex];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeProvider.appTheme == ThemeMode.light
            ? MyAppColors.whiteColor
            : MyAppColors.primaryDark,
        iconTheme: const IconThemeData(color: MyAppColors.primaryLight),
        title: Text(AppLocalizations.of(context)!.createEvent,
            style: MyAppStyles.regular22Primary),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.04, vertical: height * 0.01),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(imagesList[selectedIndex],
                    height: height * 0.3,
                    width: double.infinity,
                    fit: BoxFit.fill),
              ),
              SizedBox(height: height * 0.015),
              SizedBox(
                height: height * 0.05,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          selectedIndex = index;
                          setState(() {});
                        },
                        child: TabEventWidget(
                            borderColor: MyAppColors.primaryLight,
                            backgroundColor: MyAppColors.primaryLight,
                            selectedTextStyle: MyAppStyles.medium16White,
                            unSelectedTextStyle: MyAppStyles.medium16Primary,
                            eventName: eventsNameList[index],
                            isSelected: selectedIndex == index),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: width * 0.01,
                      );
                    },
                    itemCount: eventsNameList.length),
              ),
              SizedBox(height: height * 0.015),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.title,
                      style: themeProvider.appTheme == ThemeMode.light
                          ? MyAppStyles.medium16Black
                          : MyAppStyles.medium16White,
                    ),
                    SizedBox(height: height * 0.01),
                    CustomTextField(
                      // validator: (text) {
                      //   if (text == null || text.isEmpty) {
                      //     return AppLocalizations.of(context)!
                      //         .please_enter_event_title;
                      //   }
                      //   return null;
                      // },
                      controller: titleController,
                      hintText: AppLocalizations.of(context)!.eventTitle,
                      prefixIcon: Image.asset(MyAssetsManager.noteEditIcon),
                      borderColor: themeProvider.appTheme == ThemeMode.light
                          ? MyAppColors.grayColor
                          : MyAppColors.primaryLight,
                    ),
                    SizedBox(height: height * 0.01),
                    Text(
                      AppLocalizations.of(context)!.description,
                      style: themeProvider.appTheme == ThemeMode.light
                          ? MyAppStyles.medium16Black
                          : MyAppStyles.medium16White,
                    ),
                    SizedBox(height: height * 0.01),
                    CustomTextField(
                      // validator: (text) {
                      //   if (text == null || text.isEmpty) {
                      //     return AppLocalizations.of(context)!
                      //         .please_enter_event_description;
                      //   }
                      //   return null;
                      // },
                      controller: descriptionController,
                      hintText: AppLocalizations.of(context)!.eventDescription,
                      maxLines: 4,
                      borderColor: themeProvider.appTheme == ThemeMode.light
                          ? MyAppColors.grayColor
                          : MyAppColors.primaryLight,
                    ),
                    SizedBox(height: height * 0.01),
                    ChooseDateOrTime(
                      iconName: MyAssetsManager.calenderIcon,
                      eventNameOrTime: AppLocalizations.of(context)!.eventDate,
                      chooseEventNameOrTime: selectedDate == null
                          ? AppLocalizations.of(context)!.chooseDate
                          : DateFormat('dd/MM/yyyy').format(selectedDate!),
                      //formatedDate,
                      onChooseDateOrTime: chooseDate,
                    ),
                    SizedBox(height: height * 0.01),
                    ChooseDateOrTime(
                      iconName: MyAssetsManager.clockIcon,
                      eventNameOrTime: AppLocalizations.of(context)!.eventTime,
                      chooseEventNameOrTime: selectedTime == null
                          ? AppLocalizations.of(context)!.chooseTime
                          : formatedTime,
                      onChooseDateOrTime: chooseTime,
                    ),
                    SizedBox(height: height * 0.01),
                    Text(
                      AppLocalizations.of(context)!.location,
                      style: themeProvider.appTheme == ThemeMode.light
                          ? MyAppStyles.medium16Black
                          : MyAppStyles.medium16White,
                    ),
                    SizedBox(height: height * 0.01),
                    InkWell(
                      onTap: () {
                        // todo: navigate to choose event location
                      },
                      child: Container(
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
                    ),
                    SizedBox(height: height * 0.02),
                    CustomElevatedButton(
                      text: AppLocalizations.of(context)!.addEvent,
                      onButtonClicked: addEvent,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void chooseDate() async {
    var chooseDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    selectedDate = chooseDate;
    formatedDate = DateFormat('dd/MM/yyyy').format(selectedDate!);
    setState(() {});
  }

  void chooseTime() async {
    var chooseTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    selectedTime = chooseTime;
    formatedTime = selectedTime!.format(context);
    setState(() {});
  }

  void addEvent() {
    if (formKey.currentState?.validate() == true) {
      List<String> errorMessages = [];

      if (titleController.text.isEmpty) {
        errorMessages.add(AppLocalizations.of(context)!.please_enter_event_title);
      }
      if (descriptionController.text.isEmpty) {
        errorMessages.add(AppLocalizations.of(context)!.please_enter_event_description);
      }
      if (selectedDate == null) {
        errorMessages.add(AppLocalizations.of(context)!.please_choose_event_date);
      }
      if (selectedTime == null) {
        errorMessages.add(AppLocalizations.of(context)!.please_choose_event_time);
      }

      if (errorMessages.isNotEmpty) {
        showErrorDialog(errorMessages);
      } else {
        // todo: Add event logic here (save to database)
        Event event = Event(
            title: titleController.text,
            description: descriptionController.text,
            imagePath: selectedImage,
            eventName: selectedEvent,
            eventDate: selectedDate!,
            eventTime: formatedTime);
        FirebaseUtils.addEventToFireStore(event).timeout(const Duration(milliseconds: 500),
            onTimeout: (){
          // todo: alert dialog, snack bar, toast
          print('Event Added Successfully');
          eventListProvider.getAllEvents(); // <= refresh eventsList
          Navigator.of(context).pop();
        });
      }
    }
  }

  void showErrorDialog(List<String> messages) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.error,style: MyAppStyles.bold14Black),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: messages.map((message) => Text(message,style: MyAppStyles.medium16Black)).toList(),
          ),
          actions: [
            TextButton(
              child: Text(AppLocalizations.of(context)!.ok,style: MyAppStyles.bold14Black),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
