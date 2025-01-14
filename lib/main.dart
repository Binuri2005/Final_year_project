import 'package:app/screens/forgot_passwod.dart';
import 'package:app/screens/login_page.dart';
import 'package:app/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'screens/intro_page.dart'; // Ensure this import is correct

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove debug banner
      home: IntroPage(), // Set IntroPage as the first screen
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpScreen(),
        '/forgot-password': (context) => ForgotPasswordPage(),
      },
    );
  }
}