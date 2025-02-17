import 'package:animate_do/animate_do.dart';
import 'package:app/global/textfield.widet.dart';
import 'package:app/screens/home_page.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: SizedBox.expand(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/signup_background.png'), // Background image
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),

            // cloud Animation
            child: Stack(
              children: [
                // Cloud 1 appearing from the left
                Positioned(
                  left: -70, // Start off-screen
                  top: 50, // Distance from the top
                  width: 130,
                  height: 130,
                  child: FadeInLeft(
                    duration: const Duration(seconds: 3),
                    child: Image.asset('assets/images/cloud.png'),
                  ),
                ),

                // Cloud 2 appearing from the right to the left
                Positioned(
                  right: -50,
                  top: 10,
                  width: 150,
                  height: 150,
                  child: FadeInLeft(
                    duration: const Duration(seconds: 3),
                    child: Image.asset('assets/images/cloud.png'),
                  ),
                ),

                // Back arrow
                Positioned(
                  top: 30,
                  left: 10,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      // Navigate to the login page
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    },
                  ),
                ),

                // sign up content
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //space above the white box
                      const SizedBox(height: 120),

                      // Sign Up heading outside the white box
                      const Text(
                        'Sign Up',
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                          height: 40), // Space between heading and box
                      Container(
                        padding: const EdgeInsets.all(20),
                        width: 350,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Name Field
                            CareBloomField(
                              label: 'Full Name',
                              placeholder: 'Eg. John Doe',
                              controller: nameController,
                            ),
                            const SizedBox(height: 10),

                            // Email Field
                            CareBloomField(
                              label: 'Email',
                              placeholder: "Eg. johndoe@gmail.com",
                              controller: emailController,
                              type: CareBloomFieldTypes.email,
                            ),
                            const SizedBox(height: 10),

                            // Password Field
                            CareBloomField(
                              label: 'Password',
                              placeholder: 'Enter your password',
                              controller: passwordController,
                              type: CareBloomFieldTypes.password,
                            ),

                            const SizedBox(height: 10),

                            // Confirm Password Field

                            CareBloomField(
                              label: 'Confirm Password',
                              placeholder: 'Re-enter your password',
                              controller: confirmPasswordController,
                              type: CareBloomFieldTypes.password,
                            ),
                            const SizedBox(height: 20),

                            // Sign Up Button with validation
                            ElevatedButton(
                              onPressed: () {
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }
                                if (passwordController.text !=
                                    confirmPasswordController.text) {
                                  // Display error if passwords don't match
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('Passwords do not match')));
                                } else {
                                  // If passwords match, navigate to the HomePage
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const HomePage()),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 51, 155, 55),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 50),
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),

                            // Navigate to Login screen
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Already have an account?'),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage()),
                                    );
                                  },
                                  child: const Text(
                                    'Login',
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
          ),
        ),
      ),
    );
  }
}
