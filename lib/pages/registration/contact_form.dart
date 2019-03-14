import 'dart:async';

import 'package:contact_archive/models/contact.dart';
import 'package:contact_archive/networ_layer/app_provider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared/custom_widgets/custom_buttons.dart';
import '../../shared/custom_widgets/custom_inputs.dart';
import 'package:flutter/material.dart';

final contactReference =
    FirebaseDatabase.instance.reference().child('contacts');

class ContactForm extends StatefulWidget {
  List<Contact> contacts;

  @override
  ContactFormState createState() {
    return ContactFormState(this.contacts);
  }
}

class ContactFormState extends State<ContactForm> {
  List<Contact> contacts;

  ContactFormState(this.contacts);

  final _formKey = GlobalKey<FormState>();
  AppProvider appProvider = new AppProvider();

  final TextEditingController _phoneController = TextEditingController();
  bool enableSubmit = false;
  bool isUnique = true;

  StreamSubscription<Event> _onContactAddedSubscription;

  @override
  void dispose() {
    _onContactAddedSubscription.cancel();
    super.dispose();
  }

  void _contactAdded(Event event) {
    setState(() {
      contacts.add(new Contact.fromSnapshot(event.snapshot));
    });
  }

  @override
  void initState() {
    super.initState();
    contacts = new List();
    _onContactAddedSubscription =
        contactReference.onChildAdded.listen(_contactAdded);
    _phoneController.addListener(() {
      var phoneNumber = _phoneController.text;
      setState(() {
        enableSubmit = checkForNumberValidity(phoneNumber) ? true : false;
        isUnique = numberIsUnique(contacts, phoneNumber);
      });
    });
  }

  bool addingContact = false;
  bool addingSuccess = false;
  bool addingFailed = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
            title: Row(
              children: <Widget>[
                Container(
//                  child: Image.asset('assets/logo1.png'),
                  padding: EdgeInsets.all(10.0),
                ),
                Text('New Contact')
              ],
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.account_circle),
                onPressed: () {},
              ),
            ]),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                decoration:
                    BoxDecoration(color: Color.fromRGBO(191, 191, 191, 0.2)),
                padding: EdgeInsets.all(10.0),
                child: Container(
                  width: width,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'New Contact Form',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Container(
                  child: Expanded(
                      child: ListView(
                    padding:
                        EdgeInsets.only(top: 40.0, left: 10.0, right: 10.0),
                    children: <Widget>[
                      isUnique
                          ? Container()
                          : Container(
                              child: Text(
                                'Error: Duplicate Phone number',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.red[200],
                                  borderRadius: BorderRadius.circular(50.0),
                                  border: Border.all(color: Colors.grey[300])),
                              padding: EdgeInsets.all(10.0),
                            ),
                      Container(
                        padding: EdgeInsets.only(top: 20.0),
                      ),
                      CustomInput('Phone', _phoneController),
                      Container(
                        padding: EdgeInsets.only(top: 20.0),
                      ),
                      enableSubmit && isUnique
                          ? CustomPrimaryButton('Save', () async {
                              setState(() {
                                this.addingContact = true;
                                this.addingSuccess = false;
                                _formKey.currentState.reset();
                              });
                              SharedPreferences.setMockInitialValues({});
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              var currentUser =
                                  await prefs.getString('currentUser');
                              Contact contact = new Contact(
                                  '1',
                                  getNumberWithoutAreaCode(
                                      _phoneController.text),
                                  currentUser);
                              try{
                                var response =
                                await this.appProvider.saveContact(contact);

                                _phoneController.clear();
                                setState(() {
                                  this.addingContact = false;
                                  this.addingSuccess = true;
                                });

                              } catch (e){
                                setState(() {
                                  this.addingFailed = true;
                                });
                              }


                            })
                          : Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(bottom: 10.0),
                              padding: EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(50.0),
                                  border: Border.all(color: Colors.grey[300])),
//        padding: EdgeInsets.only(left: 20.0, bottom: 0.0),
                              child: Text(
                                'Save',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                      addingContact == true
                          ? Container(
                              color: Colors.grey[300],
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                children: <Widget>[
                                  CircularProgressIndicator(),
                                  Text("  Adding contact please wait ...",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.brown))
                                ],
                              ),
                            )
                          : Container(),
                      addingSuccess == true
                          ? Container(
                              color: Colors.green[200],
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.check,
                                    size: 50,
                                    color: Colors.green[700],
                                  ),
                                  Text(
                                    " Contact added successfully",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green[700]),
                                  )
                                ],
                              ),
                            )
                          : Container(),
                      addingFailed == true
                          ? Container(
                        color: Colors.red[200],
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.warning,
                              size: 50,
                              color: Colors.red[700],
                            ),
                            Text(
                              " Contact adding failed",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red[700]),
                            )
                          ],
                        ),
                      )
                          : Container(),
                    ],
                  )),
                ),
              )
            ],
          ),
        ));
  }
}

numberIsUnique(contacts, numberAvailable) {
  bool isUnique = true;
  for (var contact in contacts) {
    if (getNumberWithoutAreaCode(numberAvailable) ==
        getNumberWithoutAreaCode(contact.phone)) {
      isUnique = false;
    }
  }
  return isUnique;
}

checkForNumberValidity(numberInput) {
  bool isValid = false;

  try {
    if (isNumeric(numberInput) == true) {
      if (numberInput.substring(0, 1) == '0' && numberInput.length == 10) {
        isValid = true;
      } else if (numberInput.substring(0, 1) == '+') {
        if (numberInput.indexOf('+255') >= 0 && numberInput.length == 13) {
          isValid = true;
        } else {
          isValid = false;
        }
      }
    }

  } catch(e){
    isValid = false;
  }

  return isValid;
}
bool isNumeric(String s) {
  if(s == null) {
    return false;
  }
  return double.parse(s, (e) => null) != null;
}
getNumberWithoutAreaCode(rawNumber) {
  if (rawNumber.indexOf("+255") >= 0) {
    return "0" + rawNumber.substring(4);
  } else {
    return rawNumber;
  }
}
