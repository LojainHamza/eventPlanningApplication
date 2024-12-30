import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planning_app/model/event.dart';

class FirebaseUtils{

  static CollectionReference<Event> getEventCollection(){
    return FirebaseFirestore.instance.collection(Event.collectionName).withConverter<Event>(
        fromFirestore: (snapshot,option) => Event.fromFireStore(snapshot.data()!),
        toFirestore: (event,_) => event.toFireStore()
    );
  }
  /// function saves data in database
  static Future<void> addEventToFireStore(Event event){
    CollectionReference<Event> collectionReference = getEventCollection();   // collection
    DocumentReference<Event> documentReference = collectionReference.doc();    // document
    event.id = documentReference.id;   // auto id
    return documentReference.set(event);
    //getEventCollection().doc().set(event);
  }
}

/*
Firebase ==> json
{} => jsonObject
[] => jsonArray
Developers ==> object

solution: 2 functions:-

fn json => object => get data from firebase
fn object => json => add data to firebase
 */

// 3shan firebase t3rf noo3 el7aga elly btkhznha hstkhdm => .withConverter<>
// we can't access "data" without accessing ""document""
