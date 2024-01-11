import 'package:flutter/material.dart';
import '../../../../widgets/text_with_bar.dart';

class StatBox extends Textwithbar{
  const StatBox({required String stat, super.key}) : super(text: stat);

    @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0), // Adjust padding as needed
      decoration: BoxDecoration(
        color: const Color(0xFF3B8BB1),
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8.0), // Adjust border radius as needed
      ),
      child: const Column(
        children:[
        Text('Stat')
        ],
      )
    );
  }
}

