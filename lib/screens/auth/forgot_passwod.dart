import 'package:app/screens/auth/login_page.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

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

          // Main Content
          Column(
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  // Back Arrow
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

                  // Heading sentences
                  const Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Oh no! I forgot',
                          style: TextStyle(
                            fontSize: 28,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            text: 'my password',
                            style: TextStyle(
                              fontSize: 32,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // bottom layout
              Expanded(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    // White Box with curled Corners
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.35,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.55,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.6),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 40.0, left: 16.0, right: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 25),
                              const Text(
                                "Don’t worry, it happens to the best of us!",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const Text(
                                "Enter your email to reset your password!",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 24),
                              TextField(
                                decoration: InputDecoration(
                                  labelText: "Email Address",
                                  hintText: "Enter your email",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  prefixIcon: const Icon(Icons.email),
                                ),
                              ),
                              const SizedBox(height: 26), // Space before button
                              ElevatedButton(
                                onPressed: () {
                                  //send button
                                },
                                style: ElevatedButton.styleFrom(
                                  // primary: Color.fromARGB(255, 29, 112, 180),
                                  // onPrimary: Colors.white,
                                  // padding: EdgeInsets.symmetric(
                                  //   horizontal: 40,
                                  //   vertical: 15,
                                  // ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  "Send",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Mushroom Image
                    Positioned(
                      top: -100,
                      child: Image.asset(
                        'assets/images/mushroom.png',
                        height: 500,
                        width: 500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
