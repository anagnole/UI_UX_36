import 'package:flutter/material.dart';
import 'package:snapgoals_v2/service/models/task.dart';
import 'package:snapgoals_v2/src/app_state.dart';
import 'package:snapgoals_v2/src/navigation/routes/goals/widgets/create_goal.dart';
import 'package:provider/provider.dart';
import 'package:snapgoals_v2/src/navigation/routes/goals/widgets/current_goals_text.dart';
import 'package:snapgoals_v2/src/navigation/routes/goals/widgets/task_widget.dart';

import 'package:snapgoals_v2/src/widgets/modal_animation.dart';

class GoalsPage extends StatelessWidget {
  const GoalsPage({super.key});
  @override
  build(BuildContext context) {
    var appState = context.watch<AppState>();
    appState.fetchNonCompletedTasks();

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, color: Colors.white,),
        backgroundColor: const Color(0xFF3B8BB1),
        onPressed: () {
          Navigator.of(context).push(modalAnimation(
            CreateGoal(onSubmit: (title, category, picture, keyIds) async {
              await appState.snapgoalsDB.createTask(
                title: title,
                category: category,
                picture: picture,
                keyIds: keyIds,
              );
              appState.fetchTasks();
              appState.notify();
            }),
          ));
        },
      ),
      body: FutureBuilder<List<Task>>(
        future: appState.futureNonCompletedTasks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            //appState.snapgoalsDB.deleteAll();//

            final tasks = snapshot.data!;

            return tasks.isEmpty
                ? const Center(child: Text('No Goals'))
                : Padding(
                    padding: const EdgeInsets.only(
                      left: 25.0,
                    ),
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          final task = tasks[index];
                          //appState.tasks.add(task);
                          if (index == 0) {
                            return Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                const CurrentGoalsText(text: "Current Goals"),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                TaskWidget(
                                    task_id: task.id,
                                    category: task.category,
                                    title: task.title),
                              ],
                            );
                          } else if (index == tasks.length - 1) {
                            return Column(
                              children: [
                                TaskWidget(
                                    task_id: task.id,
                                    category: task.category,
                                    title: task.title),
                                const SizedBox(
                                  height: 110,
                                )
                              ],
                            );
                          } else {
                            return Column(
                              children: [
                                TaskWidget(
                                    task_id: task.id,
                                    category: task.category,
                                    title: task.title),
                              ],
                            );
                          }
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 12,
                            ),
                        itemCount: tasks.length),
                  );
          }
        },
      ),
    );
  }
}
