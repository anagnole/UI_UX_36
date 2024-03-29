import 'package:flutter/material.dart';

class Step1 extends StatelessWidget {
  const Step1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return (Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Welcome to\nSnapGoals!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 36,
            height: 1,
            fontFamily: 'Viga',
            fontWeight: FontWeight.bold,
            color: Colors.black, // Adjust the color to match the design
          ),
        ),
        const SizedBox(height: 75), // Adjust the space based on your design
        const Text(
          'Organize your daily life\nand achieve your goals\n effortlessly. 🎯',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            fontFamily: 'Viga',
            fontWeight: FontWeight.bold,
            color: Colors.black, // Adjust the color to match the design
          ),
        ),
        const SizedBox(height: 48), // Adjust the space based on your design
        Image.asset(
          'assets/images/target_icon.png', // Ensure this is the correct path
          width: 120, // Adjust the size based on your design
          height: 120, // Adjust the size based on your design
        ),
      ],
    ));

    // If there's more content, add more widgets here
  }
}
