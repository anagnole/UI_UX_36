import 'package:flutter/material.dart';
import '../../../widgets/text_with_bar.dart';

class TaskPage extends StatelessWidget{
  const TaskPage({super.key});

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
                  image: const DecorationImage(
                    image:  AssetImage('assets/images/test_image.jpg'),
                    fit: BoxFit.fill,),
                ),
              ),
              SizedBox(height: screenHeight*0.01),
              const Textwithbar(text: "Description"),
              SizedBox(height: screenHeight*0.01),
              Container(
                height: screenHeight*0.12,
                decoration: BoxDecoration(
                  color: const Color(0xFF3B8BB1),
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(25.0), 
                ),
              ),
              SizedBox(height: screenHeight*0.01),
              const Textwithbar(text: "Date"),
              SizedBox(height: screenHeight*0.01),
              Container(
                height: screenHeight*0.08,
                decoration: BoxDecoration(
                  color: const Color(0xFF3B8BB1),
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(25.0), 
                ),
              ),
              SizedBox(height: screenHeight*0.01),
              const Textwithbar(text: "location"),
              SizedBox(height: screenHeight*0.01),
              Container(
                height: screenHeight*0.08,
                decoration: BoxDecoration(
                  color: const Color(0xFF3B8BB1),
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(25.0), 
                ),
              ), 
            ]),
        ),
      ),
    );
  }
}