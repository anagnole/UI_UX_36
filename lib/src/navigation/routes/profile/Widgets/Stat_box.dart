import 'package:flutter/material.dart';
import '../../../../widgets/text_with_bar.dart';

class StatBox extends Textwithbar {
  const StatBox({required String stat, super.key}) : super(text: stat);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(32.0), // Adjust padding as needed
        decoration: BoxDecoration(
          color: const Color(0xFF3B8BB1),
          border: Border.all(color: Colors.black),
          borderRadius:
              BorderRadius.circular(17.0), // Adjust border radius as needed
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
                  text,
                  style: const TextStyle(
                  fontFamily: 'Viga',
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold
                  ),
                ),
            const SizedBox(height: 8),
            Material(
               elevation: 4.0,
               child: Container(
                  color: const Color.fromARGB(255, 82, 81, 81),
                  height: 2.0,
                  ),
                )
            ],
        ));
  }
}
