import 'package:flutter/material.dart';

class FailurePopup extends StatelessWidget{
  final String title;
  final String content;
  final String button1;
  final String button2;
  final VoidCallback onButton1Pressed;
  final VoidCallback onButton2Pressed;

  const FailurePopup({
    required this.title,
    required this.content,
    required this.button1,
    required this.button2,
    required this.onButton1Pressed,
    required this.onButton2Pressed,
    super.key
  });

  @override
  Widget build(BuildContext context){
    return AlertDialog(
      backgroundColor: const Color.fromRGBO(247, 203, 199, 0),
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(onPressed: onButton1Pressed,
        child: Text(button1) ),
        TextButton(onPressed: onButton2Pressed,
        child: Text(button2)
        )
      ],
    );
  }
}

void showSuccessPopup(BuildContext context){
  const String customDialogTitle = "Failure";
  const String customDialogContent = "You can retake the photo or complete the goal manually.";
  const String customButton1Text = "Retake";
  const String customButton2Text = "Complete Goal";

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return FailurePopup(
        title: customDialogTitle,
        content: customDialogContent,
        button1: customButton1Text,
        button2: customButton2Text,
        onButton1Pressed: () {
          // Handle Button 1 Pressed
          Navigator.pop(context);
        },
        onButton2Pressed: () {
          // Handle Button 2 Pressed
          Navigator.pop(context);
        },
      );
    },
  );
}