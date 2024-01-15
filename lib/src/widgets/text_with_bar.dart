import 'package:flutter/material.dart';

class Textwithbar extends StatelessWidget{
  final String text;

  const Textwithbar({required this.text, super.key});

  @override
  Widget build(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 16.0
          ),
        ),
        const SizedBox(height: 8),
         Material(
            elevation: 4.0,
            child: Container(
              color: const Color.fromARGB(255, 137, 136, 136),
              height: 2.0,
            ),
          )
      ],
    );
  }
}