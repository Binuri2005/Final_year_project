import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/images/background_1.png', // Replace with your background image path
            fit: BoxFit.cover, // Ensure the image covers the entire screen
          ),

          // Content will go here later
        ],
      ),
    );
  }
}
