import 'package:flutter/material.dart';
import 'package:time_tracker/common_widgets/show_exception_alert_dialog.dart';
import 'package:time_tracker/services/auth.dart';
import '/app/sign_in/email_sign_in_page.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '/app/sign_in/sign_in_button.dart';
import '/app/sign_in/social_sign_in_button.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({
    Key key,
  }) : super(key: key);

  void _showSignInError(BuildContext context, Exception exception) {
    if (exception is FirebaseException &&
        exception.code == 'ERROR_ABORTED_BY_USER') {
      return;
    }

    showExceptionAlertDialog(context,
        title: 'Sgin in faild', exception: exception);
  }

  Future<void> _sginInAnonymously(BuildContext context) async {
    final auth = Provider.of<Authbase>(context, listen: false);
    try {
      await auth.signInAnonymous();
    } catch (e) {
      _showSignInError(context, e);
    }
  }

  Future<void> _sginInWithGoogle(BuildContext context) async {
    final auth = Provider.of<Authbase>(context, listen: false);
    try {
      await auth.signInWithGoogle();
    } catch (e) {
      _showSignInError(context, e);
    }
  }

  Future<void> _sginInWithFacebook(BuildContext context) async {
    final auth = Provider.of<Authbase>(context, listen: false);
    try {
      await auth.signInWithFacebook();
    } catch (e) {
      _showSignInError(context, e);
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (context) => const EmailSignInPage(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Time Tracker",
        ),
        elevation: 3.0,
      ),
      body: _signInContant(context),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _signInContant(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Sign In',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 48.0),
          SocialSignInButton(
              assetName: 'images/google-logo.png',
              text: "Sign in with Google",
              color: Colors.black87,
              onPressed: () => _sginInWithGoogle(context)),
          const SizedBox(height: 8.0),
          SocialSignInButton(
              assetName: 'images/facebook-logo.png',
              text: "Sign in with Facebook",
              color: const Color(0xFF334D92),
              onPressed: () => _sginInWithFacebook(context)),
          const SizedBox(height: 8.0),
          SignInButton(
              text: "Sign in with email",
              color: Colors.teal[700],
              onPressed: () => _signInWithEmail(context)),
          const SizedBox(height: 8.0),
          const Text('or',
              style: TextStyle(fontSize: 14.0, color: Colors.black87),
              textAlign: TextAlign.center),
          const SizedBox(height: 8.0),
          SignInButton(
            text: "Go anonymously",
            textColor: Colors.black87,
            color: Colors.lime[300],
            onPressed: () => _sginInAnonymously(context),
          ),
        ],
      ),
    );
  }
}
