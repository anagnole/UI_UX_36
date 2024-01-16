import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snapgoals_v2/src/onboarding/widgets/step_1.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:snapgoals_v2/src/onboarding/widgets/step_2.dart';
import 'package:snapgoals_v2/src/onboarding/widgets/step_3.dart';
import 'package:snapgoals_v2/src/onboarding/widgets/step_4.dart';
import 'package:snapgoals_v2/src/onboarding/widgets/step_5.dart';
import 'package:snapgoals_v2/src/onboarding/widgets/step_6.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController _controller = PageController();

  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_updatePageIndex);
  }

  void _updatePageIndex() {
    if (_controller.page!.round() != _currentPageIndex) {
      setState(() {
        _currentPageIndex = _controller.page!.round();
      });
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_updatePageIndex);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 0.5,
                    blurRadius: 10,
                    offset: const Offset(0, 8),
                  )
                ]),
                child: _currentPageIndex != 5
                    ? TextButton(
                        onPressed: () async {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setBool('hasCompletedOnBoarding', true);
                          Navigator.of(context).pop();
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          backgroundColor: Colors.white.withOpacity(
                              0.85), // Optional: add background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          primary: Colors
                              .blue, // This is the primary color of the button (text color)
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: const Text(
                          'Skip',
                          style: TextStyle(
                            fontSize: 18.0, // Increase font size
                            color: Colors.black,
                          ),
                        ))
                    : const SizedBox(height: 48),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30, right: 25, left: 25),
                child: Container(
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
                  child: Stack(children: [
                    PageView(
                      controller: _controller,
                      children: const <Widget>[
                        Step1(),
                        Step2(),
                        Step3(),
                        Step4(),
                        Step5(),
                        Step6(),
                      ],
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 10, // Adjust the position as needed
                      child: Center(
                        child: SmoothPageIndicator(
                          controller:
                              _controller, // Connect the dots to the page controller
                          count: 6, // The number of pages
                          effect:
                              const WormEffect(), // Choose the effect you like
                          onDotClicked: (index) {
                            _controller.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          },
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
