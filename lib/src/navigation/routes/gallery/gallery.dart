import 'package:flutter/material.dart';
import 'package:snapgoals_v2/src/modal/modal.dart';
import 'package:snapgoals_v2/src/navigation/routes/camera/failure_Popup.dart';
import 'package:snapgoals_v2/src/widgets/modal_animation.dart';

import 'widgets/picture.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});
  @override
  build(BuildContext context) {
    List<GoalImageWidget> widgetList = [
      GoalImageWidget(
        task_id: 1,
        category: 'fitness',
        goalImage: AssetImage('assets/images/test_image.jpg'),
      ),
      GoalImageWidget(
        task_id: 1,
        category: 'fitness',
        goalImage: AssetImage('assets/images/test_image.jpg'),
      ),
      GoalImageWidget(
        task_id: 1,
        category: 'fitness',
        goalImage: AssetImage('assets/images/test_image.jpg'),
      ),
      GoalImageWidget(
        task_id: 1,
        category: 'fitness',
        goalImage: AssetImage('assets/images/test_image.jpg'),
      ),
      GoalImageWidget(
        task_id: 1,
        category: 'fitness',
        goalImage: AssetImage('assets/images/test_image.jpg'),
      ),
      // Add more widgets as needed
    ];
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          SizedBox(height: 20.0),
          Container(
            height: screenHeight * 0.73,
            width: screenWidth,
            child: ListView.builder(
              itemCount: (widgetList.length / 2).ceil(),
              itemBuilder: (context, index) {
                if (widgetList.length != 2 &&
                    index == (widgetList.length / 2).ceil() - 1) {
                  return Row(
                    children: [
                      SizedBox(width: screenWidth * 0.05),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(modalAnimation(
                              const Modal(pageName: 'taskPage')));
                          
                        },
                        child: InkResponse(
                          onTap: () {
                            Navigator.of(context).push(modalAnimation(
                                const Modal(pageName: 'taskPage')));
                            // Handle tap as needed
                          },
                          child: Card(
                            elevation: 20.0,
                            child: widgetList[2 * index],
                          ),
                          highlightShape: BoxShape.rectangle,
                        ),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                            },
                            child: InkResponse(
                              onTap: () {
                                showFailurePopup(context);
                                //Navigator.of(context).push(modalAnimation(const Modal(pageName: 'taskPage')));                               
                              },
                              child: Card(
                                elevation: 20.0,
                                child: widgetList[2 * index],
                              ),
                              highlightShape: BoxShape.rectangle,
                            ),
                          ),

                          // InkWell(
                          //   onTap: () {
                          //     print('giorgio');
                          //   },
                          //   child: InkResponse(
                          //     onTap: () {
                          //       Navigator.of(context).push(modalAnimation(const Modal(pageName: 'taskPage')));
                          //       // Handle tap as needed
                          //       print('giorgio');
                          //     },
                          //     child: Card(
                          //       elevation: 20.0,
                          //       child: widgetList[2 * index],
                          //     ),
                          //     highlightShape: BoxShape.rectangle,
                          //   ),
                          // ),
                          SizedBox(width: screenWidth * 0.1),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(modalAnimation(
                                  const Modal(pageName: 'taskPage')));                             
                            },
                            child: InkResponse(
                              onTap: () {
                                Navigator.of(context).push(modalAnimation(
                                    const Modal(pageName: 'taskPage')));
                                // Handle tap as needed
                              },
                              child: Card(
                                elevation: 20,
                                child: widgetList[2 * index + 1],
                              ),
                              highlightShape: BoxShape.rectangle,
                            ),
                          ),
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
      ),
    );
  }
}
