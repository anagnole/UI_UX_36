import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:snapgoals_v2/src/appbar_etc.dart';
import 'package:snapgoals_v2/src/navigation/routes/gallery/gallery.dart';
import 'package:snapgoals_v2/src/navigation/routes/goals/goals.dart';
import 'package:snapgoals_v2/src/navigation/routes/home/home.dart';
import 'package:snapgoals_v2/src/navigation/routes/profile/profile.dart';

class MyNavigator extends StatefulWidget {
  final int index;
  const MyNavigator({super.key, required this.index});

  @override
  State<MyNavigator> createState() => _MyNavigatorState();
}

class _MyNavigatorState extends State<MyNavigator> {
  int currentPageIndex = 1;

  List<String> icons = [
    'assets/images/gallery.svg',
    'assets/images/home.svg',
    'assets/images/goals.svg'
  ];
  List<String> selectedIcons = [
    'assets/images/gallerySelected.svg',
    'assets/images/homeSelected.svg',
    'assets/images/goalsSelected.svg'
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
  void initState() {
    super.initState();
    currentPageIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    Widget page = const HomePage();
    switch (currentPageIndex) {
      case 0:
        page = const GalleryPage();
        break;
      case 1:
        page = const HomePage();
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

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const SnapGoalsAppBar(),
      body: Stack(alignment: Alignment.bottomCenter, children: [
        GestureDetector(
          onHorizontalDragEnd: (DragEndDetails details) {
            if (details.primaryVelocity! > 0) {
              switch (currentPageIndex) {
                case 0:
                  stateHandler(2, false);

                  break;
                case 1:
                  stateHandler(0, false);

                  break;
                case 2:
                  stateHandler(1, false);

                  break;
              }
            } else if (details.primaryVelocity! < 0) {
              // Swiping left
              switch (currentPageIndex) {
                case 0:
                  stateHandler(1, true);
                  break;
                case 1:
                  stateHandler(2, true);

                  break;
                case 2:
                  stateHandler(0, true);

                  break;
              }
            }
          },
          child: page,
        ),
        NavigationBar(
          height: 70,
          indicatorColor: Colors.transparent,
          backgroundColor: primaryColor,
          onDestinationSelected: (index) =>
              onDestinationSelected(index, currentPageIndex),
          selectedIndex: currentPageIndex,
          destinations: <Widget>[
            NavigationDestination(
              icon: Transform.translate(
                  offset: const Offset(0, 7),
                  child: SvgPicture.asset(icons[pickedIcons[0]])),
              label: '',
            ),
            const NavigationDestination(
              icon: Opacity(opacity: 0.0), // Invisible placeholder
              label: '',
            ),
            NavigationDestination(
              icon: Transform.translate(
                  offset: const Offset(0, 7),
                  child: SvgPicture.asset(icons[pickedIcons[2]])),
              label: '',
            ),
          ],
        ),
        Container(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 13),
            child: SvgPicture.asset(
              selectedIcons[pickedIcons[1]],
              height: 85,
            ),
          ),
        ),
      ]),
    );
  }
}
