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

    List<GoalImageWidget> widgetList = [];

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
              print('taks' + tasks.length.toString());
              for (Task a in tasks) {
                widgetList.add(GoalImageWidget(
                   task: a));
              }
              return Column(
                children: [
                  SizedBox(height: 20.0),
                  Container(
                    height: screenHeight * 0.73,
                    width: screenWidth,
                    child: ListView.builder(
                      itemCount: (widgetList.length / 2).ceil(),
                      itemBuilder: (context, index) {
                        if (widgetList.length % 2 != 0 &&
                            index == (widgetList.length / 2).ceil() - 1) {
                          return Row(
                            children: [
                              SizedBox(width: screenWidth * 0.03),
                              Card(
                                elevation: 20.0,
                                child: widgetList[2 * index],
                              ),
                            ],
                          );
                        } else {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Card(
                                    elevation: 20.0,
                                    child: widgetList[2 * index],
                                  ),
                                  SizedBox(width: screenWidth * 0.1),
                                  // GestureDetector(
                                  //   onTap: () {
                                  //     Navigator.of(context).push(modalAnimation(
                                  //         const Modal(pageName: 'taskPage')));
                                  //   },
                                  //   child:
                                  Card(
                                      elevation: 20,
                                      child: widgetList[2 * index + 1]),

                                  //),
                                ],
                              ),
                              SizedBox(height: screenHeight * 0.015),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                ],
              );
            }
          }),
    );
  }
}
