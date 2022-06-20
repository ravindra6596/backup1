import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

removeItemAlert(BuildContext context, String title, String subtitle,
    Function function) async {
  if (Platform.isAndroid || Platform.isWindows || Platform.isLinux) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(subtitle),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
              child: const Text('Ok'),
              onPressed: () {
                function();
                Navigator.of(context).pop();
              }),
        ],
      ),
    );
  } else {
    return showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(subtitle),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
              child: Text('Ok'),
              onPressed: () {
                function();
                Navigator.of(context).pop();
              }),
        ],
      ),
    );
  }
}
