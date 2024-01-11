import 'package:flutter/material.dart';


class MyImageWidget extends StatelessWidget {
  final String imageUrl;
  final Color borderColor;

  MyImageWidget({required this.imageUrl, required this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
          width: 2.0,
        ),
      ),
      padding: EdgeInsets.all(10.0),
      child: Image.network(
        imageUrl,
        width: 200.0, // Adjust the width as needed
        height: 150.0, // Adjust the height as needed
        fit: BoxFit.cover,
      ),
    );
  }
}