import 'dart:async';
import 'package:contact_archive/models/contact.dart';
import 'package:firebase_database/firebase_database.dart';

class ApiProvider {

  DatabaseReference _counterRef;
  DatabaseReference _contactsRef;
  StreamSubscription<Event> _counterSubscription;
  StreamSubscription<Event> _messagesSubscription;
  FirebaseDatabase database = new FirebaseDatabase();
  int _counter;
  DatabaseError error;

  static final ApiProvider _instance = new ApiProvider.internal();

  ApiProvider.internal();

  factory ApiProvider() {
    return _instance;
  }

  void initState() {
    // Demonstrates configuring to the database using a file
    _counterRef = FirebaseDatabase.instance.reference().child('counter');
    // Demonstrates configuring the database directly

    _contactsRef = database.reference().child('contacts');
    database.reference().child('counter').once().then((DataSnapshot snapshot) {
      print('Connected to second database and read ${snapshot.value}');
    });
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);
    _counterRef.keepSynced(true);

    _counterSubscription = _counterRef.onValue.listen((Event event) {
      error = null;
      _counter = event.snapshot.value ?? 0;
    }, onError: (Object o) {
      error = o;
    });
  }

  DatabaseError getError() {
    return error;
  }

  int getCounter() {
    return _counter;
  }

  DatabaseReference getContact() {
    return _contactsRef;
  }

  addContact(Contact contact) async {
    this.initState();
    _contactsRef.push().set(<String, String>{
      "phone": "" + contact.phone.toString(),
      "creator": "" + contact.creator.toString(),
    }).then((_) {
      print('Transaction  committed.');
    });
//    final TransactionResult transactionResult =
//        await _counterRef.runTransaction((MutableData mutableData) async {
//      mutableData.value = (mutableData.value ?? 0) + 1;
//
//      return mutableData;
//    });
//
//    if (transactionResult.committed) {
//      _contactsRef.push().set(<String, String>{
//        "firstName": "" + contact.firstName,
//        "middleName": "" + contact.middleName,
//        "lastName": "" + contact.lastName,
//        "phone": "" + contact.phone,
//        "email": "" + contact.email
//      }).then((_) {
//        print('Transaction  committed.');
//      });
//    } else {
//      print('Transaction not committed.');
//      if (transactionResult.error != null) {
//        print(transactionResult.error.message);
//      }
//    }
  }

  void deleteContact(Contact contact) async {
    await _contactsRef.child(contact.id).remove().then((_) {
      print('Transaction  committed.');
    });
  }

  void updateContact(Contact contact) async {
    await _contactsRef.child(contact.id).update({
      "phone": "" + contact.phone
    }).then((_) {
      print('Transaction  committed.');
    });
  }

  void dispose() {
    _messagesSubscription.cancel();
    _counterSubscription.cancel();
  }
}
