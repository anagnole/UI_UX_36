import 'package:flutter/material.dart';
import 'package:snapgoals_v2/src/appbar_etc.dart';
import 'package:snapgoals_v2/src/navigation/routes/gallery/gallery.dart';
import 'package:snapgoals_v2/src/navigation/routes/goals/goals.dart';
import 'package:snapgoals_v2/src/navigation/routes/home/home.dart';
import 'package:snapgoals_v2/src/navigation/routes/profile/profile.dart';

class MyNavigator extends StatefulWidget {
  const MyNavigator({super.key});

  @override
  State<MyNavigator> createState() => _MyNavigatorState();
}

class _MyNavigatorState extends State<MyNavigator> {
  int currentPageIndex = 1;
  List<String> icons = [
    'assets/images/Gallery icon.png',
    'assets/images/home icon.png',
    'assets/images/Goals icon.png'
  ];
  List<String> selectedIcons = [
    'assets/images/Gallery icon selected.png',
    'assets/images/selected home icon.png',
    'assets/images/selected goal icon.png'
  ];
  List<int> pickedIcons = [0, 1, 2];

  List<T> rotateRight<T>(List<T> list) {
    if (list.isEmpty) return list;
    var last = list.removeLast();
    list.insert(0, last);
    return list;
  }

  List<T> rotateLeft<T>(List<T> list) {
    if (list.isEmpty) return list;
    var first = list.removeAt(0);
    list.add(first);
    return list;
  }

  void stateHandler(int newIndex, bool left) {
    List<int> list = pickedIcons;
    list = left ? rotateLeft(list) : rotateRight(list);
    setState(() {
      pickedIcons = list;
      currentPageIndex = newIndex;
    });
  }

  void onDestinationSelected(int index, int current) {
    switch (current) {
      case 0:
        switch (index) {
          case 0:
            stateHandler(2, false);
            break;
          case 2:
            stateHandler(1, true);
            break;
        }
        break;
      case 1:
        switch (index) {
          case 0:
            stateHandler(0, false);
            break;
          case 2:
            stateHandler(2, true);
            break;
        }
        break;
      case 2:
        switch (index) {
          case 0:
            stateHandler(1, false);
            break;
          case 2:
            stateHandler(0, true);
            break;
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget page = const HomePage();
    switch (currentPageIndex) {
      case 0:
        page = const HomePage();
        break;
      case 1:
        page = const GalleryPage();
        break;
      case 2:
        page = const GoalsPage();
        break;
      case 3:
        page = const ProfilePage();
        break;
      default:
        throw UnimplementedError('no widget for $currentPageIndex');
    }

    //final ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const SnapGoalsAppBar(),
      bottomNavigationBar: Transform.translate(
        offset: const Offset(0, 15),
        child: NavigationBar(
          height: 90,
          indicatorColor: Colors.transparent,
          backgroundColor: primaryColor,
          onDestinationSelected: (index) =>
              onDestinationSelected(index, currentPageIndex),
          selectedIndex: currentPageIndex,
          destinations: <Widget>[
            NavigationDestination(
              icon: Image.asset(icons[pickedIcons[0]]),
              label: '',
            ),
            NavigationDestination(
              icon: Transform.translate(
                  offset: const Offset(0, -20),
                  child: SizedBox.square(
                    dimension: 90,
                    child: Image.asset(
                      selectedIcons[pickedIcons[1]],
                      fit: BoxFit.none,
                      scale: 0.9,
                    ),
                  )),
              label: '',
            ),
            NavigationDestination(
              icon: Image.asset(icons[pickedIcons[2]]),
              label: '',
            ),
          ],
        ),
      ),
      body: Container(
        child: page,
      ),
    );
  }
}
