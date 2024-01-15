import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Step6 extends StatelessWidget {
  const Step6({
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
            "Get Started: \nLet's make every day count! Begin by setting up your goals and start snapping progress photos to achieve them.\nLet's embark on this journey together! 🚀",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontFamily: 'Viga',
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 48), // Adjust the space based on your design
          GestureDetector(
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool('hasCompletedOnBoarding', true);
              Navigator.of(context).pop();
            },
            child: Image.asset(
              'assets/images/Vector.png', // Ensure this is the correct path
              width: 250, // Adjust the size based on your design
              height: 250,
            ),
          ),
        ],
      )),
    );

    // If there's more content, add more widgets here
  }
}
