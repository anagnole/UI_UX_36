import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:snapgoals_v2/service/models/task.dart';
import 'package:snapgoals_v2/src/app_state.dart';
import 'package:snapgoals_v2/src/widgets/modal_animation.dart';

import 'package:snapgoals_v2/src/modal/modal.dart';
import 'package:vibration/vibration.dart';

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
    var appState = context.watch<AppState>();
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
      onLongPress: () {
        Vibration.vibrate(duration: 300);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return (AlertDialog(
                backgroundColor: const Color.fromARGB(255, 255, 254, 253),
                title: const Text('Delete Photo'),
                content:
                    const Text('Are you sure you want to delete this photo?'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel')),
                  TextButton(
                      onPressed: () async {
                        await appState.snapgoalsDB.delete(task.id);
                        appState.notify();
                        Navigator.of(context).pop();
                      },
                      child: const Text('Delete')),
                ],
              ));
            });
      },
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
