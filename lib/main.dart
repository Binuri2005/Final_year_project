import 'package:app/screens/forgot_passwod.dart';
import 'package:app/screens/home_page.dart';
import 'package:app/screens/login_page.dart';
import 'package:app/screens/signup_screen.dart';
import 'package:app/viewmodels/auth/auth_viewmodel..dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/intro_page.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AuthViewModel()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const IntroPage(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/signup': (context) => SignUpScreen(),
        '/forgot-password': (context) => const ForgotPasswordPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
