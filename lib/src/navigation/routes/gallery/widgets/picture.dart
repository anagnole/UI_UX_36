import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:snapgoals_v2/service/models/task.dart';
import 'package:snapgoals_v2/src/appbar_etc.dart';
import 'package:snapgoals_v2/src/widgets/modal_animation.dart';

import 'package:snapgoals_v2/src/modal/modal.dart';

class GoalImageWidget extends StatefulWidget {
  final Task task;

  const GoalImageWidget(
      {required this.task});

  @override
  State<GoalImageWidget> createState() => _GoalImageWidgetState();
}

class _GoalImageWidgetState extends State<GoalImageWidget> {
  late Task task;

  @override
    void initState() {
    super.initState();
    task = widget.task;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    Color secondaryColor = Colors.black;
    String category = widget.task.category;
    Uint8List goalImage = widget.task.picture;
    switch (category) {
      case "fitness":
        secondaryColor = const Color(0xFFFF7556);
        break;
      case "social":
        secondaryColor = const Color(0xFF14AE5C);
        break;
      case "study":
        secondaryColor = const Color(0xFFCFC707);
        break;
    }
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(modalAnimation(Modal(pageName: 'taskPage', task: task)));
      }, //go to completed task task_id
      child: Container(
          height: screenHeight * 0.25,
          width: screenWidth * 0.4,
          decoration: BoxDecoration(
              border: Border.all(
                color: secondaryColor,
                width: screenWidth * 0.4 * 0.05,
              ),
              borderRadius: BorderRadius.circular(10.0)),
          child: Image(
            image: MemoryImage(goalImage),
            fit: BoxFit.cover,
          )),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: SnapGoalsAppBar(),
        body: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SizedBox(
                  width: 30,
                ),
                TaskWidget(
                  task_id: 1,
                  title: "testing task",
                  category: "social",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TaskWidget extends StatelessWidget {
  final String title;
  final String category;
  final int task_id;

  TaskWidget(
      {required this.task_id, required this.category, required this.title});

  @override
  Widget build(BuildContext context) {
    Color boxColor = Colors.black;
    Color secondaryColor = Colors.black;
    switch (category) {
      case "fitness":
        boxColor = Color(0xFFAFF4C6);
        secondaryColor = Color(0xFF14AE5C);
        break;
      case "social":
        boxColor = Color(0xFFFFC7C2);
        secondaryColor = Color(0xFFFF7556);
        break;
      case "study":
        boxColor = Color(0xFFFFFCBD);
        secondaryColor = Color(0xFFCFC707);
        break;
    }
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Row(
      children: [
        Container(
            height: screenHeight * 0.07,
            width: screenWidth * 0.75,
            decoration: BoxDecoration(
              color: boxColor,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: secondaryColor, // Set your border color
                width: 3.0, // Set the border width
              ),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(title),
                ),
                const Spacer(), // Adds flexible space between text and IconButton
                IconButton(
                  onPressed: () async {
                    // Your delete code here
                  },
                  icon: Image.asset('assets/images/trash.png'),
                ),
              ],
            )),
        SizedBox(
          width: screenWidth * 0.03,
        ),
        IconButton(
            onPressed: () async {
              // the code that takes you to camera
            },
            icon: Image.asset('assets/images/camera_icon.png'))
      ],
    );
  }
}
