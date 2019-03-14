import 'package:firebase_database/firebase_database.dart';

class Contact {
  String key;
  String id;
  String first_name;
  String middle_name;
  String last_name;
  String username;

  Contact(this.id, this.first_name, this.middle_name, this.last_name,
      this.username);

  Contact.fromJson(snapshot)
      : id = snapshot["id"],
        first_name = snapshot["first_name"],
        middle_name = snapshot["middle_name"],
        last_name = snapshot["last_name"],
        username = snapshot["username"];

  Contact.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        id = snapshot.value["id"],
        first_name = snapshot.value["first_name"],
        middle_name = snapshot.value["middle_name"],
        last_name = snapshot.value["last_name"],
        username = snapshot.value["username"];

  Contact.fromDb(DataSnapshot snapshot)
      : key = snapshot.key,
        id = snapshot.value["id"],
        first_name = snapshot.value["first_name"],
        middle_name = snapshot.value["middle_name"],
        last_name = snapshot.value["last_name"],
        username = snapshot.value["username"];

  toJson() {
    return {
      "id": id,
      "first_name": first_name,
      "middle_name": middle_name,
      "last_name": last_name,
      "username": username
    };
  }
}
