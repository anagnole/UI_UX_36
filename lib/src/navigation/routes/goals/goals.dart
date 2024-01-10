import 'package:flutter/material.dart';
import 'package:snapgoals_v2/service/models/task.dart';
import 'package:snapgoals_v2/src/app_state.dart';
import 'package:snapgoals_v2/src/navigation/routes/goals/widgets/create_goal.dart';
import 'package:provider/provider.dart';

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
                        final subTitle =
                            DateTime.parse(task.updatedAt ?? task.createdAt)
                                .toString();

                        return ListTile(
                          title: Text(
                            task.title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(subTitle),
                          trailing: IconButton(
                            onPressed: () async {
                              await appState.snapgoalsDB.delete(task.id);
                              appState.fetchTasks();
                              appState.notify();
                            },
                            icon: const Icon(Icons.delete, color: Colors.red),
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => CreateGoal(
                                onSubmit: (title) async {
                                  await appState.snapgoalsDB
                                      .update(id: task.id, title: title);
                                  appState.fetchTasks();
                                  appState.notify();
                                  //if (!mounted) return;
                                  Navigator.of(context).pop();
                                },
                              ),
                            );
                          },
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
            showDialog(
              context: context,
              builder: (_) => CreateGoal(onSubmit: (title) async {
                await appState.snapgoalsDB.create(title: title);
                //if (!mounted) return;
                appState.fetchTasks();
                appState.notify();
                Navigator.of(context).pop();
              }),
            );
          },
        ));
  }
}
