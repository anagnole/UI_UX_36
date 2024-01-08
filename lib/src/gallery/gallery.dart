import 'package:flutter/material.dart';
import '../appbar_etc.dart';

class GalleryPage extends StatelessWidget {
  @override
  build(BuildContext context) {
    return Scaffold(
      //appBar: SnapGoalsAppBar(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'), // Replace with your image path
            fit: BoxFit.fill, // Adjust the image fit as needed
          ),
      //   ),Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       Text(
      //         'This is a sample page!',
      //         style: TextStyle(fontSize: 20),
      //       ),
      //       SizedBox(height: 20),
      //       ElevatedButton(
      //         onPressed: () {
      //           // Implement button functionality here
      //         },
      //         child: Text('Sample Button'),
      //       ),
      //     ],
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
