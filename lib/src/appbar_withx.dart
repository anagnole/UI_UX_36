import 'package:flutter/material.dart';

const primaryColor = Color(0xFF33228E);

class SnapGoalsAppBar2 extends StatelessWidget implements PreferredSizeWidget {
  const SnapGoalsAppBar2({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate spacing as a percentage of screen width
    const titleSpacingPercentage = 0.1;
    const iconPaddingPercentage = 0.05;

    return AppBar(
      automaticallyImplyLeading: false,
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
              Navigator.of(context).pop();

              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => HomePage()),
              // );
            },
            icon: Image.asset("assets/images/close_24px.png"),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
