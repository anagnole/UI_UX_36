import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:snapgoals_v2/service/database/snapgoals_db.dart';
import 'package:snapgoals_v2/src/app_state.dart';
import 'package:snapgoals_v2/src/appbar_etc.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  final int taskId;

  const CameraScreen({super.key, required this.cameras, required this.taskId});

  @override
  State<CameraScreen> createState() => _CameraViewPageState();
}

class _CameraViewPageState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  int currentCamera = 1;
  late int taskId;
  @override
  void initState() {
    super.initState();
    taskId = widget.taskId;
    // Initialize the camera controller
    _controller = CameraController(
      widget.cameras[currentCamera],
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
    var appState = context.watch<AppState>();
    SnapgoalsDB db = appState.snapgoalsDB;

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Column(children: [
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
              currentCamera = (currentCamera + 1) % 2;
              _controller = CameraController(
                widget.cameras[currentCamera],
                ResolutionPreset.medium,
              );

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
                    return const Center(child: CircularProgressIndicator());
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
                left: screenWidth / 2 -
                    48, // Adjust the icon size (24.0) as needed
                child: IconButton(
                  iconSize: 24.0,
                  icon: Image.asset('assets/images/shutter_button.png'),
                  onPressed: () {
                    _takePictureAndSave(context, taskId, db);
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        height: screenHeight * 0.04, // Adjust the height as needed
        color: const Color(0xFF5F54A6),
      ),
    ]));
  }

  Future<void> _takePictureAndSave(
      BuildContext context, int taskId, SnapgoalsDB db) async {
    try {
      XFile? image = await _controller.takePicture();
      Uint8List imageBytes = await image.readAsBytes();

      db.update(id: taskId, picture: imageBytes);

      // Get the project's directory
      final Directory appDirectory = await getApplicationDocumentsDirectory();
      final String appPath = appDirectory.path;

      // Move the image to the project's directory
      final File newImage = File(image.path);
      final String newImagePath =
          '$appPath/image_${DateTime.now().millisecondsSinceEpoch}.png';
      await newImage.copy(newImagePath);
      final ImageLabeler imageLabeler = GoogleMlKit.vision.imageLabeler();

      final InputImage inputImage = InputImage.fromFilePath(newImagePath);
      final List<ImageLabel> labels =
          await imageLabeler.processImage(inputImage);
      for (ImageLabel label in labels) {
        final String text = label.label;
        final int index = label.index;
        final double confidence = label.confidence;
        print(text);
        print(confidence);
        // Use the results...
      }
      imageLabeler.close();
      // You can now use newImagePath as the path to the saved image
      print('Image saved at: $newImagePath');
    } catch (e) {
      print('Error taking picture: $e');
    }
  }
}
