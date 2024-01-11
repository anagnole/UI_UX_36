import 'package:flutter/material.dart';

class Textwithbar extends StatelessWidget{
  final String text;

  const Textwithbar({required this.text, super.key});

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        Text(text),
        const SizedBox(height: 8),
        const Divider(
          color: Colors.black,
          height: 2
        ),
      ],
    );
  }
}