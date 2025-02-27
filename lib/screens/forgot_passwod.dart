import 'package:app/screens/login_page.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
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
              SizedBox(height: 20),
              Row(
                children: [
                  // Back Arrow
                  Positioned(
                    top: 30,
                    left: 10,
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

                  // Heading sentences
                  Expanded(
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
                          borderRadius: BorderRadius.only(
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
                              SizedBox(height: 25),
                              Text(
                                "Don’t worry, it happens to the best of us!",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "Enter your email to reset your password!",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 24),
                              TextField(
                                decoration: InputDecoration(
                                  labelText: "Email Address",
                                  hintText: "Enter your email",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  prefixIcon: Icon(Icons.email),
                                ),
                              ),
                              SizedBox(height: 26), // Space before button
                              ElevatedButton(
                                onPressed: () {
                                  //send button
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor:
                                      Color.fromARGB(255, 29, 112, 180),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 40,
                                    vertical: 15,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
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
