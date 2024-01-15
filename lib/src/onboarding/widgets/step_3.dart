import 'package:flutter/material.dart';

class Step3 extends StatelessWidget {
  const Step3({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(26.0),
      child: (Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Adjust the space based on your design
          const Text(
            'Capture Progress: \nTake a photo while completing each task. Our advanced neural network identifies your achievements, helping you stay on track.',
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
            'assets/images/photoView2.png', // Ensure this is the correct path
            width: 250, // Adjust the size based on your design
            height: 250,
          ),
        ],
      )),
    );

    // If there's more content, add more widgets here
  }
}
