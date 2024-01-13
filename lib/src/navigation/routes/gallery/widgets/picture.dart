import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:snapgoals_v2/service/models/task.dart';
import 'package:snapgoals_v2/src/widgets/modal_animation.dart';

import 'package:snapgoals_v2/src/modal/modal.dart';

class GoalImageWidget extends StatefulWidget {
  final Task task;

  const GoalImageWidget({super.key, required this.task});

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
    ;
    late Color secondaryColor;

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
