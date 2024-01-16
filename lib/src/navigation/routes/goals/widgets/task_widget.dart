import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:snapgoals_v2/src/app_state.dart';
import 'package:snapgoals_v2/src/navigation/routes/camera/camera.dart';
import 'package:vibration/vibration.dart';

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
        boxColor = Color(0xFFFFC7C2);
        secondaryColor = Color(0xFFFF7556);
        break;
      case "social":
        boxColor = Color(0xFFAFF4C6);
        secondaryColor = Color(0xFF14AE5C);

        break;
      case "study":
        boxColor = Color(0xFFFFFCBD);
        secondaryColor = Color(0xFFCFC707);
        break;
    }
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    var appState = context.watch<AppState>();
    appState.fetchTasks();

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
                const Spacer(),
                IconButton(
                  onPressed: () async {
                    Vibration.vibrate(duration: 50);
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return (AlertDialog(
                            backgroundColor:
                                const Color.fromARGB(255, 255, 254, 253),
                            title: const Text('Delete Goal'),
                            content: const Text(
                                'Are you sure you want to delete this goal?'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Cancel')),
                              TextButton(
                                  onPressed: () async {
                                    await appState.snapgoalsDB.delete(task_id);
                                    appState.fetchTasks();

                                    appState.notify();
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Delete')),
                            ],
                          ));
                        });
                  },
                  icon: Image.asset(scale: 0.5, 'assets/images/trash.png'),
                ),
              ],
            )),
        SizedBox(
          width: screenWidth * 0.03,
        ),
        IconButton(
            onPressed: () async {
              WidgetsFlutterBinding.ensureInitialized();
              List<CameraDescription> cameras = await availableCameras();
              if (cameras.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CameraScreen(
                            cameras: cameras,
                            taskId: task_id,
                          )),
                );
              }
            },
            icon: SvgPicture.asset('assets/images/camera.svg'))
      ],
    );
  }
}
