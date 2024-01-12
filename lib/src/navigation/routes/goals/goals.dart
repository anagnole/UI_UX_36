import 'package:flutter/material.dart';
import 'package:snapgoals_v2/service/models/task.dart';
import 'package:snapgoals_v2/src/app_state.dart';
import 'package:snapgoals_v2/src/navigation/routes/goals/widgets/create_goal.dart';
import 'package:provider/provider.dart';
import 'package:snapgoals_v2/src/navigation/routes/camera/camera.dart';
import 'package:camera/camera.dart';
import 'package:snapgoals_v2/src/widgets/modal_animation.dart';

class GoalsPage extends StatelessWidget {
  const GoalsPage({super.key});
  @override
  build(BuildContext context) {
    var appState = context.watch<AppState>();
    appState.fetchTasks();

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<List<Task>>(
          future: appState.futureTasks,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              //appState.snapgoalsDB.deleteAll();
              final tasks = snapshot.data!;

              return tasks.isEmpty
                  ? const Center(child: Text('No Goals'))
                  : ListView.separated(
                      itemBuilder: (context, index) {
                        final task = tasks[index];
                        //appState.tasks.add(task);
                        

                        return TaskWidget(task_id: task.id, category: task.category, title: task.title);
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 12,
                          ),
                      itemCount: tasks.length);
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(modalAnimation(
              CreateGoal(
                  onSubmit: (title, category, picture, description) async {
                print('reeeeeee');
                await appState.snapgoalsDB.create(
                    title: title,
                    category: category,
                    picture: picture,
                    description: description);
                //if (!mounted) return;
                appState.fetchTasks();
                appState.notify();
                //Navigator.of(context).pop();
              }),
            ));
          },
        ));
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
                const Spacer(), // Adds flexible space between text and IconButton
                IconButton(
                  onPressed: () async {
                                  await appState.snapgoalsDB.delete(task_id);
                                  appState.fetchTasks();
                                  appState.notify();
                                },
                  icon: Image.asset('assets/images/trash.png'),
                ),
              ],
            )),
        SizedBox(
          width: screenWidth * 0.03,
        ),
        IconButton(
            onPressed:() async {
                                  WidgetsFlutterBinding.ensureInitialized();
                                  List<CameraDescription> cameras =
                                      await availableCameras();
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
            icon: Image.asset('assets/images/camera_icon.png'))
      ],
    );
  }
}
