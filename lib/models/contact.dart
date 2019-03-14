import 'package:firebase_database/firebase_database.dart';

class Contact {
  String key;
  String id;
  String phone;
  String creator;

  Contact(this.id, this.phone, this.creator);

  Contact.fromJson(snapshot)
      : id = snapshot["id"],
        phone = snapshot["phone"],
        creator = snapshot["creator"];

  Contact.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        id = snapshot.value["id"],
        phone = snapshot.value["phone"],
        creator = snapshot.value["creator"];

  Contact.fromDb(DataSnapshot snapshot)
      : key = snapshot.key,
        id = snapshot.value["id"],
        phone = snapshot.value["phone"],
        creator = snapshot.value["creator"];

  toJson() {
    return {"id": id, "phone": phone, "creator": creator};
  }
}
