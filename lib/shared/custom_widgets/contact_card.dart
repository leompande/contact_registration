//ContactCard
import 'package:contact_archive/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactCard extends StatelessWidget {
  Contact contact;

  ContactCard(this.contact);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.all(0.0),
      child: Card(
        elevation: 0.1,
        margin: new EdgeInsets.symmetric(horizontal: 2.5, vertical: 2.5),
        child: Container(
//        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
          child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              leading: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.phone),
                      Container(
                        padding: EdgeInsets.all(10.0),
                      ),
                      Text(
                        "${contact.phone}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 19.0),
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(5.0),
                  ),
                  contact.creator != null
                      ? Row(
                          children: <Widget>[
//                      Icon(Icons.star, size: 12,color: Colors.grey[350],),
//                      Text(
//                        " (${contact.creator})",
//                        style: TextStyle(
//                            fontStyle: FontStyle.italic, color: Colors.grey[350]),
//                        overflow: TextOverflow.ellipsis,
//                      )
                          ],
                        )
                      : Container()
                ],
              )
              // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

//              trailing: Icon(Icons.keyboard_arrow_right, size: 30.0)
              ),
        ),
      ),
    );
  }
}
