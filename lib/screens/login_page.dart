import 'package:animate_do/animate_do.dart';
import 'package:app/screens/forgot_passwod.dart';
import 'package:app/services/api/api_service.dart';
import 'package:app/viewmodels/auth/auth_viewmodel..dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'signup_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/login_background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          //lights animation
          Positioned(
            left: 30,
            width: 80,
            height: 200,
            child: FadeInUp(
              duration: const Duration(seconds: 2),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/light_1.png'),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 160,
            width: 60,
            height: 120,
            child: FadeInUp(
              duration: const Duration(milliseconds: 1500),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/light_2.png'),
                  ),
                ),
              ),
            ),
          ),

          // Login content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 150),

                // Login title outside the box
                Positioned(
                  top: 180, //  distance from the top
                  left: 20,
                  child: Text(
                    context.read<AuthViewModel>().myLoveForArya.toString(),
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // White box curled
                Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Email/Username field
                      const TextField(
                        decoration: InputDecoration(
                            labelText: 'Email/Username',
                            hintText: 'example@gmail.com', // Placeholder text
                            border: OutlineInputBorder(),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      const SizedBox(height: 15),
                      Slider(
                        value: context.read<AuthViewModel>().myLoveForArya,
                        onChanged: (value) {
                          context.read<AuthViewModel>().setMyLoveForArya(value);
                        },
                        min: 0,
                        max: 1,
                      ),
                      // Password field
                      const TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: 'Enter your password', // Placeholder text
                            border: OutlineInputBorder(),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      const SizedBox(height: 10),

                      // Remember Me checkbox
                      Row(
                        children: [
                          Checkbox(
                            value: false,
                            onChanged: (bool? value) {
                              // checkbox logic
                            },
                          ),
                          const Text(
                            'Remember Me',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),

                      // Login button
                      ElevatedButton(
                        onPressed: () async {
                          try {
                            // login logic here
                            var data = await ApiService.sendRequest(
                              url:
                                  'https://jsonplaceholder.typicode.com/postsssww',
                              method: HTTPMethod.GET,
                            );

                            print(data);
                          } on ApiError catch (e) {
                            if (e.type == ApiErrorType.FILE_TOO_LARGE) {
                              //   showSnackBar(context, 'File too large');
                            }
                            ;
                          }

                          // Navigate to HomePage after successful login
                          // Navigator.pushReplacement(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) =>
                          //           const HomePage()), // HomePage after login
                          // );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 22, 110, 211),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 50),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Forgot Password
                      TextButton(
                        onPressed: () {
                          // Go to Forgot Password screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ForgotPasswordPage(),
                            ),
                          );
                        },
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.purple),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Sign-up link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?"),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(color: Colors.purple),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
