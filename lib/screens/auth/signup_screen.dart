import 'package:animate_do/animate_do.dart';
import 'package:app/global/textfield.widet.dart';
import 'package:app/screens/intro_page.dart';
import 'package:app/viewmodels/auth/auth_viewmodel..dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_page.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  registerUser() async {
    if (_formKey.currentState!.validate()) {
      if (passwordController.text != confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Passwords do not match'),
          ),
        );
        return;
      }
      //  call the api to register the user
      bool isSuccess = await context.read<AuthViewModel>().registerUser(
          firstName: firstNameController.text,
          lastname: lastNameController.text,
          email: emailController.text,
          password: passwordController.text,
          confirmPassword: confirmPasswordController.text);

      if (isSuccess) {
        // Navigate to the login page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => IntroPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.read<AuthViewModel>().errorMessage!),
          ),
        );
      }
    }
  }

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
                            Row(
                              children: [
                                Flexible(
                                  child: CareBloomField(
                                    label: 'First Name',
                                    placeholder: 'Eg. John',
                                    controller: firstNameController,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Flexible(
                                  child: CareBloomField(
                                    label: 'Last Name',
                                    placeholder: 'Eg. Doe',
                                    controller: lastNameController,
                                  ),
                                ),
                              ],
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
                                registerUser();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 51, 155, 55),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 50),
                                child: context
                                        .watch<AuthViewModel>()
                                        .isRegisteringUser
                                    ? const CupertinoActivityIndicator(
                                        color: Colors.white,
                                      )
                                    : Text(
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
