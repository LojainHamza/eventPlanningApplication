import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planning_app/firebase_utils.dart';
import 'package:event_planning_app/model/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventsListProvider extends ChangeNotifier{
  //data
  int selectedIndex = 0 ;
  List<Event> eventsList = [];
  List<String> eventsNameList = [];
  List<Event> favoritesList = [];
  void getEventsNameList(BuildContext context){
    eventsNameList= [
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
  //function that changes data
  List<Event> filteredList = [];  // filtered events by event name

  void getAllEvents()async{
    QuerySnapshot<Event> querySnapshot = await FirebaseUtils.getEventCollection().get();
    // List<Event>  List<QueryDocumentSnapshot<Event>>
    eventsList = querySnapshot.docs.map((doc){
      return doc.data();
    }).toList();
    filteredList = eventsList;
    /// sorting list
    filteredList.sort((Event event1,Event event2){
      return event1.eventDate.compareTo(event2.eventDate);
    });
    notifyListeners();
  }

  void getFilteredEvents()async{
    QuerySnapshot<Event> querySnapshot = await FirebaseUtils.getEventCollection().get();
    /// get all events
    eventsList = querySnapshot.docs.map((doc){
      return doc.data();
    }).toList();
    /// filtered events list
    filteredList = eventsList.where((event){
      return event.eventName == eventsNameList[selectedIndex];
    }).toList();
    /// sorting list
    filteredList.sort((Event event1,Event event2){
      return event1.eventDate.compareTo(event2.eventDate);
    });
    notifyListeners();
  }

  void getFilteredEvents1()async{
    QuerySnapshot<Event> querySnapshot = await FirebaseUtils.getEventCollection()
        .where('eventName',isEqualTo: eventsNameList[selectedIndex])
        .orderBy('eventTime',descending: false)
        .get();
    filteredList = querySnapshot.docs.map((doc){
      return doc.data();
    }).toList();
    notifyListeners();
  }

  void changeSelectedIndex(int newSelectedIndex){
    selectedIndex = newSelectedIndex;
    if(selectedIndex == 0){   // All
      getAllEvents();
    }else{
      getFilteredEvents();
    }
  }

  void addEventToFavorites(Event event) {
    if (!favoritesList.contains(event)) {
      favoritesList.add(event);
      notifyListeners();
    }
  }

  void removeEventFromFavorites(Event event) {
    favoritesList.remove(event);
    notifyListeners();
  }
}
