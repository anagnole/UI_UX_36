import 'package:flutter/material.dart';
import 'package:snapgoals_v2/src/app_state.dart';
import 'package:provider/provider.dart';
import 'widgets/picture.dart';
import 'package:snapgoals_v2/service/models/task.dart';
import 'package:intl/intl.dart';

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
              final tasks = (snapshot.data!).reversed;
              DateTime now = DateTime.now();
              DateTime now_date = DateTime(now.year, now.month, now.day);
              String prev = "";
              String cur = "";
              for (Task a in tasks) {
                DateTime task_datetime =
                    DateFormat("EEEE d 'of' MMMM y, 'at' HH:mm")
                        .parse(a.updatedAt!);
                DateTime task_date = DateTime(
                    task_datetime.year, task_datetime.month, task_datetime.day);

                if (now_date.difference(task_date).inDays == 0) {
                  cur = "Today";
                } else {
                  if (now_date.difference(task_date).inDays == 1) {
                    cur = "Yesterday";
                  } else {
                    cur = DateFormat('E, dd/MM/yyyy').format(task_date);
                  }
                }
                if (cur != prev) {
                  widgetList.add(DateWidget(cur));
                  prev = cur;
                }
                widgetList.add(GoalImageWidget(task: a));
              }
              // widgetList.add(SizedBox(
              //   height: screenHeight * 0.1,
              // ));
              List<Widget> final_widget_list = [];
              for (int i = 0; i < widgetList.length; i++) {
                if (widgetList[i].runtimeType == DateWidget) {
                  final_widget_list.add(widgetList[i]);
                } else {
                  if (i < widgetList.length - 1) {
                    if (widgetList[i + 1].runtimeType != DateWidget) {
                      final_widget_list.add(Column(
                        children: [
                          const SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Card(
                                elevation: 20.0,
                                child: widgetList[i],
                              ),
                              SizedBox(width: screenWidth * 0.1),
                              Card(elevation: 20, child: widgetList[i + 1]),

                              //),
                            ],
                          ),
                          //SizedBox(height: screenHeight * 0.1),
                        ],
                      ));
                      i += 1;
                    } else {
                      final_widget_list.add(Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              SizedBox(width: screenWidth * 0.03),
                              Card(
                                elevation: 20.0,
                                child: widgetList[i],
                              ),
                            ],
                          ),
                          // SizedBox(
                          //   height: screenHeight * 0.15,
                          // )
                        ],
                      ));
                      final_widget_list.add(widgetList[i + 1]);
                      i += 1;
                    }
                  } else {
                    final_widget_list.add(Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            SizedBox(width: screenWidth * 0.03),
                            Card(
                              elevation: 20.0,
                              child: widgetList[i],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: screenHeight * 0.15,
                        )
                      ],
                    ));
                  }
                }
              }
              return ListView.builder(
                  itemCount: final_widget_list.length,
                  itemBuilder: (context, index) {
                    return final_widget_list[index];
                  });

              // os edo vazo ta widgets sto list
              // return ListView.builder(
              //   itemCount: (widgetList.length / 2).ceil(),
              //   itemBuilder: (context, index) {
              //     if ((widgetList.length - 1) % 2 != 0 &&
              //         index == ((widgetList.length - 1) / 2).ceil() - 1) {
              //       return Column(
              //         children: [
              //           const SizedBox(
              //             height: 20,
              //           ),
              //           Row(
              //             children: [
              //               SizedBox(width: screenWidth * 0.03),
              //               Card(
              //                 elevation: 20.0,
              //                 child: widgetList[2 * index],
              //               ),
              //             ],
              //           ),
              //           SizedBox(
              //             height: screenHeight * 0.15,
              //           )
              //         ],
              //       );
              //     } else {
              //       return Column(
              //         children: [
              //           const SizedBox(height: 20.0),
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               Card(
              //                 elevation: 20.0,
              //                 child: widgetList[2 * index],
              //               ),
              //               SizedBox(width: screenWidth * 0.1),
              //               Card(
              //                   elevation: 20,
              //                   child: widgetList[
              //                       (2 * index + 1) > widgetList.length - 1
              //                           ? widgetList.length - 1
              //                           : 2 * index + 1]),

              //               //),
              //             ],
              //           ),
              //           //SizedBox(height: screenHeight * 0.1),
              //         ],
              //       );
              //     }
              //   },
              // );
            }
          }),
    );
  }
}

class DateWidget extends StatelessWidget {
  final String date;

  DateWidget(this.date);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.02,
        ),
        Row(
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.05,
            ),
            Text(
              date,
              style: TextStyle(fontFamily: 'Viga', fontSize: 24.0),
            ),
          ],
        ),
        Container(
            width: MediaQuery.sizeOf(context).width,
            child: Image(image: AssetImage("assets/images/line_2.png")))
      ],
    );
  }
}
