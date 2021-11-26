import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<bool> showAlertDialog(BuildContext context,
    {@required String title,
    @required String content,
    @required String defaultActionText,
    String cancelActionText}) {
  return TargetPlatform.iOS == TargetPlatform.iOS
      ? showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              if (cancelActionText != null)
                TextButton(
                  child: Text(cancelActionText),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
              TextButton(
                child: Text(defaultActionText),
                onPressed: () => Navigator.of(context).pop(true),
              )
            ],
          ),
        )
      : showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
                title: Text(title),
                content: Text(content),
                actions: <Widget>[
                  if (cancelActionText != null)
                    CupertinoDialogAction(
                      child: Text(defaultActionText),
                      onPressed: () => Navigator.of(context).pop(false),
                    ),
                  CupertinoDialogAction(
                    child: Text(defaultActionText),
                    onPressed: () => Navigator.of(context).pop(true),
                  )
                ],
              ));
}
