// import 'package:flutter/material.dart';
// import 'package:snapgoals_v2/src/appbar_etc.dart';
// import 'navigation/routes/gallery/gallery.dart';

// class MyNavigator extends StatefulWidget {
//   const MyNavigator({super.key});

//   @override
//   State<MyNavigator> createState() => _MyNavigatorState();
// }

// class _MyNavigatorState extends State<MyNavigator> {
//   int currentPageIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     final ThemeData theme = Theme.of(context);
//     return Scaffold(
//       appBar: SnapGoalsAppBar(),
//       bottomNavigationBar: NavigationBar(
//         height: 75,
//         indicatorColor: Colors.transparent,
//         backgroundColor: primaryColor,
//         onDestinationSelected: (int index) {
//           setState(() {
//             currentPageIndex = index;
//           });
//         },
//         selectedIndex: currentPageIndex,
//         destinations: <Widget>[
//           NavigationDestination(
//             selectedIcon: SizedBox(
//                 width: 50,
//                 height: 50,
//                 child: Image.asset('assets/images/Gallery icon selected.png')),
//             icon: Image.asset('assets/images/Gallery icon.png'),
//             label: 'Gallery',
//           ),
//           NavigationDestination(
//             selectedIcon: SizedBox(
//                 width: 50,
//                 height: 50,
//                 child: Image.asset('assets/images/selected home icon.png')),
//             icon: Image.asset('assets/images/home icon.png'),
//             label: 'Home',
//           ),
//           NavigationDestination(
//             selectedIcon: SizedBox(
//                 width: 50,
//                 height: 50,
//                 child: Image.asset('assets/images/selected goal icon.png')),
//             icon: Image.asset('assets/images/Goals icon.png'),
//             label: 'Goals',
//           ),
//         ],
//       ),
//       body: <Widget>[
//         /// Home page
//         GalleryPage(),

//         /// Notifications page
//         const Padding(
//           padding: EdgeInsets.all(8.0),
//           child: Column(
//             children: <Widget>[
//               Card(
//                 child: ListTile(
//                   leading: Icon(Icons.notifications_sharp),
//                   title: Text('Notification 1'),
//                   subtitle: Text('This is a notification'),
//                 ),
//               ),
//               Card(
//                 child: ListTile(
//                   leading: Icon(Icons.notifications_sharp),
//                   title: Text('Notification 2'),
//                   subtitle: Text('This is a notification'),
//                 ),
//               ),
//             ],
//           ),
//         ),

//         /// Messages page
//         ListView.builder(
//           reverse: true,
//           itemCount: 2,
//           itemBuilder: (BuildContext context, int index) {
//             if (index == 0) {
//               return Align(
//                 alignment: Alignment.centerRight,
//                 child: Container(
//                   margin: const EdgeInsets.all(8.0),
//                   padding: const EdgeInsets.all(8.0),
//                   decoration: BoxDecoration(
//                     color: theme.colorScheme.primary,
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                   child: Text(
//                     'Hello',
//                     style: theme.textTheme.bodyLarge!
//                         .copyWith(color: theme.colorScheme.onPrimary),
//                   ),
//                 ),
//               );
//             }
//             return Align(
//               alignment: Alignment.centerLeft,
//               child: Container(
//                 margin: const EdgeInsets.all(8.0),
//                 padding: const EdgeInsets.all(8.0),
//                 decoration: BoxDecoration(
//                   color: theme.colorScheme.primary,
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 child: Text(
//                   'Hi!',
//                   style: theme.textTheme.bodyLarge!
//                       .copyWith(color: theme.colorScheme.onPrimary),
//                 ),
//               ),
//             );
//           },
//         ),
//       ][currentPageIndex],
//     );
//   }
// }
