import 'package:flutter/material.dart';
import 'package:snapgoals_v2/src/appbar_etc.dart';

class GoalImageWidget extends StatelessWidget {
  final ImageProvider goalImage;
  final String category;
  final int task_id;

  GoalImageWidget(
      {required this.task_id,
      required this.goalImage,
      required this.category});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    Color secondaryColor = Colors.black;
    switch (category) {
      case "fitness":
        
        secondaryColor = Color.fromARGB(255, 9, 8, 7);
        break;
      case "social":
        
        secondaryColor = Color(0xFFFF7556);
        break;
      case "study":
        
        secondaryColor = Color(0xFFCFC707);
        break;
    }
    return GestureDetector(
      onTap: () {}, //go to completed task task_id
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
            image: goalImage,
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
