import 'package:flutter/material.dart';

class SocialSkillsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Social Skills'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        color: Color(0xFFF8EE6C), // Set background color
        child: Center(
          child: Text(
            'Social Skills Page',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
