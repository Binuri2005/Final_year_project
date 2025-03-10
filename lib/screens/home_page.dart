import 'package:app/dailylife_skills_module/main_landing_page.dart';
import 'package:app/screens/home/speech_skills/speech_skill_level_screen.dart';
import 'package:app/screens/profile/profile.view.dart';
import 'package:app/screens/rewards/rewards_page.dart';
import 'package:app/screens/settings/setting_page.dart';
import 'package:app/social_skills_module/main_page.dart';
import 'package:app/viewmodels/user/user.viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // To track the currently selected tab in navigator bar

  List<Widget> _pageOptions = [
    Home(),
    RewardsPage(),
    ProfileView(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Make AppBar transparent
        elevation: 0, // Remove shadow
        leading: IconButton(
          icon: const Icon(Icons.menu,
              color: Colors.black), // Three horizontal lines
          onPressed: () {
            // Open the drawer
            Scaffold.of(context).openDrawer();
          },
        ),
        actions: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[200], // Light grey circle
              ),
              child: const Icon(Icons.notifications,
                  color: Colors.black, size: 20),
            ),
            onPressed: () {
              // Handle notifications button tap
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                // Handle home tap
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Handle settings tap
                Navigator.pop(context); // Close the drawer
              },
            ),
          ],
        ),
      ),
      body: _pageOptions[_currentIndex],
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
            icon: Icon(Icons.star),
            label: 'Rewards',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // make sure the content is scrollable
      child: Container(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 5),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome message
              Text(
                'Hello ${context.watch<UserViewModel>().user!.firstName}!',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold, // First name in bold
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),

              // New heading: "Let's Start Improving a Skill"
              const Text(
                "Let's Start Improving a Skill",
                style: TextStyle(
                  fontSize: 24, // Big font size
                  fontWeight: FontWeight.bold, // Bold font
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),

              // Category heading (aligned to the left)
              const Text(
                'Category',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),

              /////////// box one for SPEECH SKILLS MODULES ///////////////////
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const SpeechSkillLevelScreen(), // Navigate to SpeechSkillLevelScreen
                    ),
                  );
                },
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.all(20),
                    height: 150, // Reduced height
                    width: 310, // Reduced width
                    decoration: BoxDecoration(
                      color: const Color(0xFFFCC0C5), // Box color
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
                    child: Stack(
                      children: [
                        // Text content
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Heading
                            const Text(
                              'Speech Skills',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 5),
                            // Description
                            const Text(
                              'Speak clearly',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                            const Spacer(),
                            // "Let's Go" button
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                              child: const Text(
                                "Let's Go",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Image on the right side
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: SizedBox(
                            width: 120, // Adjust the width of the image
                            height: 120, // Adjust the height of the image
                            child: Image.asset(
                              'assets/images/speech.png', // Path to your image
                              fit: BoxFit
                                  .contain, // Ensure the image fits inside the container
                            ),
                          ),
                        ),
                      ],
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
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.all(20),
                    height: 150, // Reduced height
                    width: 310, // Reduced width
                    decoration: BoxDecoration(
                      color:
                          const Color.fromARGB(255, 111, 155, 215), // Box color
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
                    child: Stack(
                      children: [
                        // Text content
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Heading
                            const Text(
                              'Social Skills',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 5),
                            // Description
                            const Text(
                              'Role plays and games',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                            const Spacer(),
                            // "Let's Go" button
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                              child: const Text(
                                "Let's Go",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Image on the right side
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: SizedBox(
                            width: 80, // Adjust the width of the image
                            height: 80, // Adjust the height of the image
                            child: Image.asset(
                              'assets/images/social.png',
                              fit: BoxFit
                                  .contain, // Ensure the image fits inside the container
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              ////////////// box for daily life skills module /////////
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DailyLifeSkillsScreen(),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.all(20),
                    height: 150, // Reduced height
                    width: 310, // Reduced width
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6C6FA), // Box color
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
                    child: Stack(
                      children: [
                        // Text content
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Heading
                            const Text(
                              'Daily Life Skills',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 5),
                            // Description
                            const Text(
                              'Routines',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                            const Spacer(),
                            // "Let's Go" button
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                              child: const Text(
                                "Let's Go",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Image on the right side
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: SizedBox(
                            width: 80, // Adjust the width of the image
                            height: 80, // Adjust the height of the image
                            child: Image.asset(
                              'assets/images/speech.png',
                              fit: BoxFit
                                  .contain, // Ensure the image fits inside the container
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*import 'package:app/dailylife_skills_module/main_landing_page.dart';
import 'package:app/screens/home/speech_skills/speech_skill_level_screen.dart';
import 'package:app/screens/profile/profile.view.dart';
import 'package:app/screens/rewards/rewards_page.dart';
import 'package:app/screens/settings/setting_page.dart';
import 'package:app/social_skills_module/main_page.dart';
import 'package:app/viewmodels/user/user.viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // To track the currently selected tab in navigator bar

  List<Widget> _pageOptions = [
    Home(),
    RewardsPage(),
    ProfileView(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: const Color(0x00FAFAFA),
        elevation: 0, // Remove shadow
        leading: IconButton(
          icon: const Icon(Icons.menu,
              color: Colors.black), // Three horizontal lines
          onPressed: () {
            // Open the drawer
            Scaffold.of(context).openDrawer();
          },
        ),
        actions: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[200], // Light grey circle
              ),
              child: const Icon(Icons.notifications,
                  color: Colors.black, size: 20),
            ),
            onPressed: () {
              // Handle notifications button tap
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                // Handle home tap
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Handle settings tap
                Navigator.pop(context); // Close the drawer
              },
            ),
          ],
        ),
      ),
      body: _pageOptions[_currentIndex],
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
            icon: Icon(Icons.star),
            label: 'Rewards',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // make sure the content is scrollable
      child: Container(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 5),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome message
              Text(
                'Hello ${context.watch<UserViewModel>().user!.firstName}!',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold, // First name in bold
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),

              // New heading: "Let's Start Improving a Skill"
              const Text(
                "Let's Start Improving a Skill",
                style: TextStyle(
                  fontSize: 24, // Big font size
                  fontWeight: FontWeight.bold, // Bold font
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),

              // Category heading (aligned to the left)
              const Text(
                'Category',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),

              /////////// box one for SPEECH SKILLS MODULES ///////////////////
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const SpeechSkillLevelScreen(), // Navigate to SocialskillsPage
                    ),
                  );
                },
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.all(20),
                    height: 150, // Reduced height
                    width: 310, // Reduced width
                    decoration: BoxDecoration(
                      color: const Color(0xFFFCC0C5), // Box color
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
                    child: Stack(
                      children: [
                        // Text content
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Heading
                            const Text(
                              'Speech Skills',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 5),
                            // Description
                            const Text(
                              'Speak clearly',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                            const Spacer(),
                            // "Let's Go" button
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                              child: const Text(
                                "Let's Go",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Image on the right side
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: SizedBox(
                            width: 120, // Adjust the width of the image
                            height: 120, // Adjust the height of the image
                            child: Image.asset(
                              'assets/images/speech.png', // Path to your image
                              fit: BoxFit
                                  .contain, // Ensure the image fits inside the container
                            ),
                          ),
                        ),
                      ],
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
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.all(20),
                    height: 150, // Reduced height
                    width: 310, // Reduced width
                    decoration: BoxDecoration(
                      color:
                          const Color.fromARGB(255, 111, 155, 215), // Box color
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
                    child: Stack(
                      children: [
                        // Text content
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Heading
                            const Text(
                              'Social Skills',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 5),
                            // Description
                            const Text(
                              'Role plays and games',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                            const Spacer(),
                            // "Let's Go" button
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                              child: const Text(
                                "Let's Go",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Image on the right side
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: SizedBox(
                            width: 80, // Adjust the width of the image
                            height: 80, // Adjust the height of the image
                            child: Image.asset(
                              'assets/images/social.png',
                              fit: BoxFit
                                  .contain, // Ensure the image fits inside the container
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              ////////////// box for daily life skills module /////////
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DailyLifeSkillsScreen(),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.all(20),
                    height: 150, // Reduced height
                    width: 310, // Reduced width
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6C6FA), // Box color
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
                    child: Stack(
                      children: [
                        // Text content
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Heading
                            const Text(
                              'Daily Life Skills',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 5),
                            // Description
                            const Text(
                              'Routines',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                            const Spacer(),
                            // "Let's Go" button
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                              child: const Text(
                                "Let's Go",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Image on the right side
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: SizedBox(
                            width: 80, // Adjust the width of the image
                            height: 80, // Adjust the height of the image
                            child: Image.asset(
                              'assets/images/speech.png',
                              fit: BoxFit
                                  .contain, // Ensure the image fits inside the container
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/
