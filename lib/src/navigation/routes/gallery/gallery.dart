import 'package:flutter/material.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});
  @override
  build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Text(
        'Gallery page',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      // decoration: const BoxDecoration(
      //   image: DecorationImage(
      //     image: AssetImage(
      //         'assets/images/background.png'), // Replace with your image path
      //     fit: BoxFit.fill, // Adjust the image fit as needed
      //   ),
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
    );
  }
}

// Example usage of this page in another widget or screen:
// Navigator.push(
//   context,
//   MaterialPageRoute(builder: (context) => SamplePage()),
// );
