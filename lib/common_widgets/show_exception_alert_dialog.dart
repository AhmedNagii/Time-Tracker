import 'package:flutter/cupertino.dart';
import 'package:time_tracker/common_widgets/alert_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> showExceptionAlertDialog(
  BuildContext context, {
  @required String title,
  @required Exception exception,
}) =>
    showAlertDialog(context,
        title: title, content: _message(exception), defaultActionText: 'OK');

String _message(Exception exception) {
  if (exception is FirebaseException) {
    return exception.message;
  }
  return exception.toString();
}
