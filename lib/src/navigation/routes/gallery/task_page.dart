import 'package:flutter/material.dart';
import '../../../widgets/text_with_bar.dart';

class TaskPage extends StatelessWidget{
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context){
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight*0.1),
              const Textwithbar(text: "Category name"),
              Container(
                height: screenHeight*0.3,
                decoration: BoxDecoration(  
                  border:  Border.all(
                    color: Colors.green,
                    width: 3.0,
                    ),
                  borderRadius: BorderRadius.circular(30.0),
                  image: const DecorationImage(
                    image:  AssetImage('assets/images/background.png'),
                    fit: BoxFit.fill,),
                ),
              ),
              const Textwithbar(text: "Description"),
              Container(
                height: screenHeight*0.2,
                decoration: BoxDecoration(
                  color: const Color(0xFF3B8BB1),
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(25.0), 
                ),
              ),
              const Textwithbar(text: "Date"),
              Container(
                height: screenHeight*0.1,
                decoration: BoxDecoration(
                  color: const Color(0xFF3B8BB1),
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(25.0), 
                ),
              ),
              const Textwithbar(text: "location"),
              Container(
                height: screenHeight*0.1,
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