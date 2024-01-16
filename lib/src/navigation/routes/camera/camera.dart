import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:snapgoals_v2/service/database/snapgoals_db.dart';
import 'package:snapgoals_v2/service/models/key_word.dart';
import 'package:snapgoals_v2/src/app_state.dart';
import 'package:snapgoals_v2/src/appbar_etc.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:snapgoals_v2/src/navigation/routes/camera/Failure_Popup.dart';
import 'package:snapgoals_v2/src/navigation/routes/camera/success_Popup.dart';

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
  bool loading = false;

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
                  if (snapshot.connectionState == ConnectionState.done &&
                      loading == false) {
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
                  onPressed: () async {
                    setState(() {
                      loading = true;
                    });
                    await _takePictureAndSave(context, taskId, db);
                    setState(() {
                      loading = false;
                    });
                    appState.notify();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ]));
  }

  Future<void> _takePictureAndSave(
      BuildContext context, int taskId, SnapgoalsDB db) async {
    try {
      final ImageLabeler imageLabeler = GoogleMlKit.vision.imageLabeler();

      XFile? image = await _controller.takePicture();

      File imageFile = File(image.path);
      InputImage inputImage = InputImage.fromFile(imageFile);
      List<String> labelsText2 = [];

      final List<ImageLabel> labels =
          await imageLabeler.processImage(inputImage);
      for (ImageLabel label in labels) {
        labelsText2.add(label.label);
        final String text = label.label;
        print('wihdfwe');
        print(text);
        // final int index = label.index;
        // final double confidence = label.confidence;
      }

      Uint8List imageBytes = await image.readAsBytes();
      List<KeyWord> keyWords;
      keyWords = await db.fetchTaskKeyWords(taskId: taskId);
      List<String> keyWordsText = [];
      for (KeyWord key in keyWords) {
        keyWordsText.add(key.word);
      }
      for (String key in keyWordsText) {
        keyWordsText.add(key);
      }
      keyWords.map((e) => {});
      print(keyWords.length + 1);
      keyWordsText.map((e) => print(e));
      // Get the project's directory
      final Directory appDirectory = await getApplicationDocumentsDirectory();
      final String appPath = appDirectory.path;

      // Move the image to the project's directory
      final File newImage = File(image.path);
      final String newImagePath =
          '$appPath/image_${DateTime.now().millisecondsSinceEpoch}.png';
      await newImage.copy(newImagePath);

      // final ImageLabeler imageLabeler = GoogleMlKit.vision.imageLabeler();
      // //late InputImage inputImage;
      // final inputImage2 = InputImage.fromFilePath(newImagePath);
      // List<String> labelsText = [];
      // final List<ImageLabel> labels =
      //     await imageLabeler.processImage(inputImage2);
      // for (ImageLabel label in labels) {
      //   labelsText.add(label.label);
      //   final String text = label.label;
      //   print('wihdfwe');
      //   print(text);
      //   // final int index = label.index;
      //   // final double confidence = label.confidence;
      // }

      Set<String> keyWordsSet = Set.from(keyWordsText);
      Set<String> labelsSet = Set.from(labelsText2);

      Set<String> commonElements = keyWordsSet.intersection(labelsSet);

      if (commonElements.isNotEmpty) {
        db.update(id: taskId, picture: imageBytes);
        //await showSuccessPopup(context)
        //.then((value) => Navigator.of(context).pop());
        print('Common elements: $commonElements');
      } else {
        //showFailurePopup(context, db, taskId, imageBytes);
        //await showFailurePopup(context, db, taskId, imageBytes)
        // .then((value) => true ? {} : {});
        print('No common elements found.');
      }
      imageLabeler.close();
      print('Image saved at: $newImagePath');
    } catch (e) {
      print('Error taking picture: $e');
    }
  }
}
