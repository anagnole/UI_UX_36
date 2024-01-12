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
              final tasks = snapshot.data!;

              return tasks.isEmpty
                  ? const Center(child: Text('No Goals'))
                  : ListView.separated(
                      itemBuilder: (context, index) {
                        final task = tasks[index];
                        //appState.tasks.add(task);
                        final subTitle =
                            DateTime.parse(task.updatedAt ?? task.createdAt)
                                .toString();

                        return ListTile(
                          title: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment
                                    .start, // Added to align text to the start
                                children: [
                                  Text(
                                    task.title,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(subTitle),
                                ],
                              ),
                              IconButton(
                                onPressed: () async {
                                  WidgetsFlutterBinding.ensureInitialized();
                                  List<CameraDescription> cameras =
                                      await availableCameras();
                                  if (cameras.isNotEmpty) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CameraScreen(
                                                cameras: cameras,
                                                taskId: task.id,
                                              )),
                                    );
                                  }
                                },
                                icon: Image.asset(
                                    'assets/images/camera_icon.png'),
                              ),
                              IconButton(
                                onPressed: () async {
                                  await appState.snapgoalsDB.delete(task.id);
                                  appState.fetchTasks();
                                  appState.notify();
                                },
                                icon: Image.asset('assets/images/trash.png'),
                              ),
                            ],
                          ),
                          // onTap: () {
                          //   Navigator.of(context).push(modalAnimation(
                          //     CreateGoal(
                          //       onSubmit: (title, category, description) async {
                          //         await appState.snapgoalsDB
                          //             .update(id: task.id, title: title);
                          //         appState.fetchTasks();
                          //         appState.notify();
                          //         //if (!mounted) return;
                          //         //Navigator.of(context).pop();
                          //       },
                          //     ),
                          //   ));
                          // },
                        );
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
              CreateGoal(onSubmit: (title, category, description) async {
                await appState.snapgoalsDB.create(
                    title: title, category: category, description: description);
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
