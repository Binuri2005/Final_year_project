import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      // Wrap the content inside SingleChildScrollView
      child: Container(
        color: Color(0xFFECECEC),
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align texts to the left
          children: [
            // "Hello Binu!" heading at the top left
            Text(
              'Hello Binu!',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 3), // Add some space between the headings
            // "Welcome to CareBloom!" description below the heading
            Text(
              'Welcome to CareBloom! Choose a category to start learning and have fun improving your skills.',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20), // Approx. 3cm space between the messages

            // "Category" heading centered below the welcome text
            Center(
              child: Text(
                'Category',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 8), // Space between Category and the boxes

            // First box for "Speech Skills" with a black border

            Center(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.all(20),
                height: 150,
                width: 300,
                decoration: BoxDecoration(
                  color: Color(0xFFFCC0C5), // Speech Skills box color
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.black, // Black border color
                    width: 1, // Thin border width
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Speech Skills',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),

            // Second box for "Social Skills"
            Center(
              child: Container(
                margin:
                    EdgeInsets.symmetric(vertical: 10), // Space between boxes
                padding: EdgeInsets.all(20),
                height: 150,
                width: 300,
                decoration: BoxDecoration(
                  color: Color(0xFFF8EE6C),
                  borderRadius: BorderRadius.circular(15), // Rounded corners
                  border: Border.all(
                    color: Colors.black, // Black border color
                    width: 1, // Thin border width
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Social Skills',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),

            // Third box for "Daily Life Skills"
            Center(
              child: Container(
                margin:
                    EdgeInsets.symmetric(vertical: 10), // Space between boxes
                padding: EdgeInsets.all(20),
                height: 150,
                width: 300,
                decoration: BoxDecoration(
                  color: Color(0xFFF6C6FA),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.black, // Black border color
                    width: 1, // Thin border width
                  ), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Daily Life Skills',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
