import 'package:app/screens/forgot_passwod.dart';
import 'package:flutter/material.dart';
import 'signup_screen.dart'; // Import the sign-up screen

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/login_background.png'), // Background image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Login content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Add space above the login title
                SizedBox(height: 100), // Move everything down
                // Login title outside the box
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 50),
                // White box
                Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5), // More transparent
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Email/Username field with placeholder
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Email/Username',
                          hintText: 'example@gmail.com', // Placeholder text
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 15),
                      // Password field
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter your password', // Placeholder text
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      // Remember Me checkbox
                      Row(
                        children: [
                          Checkbox(
                            value: false,
                            onChanged: (bool? value) {
                              // Handle checkbox logic
                            },
                          ),
                          Text(
                            'Remember Me',
                            style: TextStyle(
                              fontWeight: FontWeight.bold, // Make bold
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),

                      // Login button
                      ElevatedButton(
                        onPressed: () {
                          // Handle login logic here
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(
                              255, 22, 110, 211), // Darker blue button color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 50),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 20, // Bigger font size for login text
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      // Forgot Password
                      TextButton(
                        onPressed: () {
                          // Navigate to Forgot Password screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgotPasswordPage(),
                            ),
                          );
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.purple),
                        ),
                      ),
                      SizedBox(height: 10),
                      // Sign-up link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?"),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpScreen()),
                              );
                            },
                            child: Text(
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
