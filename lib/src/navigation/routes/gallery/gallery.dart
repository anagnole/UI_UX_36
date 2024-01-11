import 'package:flutter/material.dart';
import 'package:snapgoals_v2/src/navigation/routes/camera/camera.dart';
import 'package:camera/camera.dart';
import 'package:snapgoals_v2/src/navigation/routes/gallery/widgets/picture.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});
  @override
  build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ElevatedButton(
        onPressed: () async {
          // Navigate to the SecondScreen when the button is pressed
          WidgetsFlutterBinding.ensureInitialized();
          List<CameraDescription> cameras = await availableCameras();
          if (cameras.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CameraScreen(cameras: cameras)),
            );
          }
        },
        child: Text('Go to camera'),
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

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: TaskScreen(),
//     );
//   }
// }

// class TaskScreen extends StatefulWidget {
//   @override
//   _TaskScreenState createState() => _TaskScreenState();
// }

// class _TaskScreenState extends State<TaskScreen> {
//   late taskProvider provider;
//   late Future<List<task>> _tasksFuture;

//   @override
//   void initState() {
//     super.initState();
//     provider = taskProvider();
//     _tasksFuture = fetchTasks();
//   }

//   Future<List<task>> fetchTasks() async {
//     await provider.open('your_database_path.db');
//     // Fetch tasks from the database
//     List<Map<String, Object?>> tasksMapList = await provider.db.query('tasks');

//     // Convert maps to task objects
//     List<task> tasks = tasksMapList.map((taskMap) => task.fromMap(taskMap)).toList();

//     return tasks;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Task Details'),
//       ),
//       body: FutureBuilder<List<task>>(
//         future: _tasksFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No tasks available'));
//           } else {
//             return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) {
//                 task currentTask = snapshot.data![index];
//                 return Card(
//                   margin: EdgeInsets.all(8.0),
//                   child: ListTile(
//                     title: Text(currentTask.description),
//                     subtitle: Text('Category: ${currentTask.category}\n'
//                         'Completed: ${currentTask.completed ? 'Yes' : 'No'}'),
//                     // You can display more task details here
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }