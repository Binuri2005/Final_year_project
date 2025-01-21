import 'package:app/screens/dashboard_screen.dart';
import 'package:app/screens/notifications.dart';
import 'package:app/screens/profile_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // To track the currently selected tab

  final List<Widget> _pages = [
    NotificationsPage(),  // Notifications page content
    ProfilePage(),  // Profile page content
    RewardsPage(),  // Favorites page content
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // Wrap the content inside SingleChildScrollView
        child: Container(
          color: Color(0xFFCADEEB),
          padding: EdgeInsets.only(left: 30, right: 30, top: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align texts to the left
            children: [
              // Removed AppBar, back button, and CareBloom heading
              // Keeping only the content below

              // "Hello Binu!" and image
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Hello Binu!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 10), // Space between text and image
                  Image.asset(
                    'assets/images/cartoon_cat.png', // Adjust the path to your image
                    height: 60, // Control the size of the image
                    width: 60, // Control the size of the image
                    fit: BoxFit.contain, // Ensures the image fits well
                  ),
                ],
              ),
              SizedBox(height: 2), // Space between the headings

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
                        fontSize: 25,
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
                  margin: EdgeInsets.symmetric(vertical: 10), // Space between boxes
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
                        fontSize: 25,
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
                  margin: EdgeInsets.symmetric(vertical: 10), // Space between boxes
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
                        fontSize: 25,
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
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;  // Update the selected tab
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
