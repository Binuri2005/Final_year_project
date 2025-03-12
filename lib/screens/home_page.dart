import 'package:app/dailylife_skills_module/main_landing_page.dart';
import 'package:app/screens/dashboard_screen.dart';
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

  final List<Widget> _pageOptions = [
    const Home(),
    const RewardsPage(),
    const ProfileView(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Slightly softer background
      extendBodyBehindAppBar: true, // Create a more immersive look
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.9),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(Icons.menu, color: Color(0xFF4A6FE5), size: 22),
          ),
          onPressed: () {
            // Open the drawer
            Scaffold.of(context).openDrawer();
          },
        ),
        actions: [
          IconButton(
            icon: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.9),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.notifications,
                      color: Color(0xFF4A6FE5), size: 22),
                ),
                // Notification badge
                Positioned(
                  top: 6,
                  right: 6,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () {
              // Handle notifications button tap with feedback
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('No new notifications'),
                  duration: Duration(seconds: 1),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF4A6FE5),
                const Color(0xFF6A8FF8).withOpacity(0.9),
              ],
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person,
                          color: Color(0xFF4A6FE5), size: 35),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Hello ${context.watch<UserViewModel>().user!.firstName}!',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Welcome back',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              // Menu items with enhanced styling
              _buildDrawerItem(Icons.home, 'Home', () {
                Navigator.pop(context);
                setState(() => _currentIndex = 0);
              }),
              _buildDrawerItem(Icons.star, 'Rewards', () {
                Navigator.pop(context);
                setState(() => _currentIndex = 1);
              }),
              _buildDrawerItem(Icons.person, 'Profile', () {
                Navigator.pop(context);
                setState(() => _currentIndex = 2);
              }),
              _buildDrawerItem(Icons.settings, 'Settings', () {
                Navigator.pop(context);
                setState(() => _currentIndex = 3);
              }),
              const Divider(color: Colors.white30),
              _buildDrawerItem(Icons.help_outline, 'Help & Support', () {
                Navigator.pop(context);
                // Show help dialog
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Help & Support'),
                    content: const Text(
                        'Need assistance? Contact us at support@skillsapp.com'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                );
              }),
              _buildDrawerItem(Icons.info_outline, 'About', () {
                Navigator.pop(context);
                // Show about dialog
                showAboutDialog(
                  context: context,
                  applicationName: 'Skills Development App',
                  applicationVersion: '1.0.0',
                  applicationIcon: const FlutterLogo(size: 40),
                );
              }),
            ],
          ),
        ),
      ),
      body: _pageOptions[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              spreadRadius: 0,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFF4A6FE5),
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.transparent,
          elevation: 0,
          items: [
            _buildNavItem(Icons.home_rounded, 'Home'),
            _buildNavItem(Icons.star_rounded, 'Rewards'),
            _buildNavItem(Icons.person_rounded, 'Profile'),
            _buildNavItem(Icons.settings_rounded, 'Settings'),
          ],
        ),
      ),
    );
  }

  // Helper method for drawer items
  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      onTap: onTap,
      tileColor: Colors.transparent,
      hoverColor: Colors.white.withOpacity(0.1),
    );
  }

  // Helper method for nav bar items
  BottomNavigationBarItem _buildNavItem(IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: SafeArea(
        child: Container(
          padding:
              const EdgeInsets.fromLTRB(20, 20, 20, 30), // Reduced top padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome message with enhanced styling
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF4A6FE5).withOpacity(0.8),
                      const Color(0xFF6A8FF8).withOpacity(0.7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF4A6FE5).withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello ${context.watch<UserViewModel>().user!.firstName}!',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            "Ready to continue your progress today?",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.emoji_events,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // New heading
              const Text(
                "Let's Start Improving a Skill",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                  letterSpacing: 0.5,
                ),
              ),

              const SizedBox(height: 10),

              // Subtitle
              const Text(
                "Choose a category to begin your learning journey",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF666666),
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 25),

              /////////// box one for SPEECH SKILLS MODULES ///////////////////
              _buildSkillBox(
                context: context,
                title: 'Speech Skills',
                description: 'Learn to speak clearly and confidently',
                color: const Color(0xFFFCC0C5),
                imagePath: 'assets/images/speech.png',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SpeechSkillLevelScreen(),
                    ),
                  );
                },
              ),

              ////////// SOCIAL SKILLS MODULE box //////////////////////
              _buildSkillBox(
                context: context,
                title: 'Social Skills',
                description: 'Interactive role plays and fun games',
                color: const Color.fromARGB(255, 111, 155, 215),
                imagePath: 'assets/images/social.png',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SocialskillsPage(),
                    ),
                  );
                },
              ),

              ////////////// box for daily life skills module /////////
              _buildSkillBox(
                context: context,
                title: 'Daily Life Skills',
                description: 'Master essential everyday routines',
                color: const Color(0xFFF6C6FA),
                imagePath: 'assets/images/speech.png', onTap: () {  },
                // Comment out the onTap function
                // onTap: () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => DailyLifeSkillsScreen(),
                //     ),
                //   );
                // },
              ),

              // Progress overview section
              const SizedBox(height: 30),
              const Text(
                "Your Progress",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 15),

              // Progress cards
              _buildProgressCard(
                title: "Weekly Activity",
                value: "4/7",
                percentage: 57,
                color: const Color(0xFF4A6FE5),
                icon: Icons.calendar_today_rounded,
              ),

              const SizedBox(height: 15),

              _buildProgressCard(
                title: "Current Streak",
                value: "3 days",
                percentage: 60,
                color: const Color(0xFFFFA000),
                icon: Icons.local_fire_department_rounded,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method for skill boxes without animations
  Widget _buildSkillBox({
    required BuildContext context,
    required String title,
    required String description,
    required Color color,
    required String imagePath,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 140,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.4),
                spreadRadius: 1,
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Decorative element
              Positioned(
                right: -30,
                top: -30,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    // Text content
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Heading
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Description
                          Text(
                            description,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.9),
                              height: 1.3,
                            ),
                          ),
                          const Spacer(),
                          // "Let's Go" button with hover effect
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Let's Go",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: color.withOpacity(0.8),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  size: 16,
                                  color: color.withOpacity(0.8),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Image container
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.contain,
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

  // Helper method for progress cards
  Widget _buildProgressCard({
    required String title,
    required String value,
    required double percentage,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF666666),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
            ],
          ),
          const Spacer(),
          SizedBox(
            width: 50,
            height: 50,
            child: Stack(
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    value: percentage / 100,
                    strokeWidth: 6,
                    backgroundColor: Colors.grey.withOpacity(0.2),
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                  ),
                ),
                Center(
                  child: Text(
                    "${percentage.toInt()}%",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
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



/*
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

*/