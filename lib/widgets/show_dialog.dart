import 'package:flutter/material.dart';

customShowDialog({
  required BuildContext context,
  String? header,
  String? textButton,
  required VoidCallback onButtonPressed,
  required TextEditingController textController
}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(header ?? ''),
        content: TextField(
          controller: textController,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: onButtonPressed,
            child: Text(textButton ?? ''),
          ),
        ],
      );
    },
  );
}
