import 'package:flutter/material.dart';
import 'package:snapgoals_v2/src/navigation/routes/camera/camera.dart';
import 'package:camera/camera.dart';

import 'widgets/picture.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});
  @override
  build(BuildContext context) {
    List<GoalImageWidget> widgetList = [
      GoalImageWidget(
        task_id: 1,
        borderColor: const Color.fromARGB(255, 39, 38, 35),
        goalImage: AssetImage('assets/images/test_image.jpg'),
      ),GoalImageWidget(
        task_id: 1,
        borderColor: Colors.yellow,
        goalImage: AssetImage('assets/images/test_image.jpg'),
      ),GoalImageWidget(
        task_id: 1,
        borderColor: Color.fromARGB(255, 29, 24, 179),
        goalImage: AssetImage('assets/images/test_image.jpg'),
      ),GoalImageWidget(
        task_id: 1,
        borderColor: Color.fromARGB(255, 223, 65, 21),
        goalImage: AssetImage('assets/images/test_image.jpg'),
      ),
      GoalImageWidget(
        task_id: 1,
        borderColor: const Color.fromARGB(255, 72, 65, 2),
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
        height: screenHeight*0.73,
        width: screenWidth, // Set a fixed height or adjust based on your design
        child: ListView.builder(
           // Set shrinkWrap to true
          itemCount: (widgetList.length / 2).ceil(),
          itemBuilder: (context, index) {

            if (widgetList.length!=2 && index==(widgetList.length / 2).ceil()-1){
              return Row(children: [SizedBox(width: screenWidth*0.05,),Card(elevation:20.0,child: widgetList[2*index])],);
            }
            else{
            return Column(
              children: [Row( mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 Card(elevation:20.0,child: widgetList[2*index]), SizedBox(width: screenWidth*0.1 ), Card(elevation:20,child: widgetList[2*index+1])
                ],
              ),SizedBox(height: screenHeight*0.015,)]
            );}
          },
        ),
      ),
        ],
      ),
    );
  }
}
