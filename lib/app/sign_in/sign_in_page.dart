import 'package:flutter/material.dart';

import '/app/sign_in/sign_in_button.dart';
import '/app/sign_in/social_sign_in_button.dart';
import '/services/auth.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key key, @required this.auth}) : super(key: key);

  final Authbase auth;

  Future<void> _sginInAnonymously() async {
    try {
      await auth.signInAnonymous();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _sginInWithGoogle() async {
    try {
      await auth.signInWithGoogle();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: AppBar(
        title: const Text(
          "Time Tracker",
        ),
        elevation: 3.0,
      ),
      body: _signInContant(),
      backgroundColor: Colors.grey[200],
    );
    return scaffold;
  }

  Widget _signInContant() {
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
              onPressed: _sginInWithGoogle),
          const SizedBox(height: 8.0),
          SocialSignInButton(
              assetName: 'images/facebook-logo.png',
              text: "Sign in with Facebook",
              color: const Color(0xFF334D92),
              onPressed: () {}),
          const SizedBox(height: 8.0),
          SignInButton(
              text: "Sign in with email",
              color: Colors.teal[700],
              onPressed: () {}),
          const SizedBox(height: 8.0),
          const Text('or',
              style: TextStyle(fontSize: 14.0, color: Colors.black87),
              textAlign: TextAlign.center),
          const SizedBox(height: 8.0),
          SignInButton(
            text: "Go anonymously",
            textColor: Colors.black87,
            color: Colors.lime[300],
            onPressed: _sginInAnonymously,
          ),
        ],
      ),
    );
  }
}
