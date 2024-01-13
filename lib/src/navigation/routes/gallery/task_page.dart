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
    Color scolor = Colors.black;
    String title = widget.task?.title?? 'No title available';
    switch (widget.task?.category){
      case "fitness":
        scolor = const Color(0xFFFF7556);
        break;
      case "social":
        scolor = const Color(0xFF14AE5C);
        break;
      case "study":
        scolor = const Color(0xFFCFC707);
        break;
    }
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Textwithbar(text: title),
              SizedBox(height: screenHeight*0.01),
              Container(
                height: screenHeight*0.45,
                width: screenWidth*0.7,
                decoration: BoxDecoration(  
                  border:  Border.all(
                    color: scolor,
                    width: 12.0,
                    ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: widget.task?.picture != null
                  ? Image(image: MemoryImage(widget.task!.picture),fit: BoxFit.cover)
                  : Image.asset('assets/images/test_image.jpg', fit: BoxFit.fill),

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
                  borderRadius: BorderRadius.circular(17.0), 
                ),
                child:  Padding(padding: const EdgeInsets.only(left: 12.0, top: 6.0),
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
                  borderRadius: BorderRadius.circular(17.0), 
                ),
                child: Padding(padding: const EdgeInsets.only(left: 12.0, top: 6.0),
                    child:Text(widget.task?.updatedAt?? 'Date not available',
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