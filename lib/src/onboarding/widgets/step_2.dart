import 'package:flutter/material.dart';

class Step2 extends StatelessWidget {
  const Step2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: (Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Adjust the space based on your design
          const Text(
            'Set Your Goals: \nStart by creating your daily tasks. Select from Study 📚, Fitness 🏋️, or Social 🤝 categories to streamline your objectives.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontFamily: 'Viga',
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 48), // Adjust the space based on your design
          Image.asset(
            'assets/images/photoView.png', // Ensure this is the correct path
            width: 250, // Adjust the size based on your design
            height: 250,
          ),
        ],
      )),
    );

    // If there's more content, add more widgets here
  }
}
