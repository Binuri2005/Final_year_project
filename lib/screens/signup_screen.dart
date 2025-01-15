import 'package:flutter/material.dart';
import 'login_page.dart';
import 'package:animate_do/animate_do.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/images/signup_background.png'), // Background image
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),

          // Animated cloud images
          child: Stack(
            children: [
              // Cloud 1 (top-left, appearing from the left)
              Positioned(
                left: -70, // Start off-screen
                top: 50, // Distance from the top
                width: 130,
                height: 130,
                child: FadeInLeft(
                  duration: Duration(seconds: 3),
                  child: Image.asset('assets/images/cloud.png'),
                ),
              ),

              // Cloud 2 (top-right, appearing from the right to the left)
              Positioned(
                right: -50, // Slightly further right than Cloud 1
                top: 10, // Lower down than Cloud 1
                width: 150,
                height: 150,
                child: FadeInLeft(
                  duration: Duration(seconds: 3),
                  child: Image.asset('assets/images/cloud.png'),
                ),
              ),

              // Back button (Arrow)
              Positioned(
                top: 30, // Position it at the top-left of the screen
                left: 10, // Adjust the left margin
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    // Navigate to the login page
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                ),
              ),

              // Rest of the screen content
              Center(
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.start, // Align to the start
                  children: [
                    // Add space above the white box
                    SizedBox(height: 120), // Move everything down more
                    // Sign Up heading outside the white box
                    Text(
                      'Sign Up',
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(height: 40), // Space between heading and box
                    Container(
                      padding: EdgeInsets.all(20),
                      width: 350,
                      decoration: BoxDecoration(
                        color: Colors.white
                            .withOpacity(0.5), // Transparent white box
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Name Field with box-like appearance
                          TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              labelText: 'Name',
                              hintText:
                                  'Enter your full name', // Placeholder text
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 10),

                          // Email Field with box-like appearance
                          TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              hintText: 'example@gmail.com', // Placeholder text
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 10),

                          // Password Field with box-like appearance
                          TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              hintText:
                                  'Enter your password', // Placeholder text
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 10),

                          // Confirm Password Field with box-like appearance
                          TextField(
                            controller: confirmPasswordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              hintText:
                                  'Re-enter your password', // Placeholder text
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 20),

                          // Sign Up Button with validation
                          ElevatedButton(
                            onPressed: () {
                              if (passwordController.text !=
                                  confirmPasswordController.text) {
                                // Display error if passwords don't match
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('Passwords do not match')));
                              } else {
                                // Proceed with sign-up logic (e.g., API call)
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(
                                  255, 51, 155, 55), // Button color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 50),
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontSize:
                                      20, // Bigger font size for login text
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),

                          // Navigation to Login screen
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Already have an account?'),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()),
                                  );
                                },
                                child: Text(
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
    );
  }
}
