import 'package:flutter/material.dart';
import '../appbar_etc.dart';

class SamplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SnapGoalsAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'This is a sample page!',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement button functionality here
              },
              child: Text('Sample Button'),
            ),
          ],
        ),
      ),
    );
  }
}

// Example usage of this page in another widget or screen:
// Navigator.push(
//   context,
//   MaterialPageRoute(builder: (context) => SamplePage()),
// );
