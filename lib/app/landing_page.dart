import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/services/auth.dart';
import '/app/home_page.dart';
import '/app/sign_in/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Authbase>(context, listen: false);
    return StreamBuilder<User>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User user = snapshot.data;
          if (user == null) {
            return const SignInPage();
          }
          return const HomePage();
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
