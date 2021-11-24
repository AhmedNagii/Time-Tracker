import 'package:flutter/material.dart';
import '/app/sign_in/email_sigin_form.dart';
import '/services/auth.dart';

class EmailSignInPage extends StatelessWidget {
  EmailSignInPage({Key key, @required this.auth}) : super(key: key);
  final Authbase auth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Time Tracker"),
        elevation: 3.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
            child: EmailSignInForm(
          auth: auth,
        )),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}