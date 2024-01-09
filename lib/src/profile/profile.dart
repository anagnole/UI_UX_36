import 'package:flutter/material.dart';
import '../appbar_withx.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SnapGoalsAppBar2(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'), // Replace with your image path
            fit: BoxFit.fill, // Adjust the image fit as needed
          ),

        ),
      ),
    );
  }
}
