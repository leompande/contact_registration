import '../../shared/helpers/authentication.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

var authHandler = new Authentication();

class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool loginFailed = false;
  String message = 'Signing in failed , wrong username or password';
  String email;
  String password;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
//        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            height: 70.0,
            margin: EdgeInsets.only(bottom: 10.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50.0),
                border: Border.all(color: Colors.grey[300])),
            padding: EdgeInsets.only(left: 20.0, bottom: 0.0),
            child: TextFormField(
                controller: _emailController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter Username';
                  }
                  if (EmailValidator.validate(value + "@gmail.com") == true) {
                  } else {
                    return 'Invalid Username';
                  }
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Username',
                )),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(bottom: 10.0),
            height: 70.0,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50.0),
                border: Border.all(color: Colors.grey[300])),
            padding: EdgeInsets.only(left: 20.0, bottom: 0.0),
            child: TextFormField(
                controller: _passwoController,
                obscureText: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter password';
                  }
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Password',
                )),
          ),
          GestureDetector(
            onTap: () async {
              if (_formKey.currentState.validate()) {
                showSnackBar(context, "Sigining in Please wait ...");
                var email = this._emailController.text + "@gmail.com";
                var password = this._passwoController.text;
                try {
                  var user =
                      await authHandler.signInWithFirebase(email, password);
                  if (user != null) {
                    showSnackBar(context, "Login successfully");
                    Navigator.pushNamed(context, '/home');
                  } else {}
                } catch (e) {
                  if (e.toString().indexOf("ERROR_NETWORK_REQUEST_FAILED") >= 0) {
                    showSnackBarMessage(context, "Login failed, No internet connection");
                  }
                }
              } else {}
            },
            child: Container(
              alignment: Alignment.center,
              height: 70.0,
              margin: EdgeInsets.only(bottom: 10.0),
              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 206, 47, 44),
                  borderRadius: BorderRadius.circular(50.0),
                  border: Border.all(color: Colors.grey[300])),
              child: Text(
                "Sign In",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20.0),
          ),
          Container(),
        ],
      ),
    );
  }
}

showSnackBar(context, message) {
  Scaffold.of(context).showSnackBar(SnackBar(
      content: Container(
    child: Row(
      children: <Widget>[CircularProgressIndicator(), Text("${message}")],
    ),
  )));
}

showSnackBarMessage(context, message) {
  Scaffold.of(context).showSnackBar(SnackBar(
      content: Container(
        child: Row(
          children: <Widget>[Text("${message}")],
        ),
      )));
}
