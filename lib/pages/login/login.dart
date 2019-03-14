import 'package:contact_archive/pages/login/login_form.dart';
import 'package:contact_archive/shared/custom_widgets/custom_mat_color.dart';

import 'package:flutter/material.dart';

class Login extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 0.0),
            child: ListView(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 10.0,
                      ),
                      Center(
                        child: Image.asset(
                          'assets/logo.png',
                          width: 150.0,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(15.0),
                  alignment: Alignment.center,
                  child: Text(
                    'Contact Archive',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 25.0, color: colorCustom),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: LoginForm(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

//class LoginState extends State<Login> {
//
//}


