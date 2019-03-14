import 'package:contact_archive/models/contact.dart';
import 'api_provider.dart';

class AppProvider {
  ApiProvider api = new ApiProvider();
  saveContact(Contact contact) async {

    var data  = await api.addContact(contact);
    return data;
  }
}
