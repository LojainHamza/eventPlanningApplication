import 'package:event_planning_app/ui/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:event_planning_app/model/event.dart';
import 'package:event_planning_app/providers/app_theme_provider.dart';
import 'package:event_planning_app/providers/events_list_provider.dart';
import 'package:event_planning_app/providers/user_provider.dart';
import 'package:event_planning_app/ui/home_screen/tabs/home/tab_event_widget.dart';
import 'package:event_planning_app/utils/MyAppColors.dart';
import 'package:event_planning_app/utils/MyAppStyles.dart';
import 'package:event_planning_app/utils/myAssetsManager.dart';
import 'package:event_planning_app/widgets/choose_date_or_time.dart';
import 'package:event_planning_app/widgets/custom_elevated_button.dart';
import 'package:event_planning_app/widgets/custom_text_field.dart';

class EditEventScreen extends StatefulWidget {
  static const String routeName = 'editEvent';
  final Event event;
  final int index;

  const EditEventScreen({Key? key, required this.event, required this.index}) : super(key: key);

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late DateTime selectedDate;
  late TimeOfDay selectedTime;
  late int selectedIndex;

  List<String> eventsNameList = [
    'sport',
    'birthday',
    'meeting',
    'gaming',
    'eating',
    'holiday',
    'exhibition',
    'workshop',
    'book_club',
  ];
  List<String> eventImages = [
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

  @override
  void initState() {
    super.initState();

    // Initialize controllers with the current event's data
    titleController = TextEditingController(text: widget.event.title);
    descriptionController = TextEditingController(text: widget.event.description);
    selectedDate = widget.event.eventDate;

    // Correctly initialize selected index if it falls out of bounds
    selectedIndex = widget.index;
    if (selectedIndex < 0 || selectedIndex >= eventsNameList.length) {
      selectedIndex = 0;
    }

    // Parse and initialize selected time correctly
    selectedTime = _parseTime(widget.event.eventTime) ?? TimeOfDay.now();
  }

  // Helper function to parse event time and handle errors gracefully
  TimeOfDay? _parseTime(String time) {
    final timeMatch = RegExp(r'(\d+):(\d+)(?: ?([AP]M))?').firstMatch(time);
    if (timeMatch != null) {
      final hour = int.parse(timeMatch.group(1)!);
      final minute = int.parse(timeMatch.group(2)!);
      final meridian = timeMatch.group(3);

      if (meridian != null) {
        return meridian == 'PM' && hour != 12
            ? TimeOfDay(hour: hour + 12, minute: minute)
            : TimeOfDay(hour: hour % 12, minute: minute);
      } else {
        // Handle 24-hour time format
        return TimeOfDay(hour: hour, minute: minute);
      }
    }
    return null; // Return null if parsing fails
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> saveEvent() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final timeString = selectedTime.format(context);

      // Create the updated event object
      final updatedEvent = Event(
        id: widget.event.id,
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        eventDate: selectedDate,
        eventTime: timeString,
        imagePath: eventImages[selectedIndex],
        eventName: eventsNameList[selectedIndex],
      );

      try {
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        var userId = userProvider.currentUser!.id; // Replace with actual user ID retrieval logic

        // Debugging: Print user ID and event ID
        print('User ID: $userId');
        print('Event ID: ${updatedEvent.id}');

        // Call updateEvent with the correct parameters
        await Provider.of<EventsListProvider>(context, listen: false)
            .updateEvent(userId, updatedEvent);

        // Success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.event_updated_successfully),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate back after successful update
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${AppLocalizations.of(context)!.failed_to_update_event}: $error',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> chooseDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> chooseTime() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeProvider.appTheme == ThemeMode.light ? MyAppColors.whiteColor : MyAppColors.primaryDark,
        iconTheme: const IconThemeData(color: MyAppColors.primaryLight),
        title: Text(
          AppLocalizations.of(context)!.edit_event,
          style: MyAppStyles.regular22Primary,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        eventImages[selectedIndex],
                        height: height * 0.3,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    SizedBox(
                      height: height * 0.05,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: TabEventWidget(
                              borderColor: MyAppColors.primaryLight,
                              backgroundColor: selectedIndex == index
                                  ? MyAppColors.primaryLight
                                  : Colors.transparent,
                              selectedTextStyle: MyAppStyles.medium16White,
                              unSelectedTextStyle: MyAppStyles.medium16Primary,
                              eventName: eventsNameList[index],
                              isSelected: selectedIndex == index,
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(width: width * 0.01);
                        },
                        itemCount: eventsNameList.length,
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    Text(
                      AppLocalizations.of(context)!.title,
                      style: themeProvider.appTheme == ThemeMode.light
                          ? MyAppStyles.medium16Black
                          : MyAppStyles.medium16White,
                    ),
                    SizedBox(height: height * 0.01),
                    CustomTextField(
                      controller: titleController,
                      hintText: AppLocalizations.of(context)!.eventTitle,
                      style: TextStyle(color: themeProvider.appTheme == ThemeMode.light ? MyAppColors.blackColor : MyAppColors.whiteColor),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.please_enter_event_title;
                        }
                        return null;
                      },
                      prefixIcon: Image.asset(MyAssetsManager.noteEditIcon),
                      borderColor: themeProvider.appTheme == ThemeMode.light
                          ? MyAppColors.grayColor
                          : MyAppColors.primaryLight,
                      hintStyle: themeProvider.appTheme == ThemeMode.light ? MyAppStyles.medium16Gray : MyAppStyles.medium16White,
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
                      controller: descriptionController,
                      hintText: AppLocalizations.of(context)!.eventDescription,
                      maxLines: 4,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.please_enter_event_description;
                        }
                        return null;
                      },
                      borderColor: themeProvider.appTheme == ThemeMode.light
                          ? MyAppColors.grayColor
                          : MyAppColors.primaryLight,
                      style: TextStyle(color: themeProvider.appTheme == ThemeMode.light ? MyAppColors.blackColor : MyAppColors.whiteColor),
                      hintStyle: themeProvider.appTheme == ThemeMode.light ? MyAppStyles.medium16Gray : MyAppStyles.medium16White,
                    ),
                    SizedBox(height: height * 0.01),
                    ChooseDateOrTime(
                      iconName: MyAssetsManager.calenderIcon,
                      eventNameOrTime: AppLocalizations.of(context)!.eventDate,
                      chooseEventNameOrTime: DateFormat('dd/MM/yyyy').format(selectedDate),
                      onChooseDateOrTime: chooseDate,
                    ),
                    SizedBox(height: height * 0.01),
                    ChooseDateOrTime(
                      iconName: MyAssetsManager.clockIcon,
                      eventNameOrTime: AppLocalizations.of(context)!.eventTime,
                      chooseEventNameOrTime: selectedTime.format(context),
                      onChooseDateOrTime: chooseTime,
                    ),
                    SizedBox(height: height * 0.02),
                    CustomElevatedButton(
                      text: AppLocalizations.of(context)!.save_changes,
                      onButtonClicked: saveEvent,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
