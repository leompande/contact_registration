import 'package:contact_archive/shared/custom_widgets/custom_mat_color.dart';
import 'package:flutter/material.dart';

import 'pages/login/login.dart';
import 'pages/home/home.dart';
import 'pages/registration/contact_form.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => Login(),
          '/home': (context) => Home('Contact Archive'),
          '/register': (context) => ContactForm(),
        },
        title: 'Contact Archive',
        theme: ThemeData(
          primarySwatch: colorCustom,
        ));
  }
}

