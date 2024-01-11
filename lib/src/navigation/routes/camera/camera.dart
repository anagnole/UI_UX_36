import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:snapgoals_v2/src/appbar_etc.dart';





class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  CameraScreen({required this.cameras});

  @override
  _CameraViewPageState createState() => _CameraViewPageState();
}

class _CameraViewPageState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  int current_camera=1;

  @override
  void initState() {
    super.initState();
    // Initialize the camera controller
    _controller = CameraController(
      widget.cameras[current_camera],
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed
    _controller.dispose();
    super.dispose();
  }







@override
Widget build(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return Scaffold(
    body: Container(
        child: Column(
          children: [
            // Purple bar at the top
            Container(
              height: screenHeight * 0.04, // Adjust the height as needed
              color: const Color(0xFF5F54A6),
            ),
            Expanded(
      child: GestureDetector(
        onDoubleTap: () {
                  // Handle double tap
                  setState(() {
                    current_camera=(current_camera+1)%2;
                    _controller = CameraController(
                widget.cameras[current_camera],
                   ResolutionPreset.medium,);

                  _initializeControllerFuture = _controller.initialize();
                  });
                },
        child: Stack(
          children: <Widget>[
            FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // If the Future is complete, display the preview
                  return SizedBox.expand(
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: _controller.value.previewSize!.height,
                        height: _controller.value.previewSize!.width,
                        child: CameraPreview(_controller),
                      ),
                    ),
                  );
                } else {
                  // Otherwise, display a loading indicator
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            const Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              child: CameraAppBar(),
            ),
            Positioned(
              bottom: screenHeight * 0.03, // 10% from the bottom
              left: screenWidth / 2 -48, // Adjust the icon size (24.0) as needed
              child: IconButton(
                iconSize: 24.0,
                icon: Image.asset('assets/images/shutter_button.png'),
                onPressed: () {
                  // Handle button click
                },
              ),
            ),
          ],
        ),
      ),
    ), Container(
              height: screenHeight * 0.04, // Adjust the height as needed
              color: const Color(0xFF5F54A6),
            ),]))
  );
}

}