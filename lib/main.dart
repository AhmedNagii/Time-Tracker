import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:time_tracker/app/landing_page.dart';
import 'package:provider/provider.dart';
import '/services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<Authbase>(
      create: (context) => Auth(),
      child: MaterialApp(
        title: 'Timer Tracker',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: const LandingPage(),
      ),
    );
  }
}
