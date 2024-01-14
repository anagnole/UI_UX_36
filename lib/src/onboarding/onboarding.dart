import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snapgoals_v2/src/onboarding/widgets/step_1.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setBool('hasCompletedOnBoarding', true);
                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  backgroundColor: Colors.white
                      .withOpacity(0.85), // Optional: add background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  primary: Colors
                      .blue, // This is the primary color of the button (text color)
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Text(
                  'Skip',
                  style: TextStyle(
                    fontSize: 18.0, // Increase font size
                    color: Colors
                        .blue, // You can change the color of the text if needed
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30, right: 25, left: 25),
                child: Container(
                  padding: const EdgeInsets.all(48.0),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                    gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [
                          0.0,
                          0.5,
                          1.0
                        ],
                        colors: <Color>[
                          Color(0xFFFFFFFF),
                          Colors.grey,
                          Color(0xFFFFFFFF)
                        ]),
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  child: PageView(
                    children: const <Widget>[
                      Step1(),
                      Step1(),
                      Step1(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
