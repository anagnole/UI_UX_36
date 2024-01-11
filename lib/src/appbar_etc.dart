import 'package:flutter/material.dart';
import 'package:snapgoals_v2/src/modal/modal.dart';
import 'package:snapgoals_v2/src/widgets/modal_animation.dart';

const primaryColor = Color(0xFF33228E);

class SnapGoalsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SnapGoalsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate spacing as a percentage of screen width
    const titleSpacingPercentage = 0.1;
    const iconPaddingPercentage = 0.05;

    return AppBar(
      backgroundColor: primaryColor, // Replace with your specific color
      title: const Text(
        "SnapGoals",
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Lobster', // Text color
          shadows: [
            Shadow(
              color: Colors.black, // Shadow color
              offset:
                  Offset(0, 4), // Offset of the shadow (horizontal, vertical)
              blurRadius: 4, // Blur radius
            ),
          ],
        ),
      ),
      titleSpacing: screenWidth * titleSpacingPercentage,

      actions: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * iconPaddingPercentage),
          child: IconButton(
            onPressed: () {
              // Navigate to the SecondPage when IconButton is pressed
              Navigator.of(context)
                  .push(modalAnimation(const Modal(pageName: 'profile')));
            },
            icon: Image.asset("assets/images/avatar icon.png"),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
