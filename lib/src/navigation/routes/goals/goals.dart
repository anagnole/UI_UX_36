import 'package:flutter/material.dart';
import 'package:snapgoals_v2/service/models/task.dart';
import 'package:snapgoals_v2/src/app_state.dart';
import 'package:snapgoals_v2/src/navigation/routes/goals/widgets/create_goal.dart';
import 'package:provider/provider.dart';
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
                      padding: const EdgeInsets.only(left: 25.0, top: 20),
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            final task = tasks[index];
                            //appState.tasks.add(task);

                            return TaskWidget(
                                task_id: task.id,
                                category: task.category,
                                title: task.title);
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 12,
                              ),
                          itemCount: tasks.length),
                    );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(modalAnimation(
              CreateGoal(
                  onSubmit: (title, category, picture, description) async {
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
