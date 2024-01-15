import 'package:flutter/material.dart';

class SuccessPopup extends StatelessWidget {
  final String title;
  final String content;
  final String button1;
  final VoidCallback onButton1Pressed;

  const SuccessPopup(
      {required this.title,
      required this.content,
      required this.button1,
      required this.onButton1Pressed,
      super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 175, 244, 198),
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: onButton1Pressed,
          child: Text(button1),
        ),
      ],
    );
  }
}

Future<void> showSuccessPopup(BuildContext context) async {
  const String customDialogTitle = "Success";
  const String customDialogContent = "Congratulations! You completed the task.";
  const String customButton1Text = "Ok";

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return SuccessPopup(
        title: customDialogTitle,
        content: customDialogContent,
        button1: customButton1Text,
        onButton1Pressed: () {
          Navigator.pop(context);
          return;
        },
      );
    },
  );
}
