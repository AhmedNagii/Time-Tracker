import 'package:flutter/material.dart';
import 'package:time_tracker/common_widgets/alert_dialog.dart';
import 'package:time_tracker/common_widgets/show_exception_alert_dialog.dart';
import 'package:time_tracker/services/auth.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  Future<void> _sginOut(BuildContext context) async {
    final auth = Provider.of<Authbase>(context, listen: false);
    try {
      await auth.signOut();
    } catch (e) {
      showExceptionAlertDialog(context, title: 'Logout failed', exception: e);
    }
  }

  Future<void> _confirmSignInOut(BuildContext context) async {
    final didRequestSignOut = await showAlertDialog(context,
        title: 'Logout',
        content: 'Are you sure you want ro logout',
        defaultActionText: 'Logout',
        cancelActionText: 'Cancel');
    if (didRequestSignOut == true) {
      _sginOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'Logout',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            onPressed: () => _confirmSignInOut(context),
          ),
        ],
      ),
      body: Container(),
    );
  }
}
