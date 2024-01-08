import 'package:flutter/material.dart';
import 'package:snapgoals_v2/src/profile/profile.dart';


const primaryColor= Color(0xFF33228E);

class SnapGoalsAppBar extends StatelessWidget implements PreferredSizeWidget {
  

  const SnapGoalsAppBar();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
  
  // Calculate spacing as a percentage of screen width
    final titleSpacingPercentage = 0.1; 
    final iconPaddingPercentage = 0.05; 


    return AppBar(
      backgroundColor: primaryColor, // Replace with your specific color
      title: Text(
        "SnapGoals",
        style: TextStyle(
          color: Colors.white, 
          fontFamily: 'Lobster',// Text color
          shadows: [
            Shadow(
                color: Colors.black, // Shadow color
               offset: Offset(0, 4), // Offset of the shadow (horizontal, vertical)
               blurRadius: 4, // Blur radius
      ),
    ],
        ),
      ),
      titleSpacing: screenWidth * titleSpacingPercentage,
      
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * iconPaddingPercentage),
          child: IconButton(
            onPressed: (){
            // Navigate to the SecondPage when IconButton is pressed
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );}, 
            icon: Image.asset("assets/images/avatar icon.png"),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}