import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  static const String collectionName = 'Events';
  String id;
  String title;
  String description;
  String imagePath;
  String eventName;
  DateTime eventDate;
  String eventTime;
  bool isSelected;

  Event(
      {this.id = '',
      required this.title,
      required this.description,
      required this.imagePath,
      required this.eventName,
      required this.eventDate,
      required this.eventTime,
      this.isSelected = false});

  // json => object
  Event.fromFireStore(Map<String, dynamic> data)
      : this(
    id: data['id'] ?? '',
    title: data['title'] ?? '',
    description: data['description'] ?? '',
    imagePath: data['imagePath'] ?? '',
    eventName: data['eventName'] ?? '',
    eventDate: (data['eventDate'] is Timestamp)
        ? (data['eventDate'] as Timestamp).toDate()
        : DateTime.fromMillisecondsSinceEpoch(data['eventDate'] ?? 0),
    eventTime: data['eventTime'] ?? '',
    isSelected: data['isSelected'] ?? false,
  );


  // object => json
  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imagePath': imagePath,
      'eventName': eventName,
      'eventDate': eventDate.millisecondsSinceEpoch,
      'eventTime': eventTime,
      'isSelected': isSelected
    };
  }
}

/*
Model steps:-
1. collection Name
2. attributes
3. constructor
4. from json to object function
5. from object to json function
 */