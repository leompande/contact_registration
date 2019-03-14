import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  String defaultProfilePic =
      "https://firebasestorage.googleapis.com/v0/b/tulonge-32c1c.appspot.com/o/avatar.png?alt=media&token=0af018de-e9d1-40e6-ad0a-3df4b73efc1c";

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the Drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          customAccountDrawerHeader(null,defaultProfilePic),
          ListTile(
            title: Text('Home'),
            leading: Container(
              child: Image.asset('assets/home.png'),
              width: 25.0,
            ),
            onTap: () {
              Navigator.pushNamed(context, '/home');
            },
          ),

          Divider(
            height: 15.0,
            color: Colors.grey,
          ),
          ListTile(
            title: Text('Logout'),
            leading: Container(
              child: Image.asset('assets/lock.png'),
              width: 25.0,
            ),
            onTap: () async {
              Navigator.pushNamed(context, '/');
            },
          ),
        ],
      ),
    );
  }
}

Widget customAccountDrawerHeader(data, currentProfilePic) {

  return UserAccountsDrawerHeader(
    accountEmail: null,
    accountName: Text(data!=null?'${data.fullname}'.toUpperCase():'',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
    currentAccountPicture: GestureDetector(
      child: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: NetworkImage(currentProfilePic),
      ),
      onTap: () => print("This is your current account."),
    ),
    decoration: BoxDecoration(
    ),
  );
}
