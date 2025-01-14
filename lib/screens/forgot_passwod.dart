import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/images/background_1.png', // Replace with your background image path
            fit: BoxFit.cover,
          ),

          // Main Content
          Column(
            children: [
              // Move the text closer to the top
              SizedBox(height: 20), // Reduced space from the top
              Center(
                child: Column(
                  children: [
                    Text(
                      'Oh no! I forgot',
                      style: TextStyle(
                        fontSize: 32,
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

              // Adjust the bottom layout
              Expanded(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    // White Box with Rounded Corners
                    Positioned(
                      top: MediaQuery.of(context).size.height *
                          0.4, // Start from halfway down
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.75,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white
                              .withOpacity(0.6), // Less transparency
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                      ),
                    ),

                    // Larger Mushroom Image
                    Positioned(
                      top: 0, // Adjusted to move the mushroom image higher
                      child: Image.asset(
                        'assets/images/mushroom.png', // Replace with your mushroom image path
                        height: 450, // Adjusted mushroom size
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
