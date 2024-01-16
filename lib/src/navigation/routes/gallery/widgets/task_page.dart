import 'package:flutter/material.dart';
import 'package:snapgoals_v2/service/models/task.dart';
import '../../../../widgets/text_with_bar.dart';

class TaskPage extends StatefulWidget {
  final Task? task;
  const TaskPage({required this.task, super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    Color scolor = Colors.black;
    String title = widget.task?.title ?? 'No title available';
    String category = widget.task?.category ?? 'No title available';
    switch (widget.task?.category) {
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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              //Textwithbar(text: category),
              Column(children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(category,
                      style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Viga'),
                      textAlign: TextAlign.left),
                ),
                const SizedBox(height: 8),
                Material(
                  elevation: 4.0,
                  child: Container(
                    color: const Color.fromARGB(255, 137, 136, 136),
                    height: 2.0,
                  ),
                ),
              ]),
              SizedBox(height: screenHeight * 0.02),
              Container(
                height: screenHeight * 0.35,
                width: screenWidth * 0.60,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: scolor,
                    width: 12.0,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: widget.task?.picture != null
                    ? Image(
                        image: MemoryImage(widget.task!.picture),
                        fit: BoxFit.cover)
                    : Image.asset('assets/images/test_image.jpg',
                        fit: BoxFit.fill),
              ),
              SizedBox(height: screenHeight * 0.02),
              const Textwithbar(text: "Title"),
              SizedBox(height: screenHeight * 0.01),
              Container(
                height: screenHeight * 0.07,
                width: screenWidth * 0.9,
                decoration: BoxDecoration(
                  color: const Color(0xFF3B8BB1),
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(17.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, top: 6.0),
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              const Textwithbar(text: "Date"),
              SizedBox(height: screenHeight * 0.01),
              Container(
                height: screenHeight * 0.07,
                width: screenWidth * 0.9,
                decoration: BoxDecoration(
                  color: const Color(0xFF3B8BB1),
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(17.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, top: 6.0),
                  child: Text(
                    widget.task?.updatedAt ?? 'Date not available',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              const Textwithbar(text: "Location"),
              SizedBox(height: screenHeight * 0.01),
              Container(
                height: screenHeight * 0.07,
                width: screenWidth * 0.9,
                decoration: BoxDecoration(
                  color: const Color(0xFF3B8BB1),
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(17.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, top: 6.0),
                  child: Text(
                    widget.task?.location ?? 'Location not available',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
