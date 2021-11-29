import 'package:flutter/material.dart';
import '/app/sign_in/email_sigin_form.dart';

class EmailSignInPage extends StatelessWidget {
  const EmailSignInPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Time Tracker"),
        elevation: 3.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(child: EmailSignInForm()),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
