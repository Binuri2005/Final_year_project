import 'package:flutter/material.dart';
import 'login_page.dart'; // Import your login page here

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  void initState() {
    super.initState();

    // Navigate to LoginPage after the wait
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/background_1.png', 
            fit: BoxFit.cover,
          ),

          // logo
          Center(
            child: Image.asset(
              'assets/images/logo.png', // Logo image path
              width: 1500,
              height: 1500,
            ),
          ),

          // Loading Indicator
          Center(
            child: CircularProgressIndicator(), // Simple loading indicator
          ),
        ],
      ),
    );
  }
}
