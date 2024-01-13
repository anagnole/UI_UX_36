import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:snapgoals_v2/service/models/task.dart';
import '../../../widgets/text_with_bar.dart';

class TaskPage extends StatefulWidget{
  final Task? task;
  const TaskPage( {
    required this.task,
    super.key
  });
  
  @override
  State<TaskPage> createState() => _TaskPageState();
}


class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context){
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Textwithbar(text: "Category name"),
              SizedBox(height: screenHeight*0.01),
              Container(
                height: screenHeight*0.34,
                width: screenWidth*0.5,
                decoration: BoxDecoration(  
                  border:  Border.all(
                    color: Colors.green,
                    width: 6.0,
                    ),
                  borderRadius: BorderRadius.circular(30.0),
                  image: DecorationImage(
                    image:  /*widget.task?.picture != null
                          ? MemoryImage(Uint8List.fromList(widget.task!.picture!))
                          : AssetImage('assets/images/test_image.jpg'),*/AssetImage('assets/images/test_image.jpg'),
                    fit: BoxFit.fill,),
                ),
              ),
              SizedBox(height: screenHeight*0.01),
              const Textwithbar(text: "Description"),
              SizedBox(height: screenHeight*0.01),
              Container(
                height: screenHeight*0.12,
                width: screenWidth*0.9,
                decoration: BoxDecoration(
                  color: const Color(0xFF3B8BB1),
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(25.0), 
                ),
                child:  Padding(padding: const EdgeInsets.only(left: 8.0),
                    child:Text(widget.task?.description?? 'No description available',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                          ),
                        ),          
              ),
              SizedBox(height: screenHeight*0.01),
              const Textwithbar(text: "Date"),
              SizedBox(height: screenHeight*0.01),
              Container(
                height: screenHeight*0.08,
                width: screenWidth*0.9,
                decoration: BoxDecoration(
                  color: const Color(0xFF3B8BB1),
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(25.0), 
                ),
                child: Padding(padding: const EdgeInsets.only(left: 8.0),
                    child:Text(widget.task?.createdAt?? 'Date not available',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
              ),
              SizedBox(height: screenHeight*0.01),
              /*const Textwithbar(text: "location"),
              SizedBox(height: screenHeight*0.01),
              Container(
                height: screenHeight*0.08,
                width: screenWidth*0.9,
                decoration: BoxDecoration(
                  color: const Color(0xFF3B8BB1),
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(25.0), 
                ),
              ),*/
            ]),
        ),
      ),
    );
  }
}