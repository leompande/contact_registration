import 'dart:async';

import 'package:contact_archive/models/contact.dart';
import 'package:contact_archive/shared/custom_widgets/custom_mat_color.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../shared/custom_widgets/contact_card.dart';
import '../../shared/custom_widgets/custom_inputs.dart';
import '../../shared/custom_widgets/custome_drawer.dart';
import 'package:flutter/material.dart';

final contactReference =
    FirebaseDatabase.instance.reference().child('contacts');

class Home extends StatelessWidget {
  String title;

  Home(this.title);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        drawer: AppDrawer(),
        floatingActionButton: new FloatingActionButton(
          foregroundColor: Colors.white,
          backgroundColor: colorCustom,
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, '/register');
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            double width = MediaQuery.of(context).size.width;
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                forceElevated: false,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  background: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Hero(
                            tag: 'title',
                            child: Stack(children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(
                                      'assets/banner.jpg',
                                    ),
                                  ),
                                ),
                                height: 350.0,
                              ),
                            ])),
                      )
                    ],
                  ),
                  title: Container(
//                      alignment: Alignment.bottomCenter,
                      padding: EdgeInsets.only(top: 25.0, left: 80.0),
                      child: Row(
                        children: <Widget>[Text(title)],
                      )),
                ),
              ),
            ];
          },
          body: Center(
            child: Contacts(title),
          ),
        ));
  }
}

class Contacts extends StatefulWidget {
  String title;

  Contacts(this.title);

  @override
  ContactsState createState() {
    return ContactsState(this.title);
  }
}

class ContactsState extends State<Contacts> {
  String title;
  TextEditingController searchController = TextEditingController();

  List<Contact> contacts;
  List<Contact> searchedContacts;
  StreamSubscription<Event> _onContactAddedSubscription;

  ContactsState(this.title);

  @override
  void initState() {
    super.initState();

    contacts = new List();
    _onContactAddedSubscription =
        contactReference.onChildAdded.listen(_onNoteAdded);

    searchController.addListener(() {
      var searchFieldText = searchController.text;

      setState(() {
//        contacts = searchContacts(contacts, searchFieldText);
//        print(contacts);
      });
    });
  }

//  @override
//  void initState() {
//    super.initState();
//
//  }

  @override
  void dispose() {
    _onContactAddedSubscription.cancel();
    super.dispose();
  }

  void _onNoteAdded(Event event) {
    setState(() {
      contacts.add(new Contact.fromSnapshot(event.snapshot));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: Column(
        children: <Widget>[
          ContactList(contacts),
        ],
      ),
    );

//      Scaffold(
//      drawer: AppDrawer(),
//      appBar: AppBar(
//          title: Row(
//            children: <Widget>[
//              Container(
////                  child: Image.asset('assets/logo1.png'),
//                padding: EdgeInsets.all(10.0),
//              ),
//              Text(title)
//            ],
//          ),
//          actions: <Widget>[
//            IconButton(
//              icon: Icon(Icons.notifications),
//              onPressed: () {},
//            ),
//          ]),
//      floatingActionButton: new FloatingActionButton(
//        foregroundColor: Colors.white,
//        backgroundColor: colorCustom,
//        child: const Icon(Icons.add),
//        onPressed: () {
//          Navigator.pushNamed(context, '/register');
//        },
//      ),
//      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//      bottomNavigationBar: new BottomAppBar(
//        color: colorCustom,
//        child: new Row(),
//      ),
//      body: Container(
//        color: Colors.grey[100],
//        child: Column(
//          children: <Widget>[
//            ContactList(contacts),
//          ],
//        ),
//      ),
//    );
  }
}

class ContactList extends StatefulWidget {
  List<Contact> contacts;

  ContactList(this.contacts);

  _ContactListState createState() => _ContactListState(contacts);
}

class _ContactListState extends State<ContactList> {
  List<Contact> contacts;

  _ContactListState(this.contacts);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Expanded(
          child: FutureBuilder<DataSnapshot>(
        future: FirebaseDatabase.instance
            .reference()
            .child("contacts")
            .orderByValue()
            .once(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: contactListItems(snapshot.data),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )

//          ListView.builder(
//              shrinkWrap: true,
//              physics: ClampingScrollPhysics(),
//              itemCount: contacts.length,
//              itemBuilder: (context, position) {
//                if (contacts != null) {
//                  return ContactCard(contacts[position]);
//                } else {
//                  return Center(
//                    child: CircularProgressIndicator(),
//                  );
//                }
//              })

          ),
    );
  }
}

List<Contact> searchContacts(List<Contact> contacts, String searchText) {
  List<Contact> filteredList = [];
  if (searchText != null) {
    for (var contact in contacts) {
      if (contact.phone.indexOf(searchText) >= 0) {
        filteredList.add(contact);
      }
    }
  }

  return filteredList;
}

List<ContactCard> contactListItems(snapshotData) {
  List<ContactCard> contactCards = [];
  if (snapshotData.value != null) {
    for (var value in snapshotData.value.values) {
      contactCards.add(ContactCard(Contact.fromJson(value)));
    }
  }

  return contactCards;
}
