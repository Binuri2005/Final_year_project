import 'package:app/social_skills_module/main_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // To track the currently selected tab in navigator bar

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( // make sure the content is scrollable
        child: Container(
          color: const Color(0xFFCADEEB),
          padding: const EdgeInsets.only(left: 30, right: 30, top: 5),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [

              // Welcome messsage 
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Hello Binu!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 10), 
                  Image.asset(
                    'assets/images/cartoon_cat.png',
                    height: 60, 
                    width: 60, 
                    fit: BoxFit.contain, 
                  ),
                ],
              ),
              const SizedBox(height: 2), // Space between the headings

              const Text(
                'Welcome to CareBloom! Choose a category to start learning and have fun improving your skills.',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20), 

              // Category heading 
              const Center(
                child: Text(
                  'Category',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 8), 

              /////////// box one for SPEECH SKILLS MODULES ///////////////////
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.all(20),
                  height: 150,
                  width: 300,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFCC0C5), 
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.black, 
                      width: 1, 
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Center(
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

              ////////// SOCIAL SKILLS MODULE box //////////////////////
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const SocialskillsPage(), // Navigate to SocialskillsPage
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10),
                    padding: const EdgeInsets.all(20),
                    height: 150,
                    width: 300,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8EE6C),
                      borderRadius:
                          BorderRadius.circular(15), 
                      border: Border.all(
                        color: Colors.black, 
                        width: 1, 
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Center(
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
              ),

              ////////////// box for daily life skills module /////////
              Center(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10), 
                  padding: const EdgeInsets.all(20),
                  height: 150,
                  width: 300,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6C6FA),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.black, 
                      width: 1, 
                    ), 
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Center(
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
        currentIndex: _currentIndex, // Highlights the selected tab
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update the selected tab
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Rewards',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

