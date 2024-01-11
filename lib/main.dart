import 'package:flutter/material.dart';
import 'src/app.dart';


void main() {
  runApp(const MainApp());
} 


// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   List<CameraDescription> cameras = await availableCameras();
//   runApp(MyApp(cameras: cameras));
// }

// class MyApp extends StatelessWidget {
//   final List<CameraDescription> cameras;

//   MyApp({required this.cameras});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Camera View Page',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: CameraViewPage(cameras: cameras),
//     );
//   }
// }

// class CameraViewPage extends StatefulWidget {
//   final List<CameraDescription> cameras;

//   CameraViewPage({required this.cameras});

//   @override
//   _CameraViewPageState createState() => _CameraViewPageState();
// }

// class _CameraViewPageState extends State<CameraViewPage> {
//   late CameraController _controller;
//   late Future<void> _initializeControllerFuture;

//   @override
//   void initState() {
//     super.initState();
//     // Initialize the camera controller
//     _controller = CameraController(
//       widget.cameras[0],
//       ResolutionPreset.medium,
//     );

//     // Next, initialize the controller. This returns a Future
//     _initializeControllerFuture = _controller.initialize();
//   }

//   @override
//   void dispose() {
//     // Dispose of the controller when the widget is disposed
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Camera View Page'),
//       ),
//       body: FutureBuilder<void>(
//         future: _initializeControllerFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             // If the Future is complete, display the preview
//             return CameraPreview(_controller);
//           } else {
//             // Otherwise, display a loading indicator
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     );
//   }
// }
