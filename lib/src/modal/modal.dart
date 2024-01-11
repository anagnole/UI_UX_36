import 'package:flutter/material.dart';
import 'package:snapgoals_v2/src/appbar_withx.dart';
import 'package:snapgoals_v2/src/navigation/routes/profile/profile.dart';

class Modal extends StatefulWidget {
  final String pageName;
  const Modal({
    super.key,
    required this.pageName,
  });
  @override
  State<Modal> createState() => _ModalState();
}

class _ModalState extends State<Modal> {
  int currentIndex = 0;

  String pageName = '';
  Widget page = const ProfilePage();

  @override
  void initState() {
    super.initState();
    pageName = widget.pageName;
  }

  @override
  Widget build(BuildContext context) {
    switch (pageName) {
      case 'profile':
        page = const ProfilePage();

        break;
      default:
        throw UnimplementedError('no widget for $pageName');
    }
    return Scaffold(
      appBar: const SnapGoalsAppBar2(),
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: page,
      ),
    );
  }
}
