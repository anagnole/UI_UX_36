import 'package:flutter/material.dart';
import 'package:snapgoals_v2/src/app_state.dart';
import 'package:provider/provider.dart';
import 'widgets/picture.dart';
import 'package:snapgoals_v2/service/models/task.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});
  @override
  build(BuildContext context) {
    var appState = context.watch<AppState>();
    appState.fetchCompletedTasks();

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    List<dynamic> widgetList = [];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: FutureBuilder<List<Task>>(
          future: appState.futureCompletedTasks,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              //appState.snapgoalsDB.deleteAll(); //
              final tasks = snapshot.data!;
              for (Task a in tasks) {
                widgetList.add(GoalImageWidget(task: a));
              }
              widgetList.add(SizedBox(
                height: screenHeight * 0.1,
              ));
              return ListView.builder(
                itemCount: (widgetList.length / 2).ceil(),
                itemBuilder: (context, index) {
                  if ((widgetList.length - 1) % 2 != 0 &&
                      index == ((widgetList.length - 1) / 2).ceil() - 1) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            SizedBox(width: screenWidth * 0.03),
                            Card(
                              elevation: 20.0,
                              child: widgetList[2 * index],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: screenHeight * 0.15,
                        )
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        const SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Card(
                              elevation: 20.0,
                              child: widgetList[2 * index],
                            ),
                            SizedBox(width: screenWidth * 0.1),
                            Card(
                                elevation: 20,
                                child: widgetList[
                                    (2 * index + 1) > widgetList.length - 1
                                        ? widgetList.length - 1
                                        : 2 * index + 1]),

                            //),
                          ],
                        ),
                        //SizedBox(height: screenHeight * 0.1),
                      ],
                    );
                  }
                },
              );
            }
          }),
    );
  }
}
