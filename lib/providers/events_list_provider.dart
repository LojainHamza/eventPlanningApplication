import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planning_app/firebase_utils.dart';
import 'package:event_planning_app/model/event.dart';
import 'package:event_planning_app/utils/flutter_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventsListProvider extends ChangeNotifier {
  // Data
  int selectedIndex = 0;
  List<Event> eventsList = [];
  List<String> eventsNameList = [];
  List<Event> filteredList = [];
  List<Event> favoritesList = [];

  void getEventsNameList(BuildContext context) {
    eventsNameList = [
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
  }

  // Get all events from Firebase
  Future<void> getAllEvents(String uId) async {
    try {
      QuerySnapshot<Event> querySnapshot =
      await FirebaseUtils.getEventCollection(uId).get();
      eventsList = querySnapshot.docs.map((doc) => doc.data()).toList();

      // Sort events by date
      eventsList.sort((event1, event2) => event1.eventDate.compareTo(event2.eventDate));
      filteredList = List.from(eventsList);
      notifyListeners();
    } catch (error) {
      throw Exception('Error fetching all events: $error');
    }
  }

  // Filter events by selected index
  Future<void> getFilteredEvents(String uId) async {
    try {
      if (selectedIndex == 0) {
        await getAllEvents(uId);
      } else {
        QuerySnapshot<Event> querySnapshot = await FirebaseUtils.getEventCollection(uId)
            .where('eventName', isEqualTo: eventsNameList[selectedIndex])
            .get();

        filteredList = querySnapshot.docs.map((doc) => doc.data()).toList();

        // Sort filtered list by date
        filteredList.sort((event1, event2) => event1.eventDate.compareTo(event2.eventDate));
        notifyListeners();
      }
    } catch (error) {
      throw Exception('Error fetching filtered events: $error');
    }
  }

  // Change selected index and fetch events accordingly
  void changeSelectedIndex(int newSelectedIndex, String uId) {
    selectedIndex = newSelectedIndex;
    getFilteredEvents(uId);
  }

// Update an event in Firebase and locally
  Future<void> updateEvent(String uId, Event updatedEvent) async {
    try {
      await FirebaseUtils.getEventCollection(uId)
          .doc(updatedEvent.id)
          .update({
        'title': updatedEvent.title,
        'description': updatedEvent.description,
        'eventDate': updatedEvent.eventDate,
        'eventTime': updatedEvent.eventTime,
        'imagePath': updatedEvent.imagePath,
        'eventName': updatedEvent.eventName,
      });

      // Update the local list
      int index = eventsList.indexWhere((event) => event.id == updatedEvent.id);
      if (index != -1) {
        eventsList[index] = updatedEvent;
        filteredList[index] = updatedEvent;
        notifyListeners();
      }
    } catch (error) {
      throw Exception('Error updating event: $error');
    }
  }

// Delete an event from Firebase and locally
  Future<void> deleteEvent(String uId, String eventId) async {
    try {
      await FirebaseUtils.getEventCollection(uId)
          .doc(eventId)
          .delete();

      // Remove the event from the local lists
      eventsList.removeWhere((event) => event.id == eventId);
      filteredList.removeWhere((event) => event.id == eventId);
      favoritesList.removeWhere((event) => event.id == eventId);
      notifyListeners();
    } catch (error) {
      throw Exception('Error deleting event: $error');
    }
  }

  // Add event to favorites
  void addEventToFavorites(Event event, BuildContext context) {
    if (!favoritesList.contains(event)) {
      favoritesList.add(event);
      ToastMessage.toastMessage(
          msg: AppLocalizations.of(context)!.event_added_to_favorites);
      notifyListeners();
    }
  }

  // Remove event from favorites
  void removeEventFromFavorites(Event event, BuildContext context) {
    if (favoritesList.contains(event)) {
      favoritesList.remove(event);
      ToastMessage.toastMessage(
          msg: AppLocalizations.of(context)!.event_removed_from_favorites);
      notifyListeners();
    }
  }
}

/*
 // List <Event> favoriteEventList = [];
 // void updateFavoriteEvent(Event event,BuildContext context){
  //   FirebaseUtils.getEventCollection().doc(event.id).update(
  //       {'isSelected': !event.isSelected}
  //   ).timeout(const Duration(milliseconds: 500),onTimeout: (){
  //     ToastMessage.toastMessage(msg: AppLocalizations.of(context)!.event_updated_successfully);
  //     selectedIndex == 0? getAllEvents():getFilteredEvents();
  //     getFavoriteEvents();
  //   });
  //   notifyListeners();
  // }

  // void getFavoriteEvents()async{
  //   var querySnapshot = await FirebaseUtils.getEventCollection().orderBy('eventDate').where('isFavorite', isEqualTo: true).get();
  //   favoriteEventList = querySnapshot.docs.map((doc){
  //     return doc.data();
  //   }).toList();
  //   notifyListeners();
  // }
 */
