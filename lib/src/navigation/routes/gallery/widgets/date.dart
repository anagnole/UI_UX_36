import 'package:flutter/material.dart';

class DateWidget extends StatelessWidget {
  final String? date;

  const DateWidget({this.date, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.02,
        ),
        Row(
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.05,
            ),
            Text(
              date!,
              style: const TextStyle(fontFamily: 'Viga', fontSize: 24.0),
            ),
          ],
        ),
        Container(
            width: MediaQuery.sizeOf(context).width,
            child: const Image(image: AssetImage("assets/images/line_2.png")))
      ],
    );
  }
}
