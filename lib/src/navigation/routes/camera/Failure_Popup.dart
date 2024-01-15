import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:snapgoals_v2/service/database/snapgoals_db.dart';

class FailurePopup extends StatelessWidget {
  final String title;
  final String content;
  final String button1;
  final String button2;
  final VoidCallback onButton1Pressed;
  final VoidCallback onButton2Pressed;

  const FailurePopup(
      {required this.title,
      required this.content,
      required this.button1,
      required this.button2,
      required this.onButton1Pressed,
      required this.onButton2Pressed,
      super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 247, 203, 199),
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(onPressed: onButton1Pressed, child: Text(button1)),
        TextButton(onPressed: onButton2Pressed, child: Text(button2))
      ],
    );
  }
}

Future<void> showFailurePopup(
    BuildContext context, SnapgoalsDB db, int taskId, Uint8List picture) async {
  const String customDialogTitle = "Failure";
  const String customDialogContent =
      "You can retake the photo or complete the goal manually.";
  const String customButton1Text = "Retake";
  const String customButton2Text = "Complete Goal";
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return FailurePopup(
        title: customDialogTitle,
        content: customDialogContent,
        button1: customButton1Text,
        button2: customButton2Text,
        onButton1Pressed: () {
          Navigator.of(context).pop();
        },
        onButton2Pressed: () async {
          await db.update(id: taskId, picture: picture);

          //Navigator.of(context).pop();

          // Handle Button 2 Pressed
          //Navigator.pushReplacementNamed(context, '/goals');
        },
      );
    },
  );
}
