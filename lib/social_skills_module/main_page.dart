import 'package:app/social_skills_module/role_play.dart';
import 'package:flutter/material.dart';
import 'play_game.dart'; // Import the PlayGamePage

class SocialskillsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/light_background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Back Button to Home Page
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Welcome Message
            Text(
              'Welcome to Social Skills',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'Improve your social skills with roleplay & fun drag-and-drop games to match emotions',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Color.fromARGB(255, 222, 52, 108),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 60),

            // First Box (Role Play)
            _buildBox('ROLE PLAY', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RolePlayPage()),
              );
            }),
            SizedBox(height: 30),

            // Second Box (Play Game)
            _buildBox('PLAY GAME', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PlayGamePage()),
              );
            }),
            SizedBox(height: 35),
          ],
        ),
      ),
    );
  }

  // Widget for Box Design
  Widget _buildBox(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap, // Call the onTap function when the box is tapped
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Blue Outline Shadow
          Container(
            height: 110,
            width: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 9, 83, 144).withOpacity(0.7),
                  spreadRadius: 4,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
          ),
          // Whitish Opaque Box
          Container(
            height: 110,
            width: 250,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.black, width: 1),
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Navy Blue
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
