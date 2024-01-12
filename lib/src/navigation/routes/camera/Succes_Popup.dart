import 'package:flutter/material.dart';

class SuccessPopup extends StatelessWidget{
  final String title;
  final String content;
  final String button1;
  final String button2;
  final VoidCallback onButton1Pressed;
  final VoidCallback onButton2Pressed;

  const SuccessPopup({
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
      backgroundColor: const Color.fromRGBO(175, 244, 198, 0),
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
  const String customDialogTitle = "Success";
  const String customDialogContent = "Congratulations for completing the task. Now you can either go to the home page or return to goals.";
  const String customButton1Text = "Home";
  const String customButton2Text = "Goals";

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SuccessPopup(
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