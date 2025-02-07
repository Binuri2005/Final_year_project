import 'package:flutter/material.dart';

class SocialskillsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/light_background.png"),
            fit: BoxFit.cover, // Adjust as needed
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // AppBar Replacement - Back Button with Home Page Text
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
                  SizedBox(width: 8),
                  Text(
                    'Home Page',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20), // Adjusted spacing after the AppBar

            // Welcome Text
            Text(
              'Welcome to Social Skills Module',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20), // Spacing after the welcome text

            // Adjust this SizedBox height to move the boxes up or down
            SizedBox(
                height:
                    30), // This controls the space between the welcome text and the boxes

            // First Big Empty Box with Text
            Container(
              height: 110,
              width: 250,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5), // Transparent White
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black, width: 1),
              ),
              child: Center(
                child: Text(
                  'Role Play',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40), // Spacing between the boxes

            // Second Big Empty Box with Text
            Container(
              height: 110,
              width: 250,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5), // Transparent White
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black, width: 1),
              ),
              child: Center(
                child: Text(
                  'Play Game',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20), // Optional spacing after the last box
          ],
        ),
      ),
    );
  }
}



