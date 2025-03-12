import 'package:app/extenstions/user.ext.dart';
import 'package:flutter/material.dart';

class RewardsPage extends StatefulWidget {
  const RewardsPage({Key? key}) : super(key: key);

  @override
  State<RewardsPage> createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage>
    with SingleTickerProviderStateMixin {
  // Animation controller for the progress indicators
  late AnimationController _controller;

  // Current progress values
  double speechSkillsProgress = 0.75;
  double socialSkillsProgress = 0.5;
  double dailyLifeSkillsProgress = 0.3;

  // User points and level
  int userPoints = 1250;
  int userLevel = 1;
  int streakDays = 5;

  // Selected reward
  Map<String, dynamic>? selectedReward;

  // Scroll controller to handle scrolling behavior
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..forward();

    // Calculate user level based on points
    _calculateUserLevel();
  }

  void _calculateUserLevel() {
    if (userPoints >= 5000) {
      userLevel = 5;
    } else if (userPoints >= 2500) {
      userLevel = 4;
    } else if (userPoints >= 1000) {
      userLevel = 3;
    } else if (userPoints >= 500) {
      userLevel = 2;
    } else {
      userLevel = 1;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Rewards'),
        centerTitle: true,
        backgroundColor: Colors.purple.shade800,
        elevation: 0,
        // Add back button since this is now a sub-page
        automaticallyImplyLeading: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade900,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 18),
                  const SizedBox(width: 4),
                  Text(
                    '$userPoints pts',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple.shade800, Colors.purple.shade100],
          ),
        ),
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 30.0),
            child: Column(
              children: [
                // User Level Card
                _buildUserLevelCard(),
                const SizedBox(height: 20),

                // Navigation buttons for sub-sections
                _buildRewardsNavigation(),
                const SizedBox(height: 20),

                // Progress Dashboard
                _buildProgressDashboard(),
                const SizedBox(height: 20),

                // Streak Section
                _buildStreakSection(),
                const SizedBox(height: 20),

                // Rewards Preview Section
                _buildRewardsPreviewSection(),
                const SizedBox(height: 20),

                // Challenges Preview
                _buildChallengesPreviewSection(),
              ],
            ),
          ),
        ),
      ),
      // Removed bottom navigation bar since this is a sub-page
    );
  }

  // New method to build navigation buttons for rewards sub-sections
  Widget _buildRewardsNavigation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildNavButton(
          'Badges',
          Icons.emoji_events,
          () => _navigateToBadgesCollection(),
        ),
        _buildNavButton(
          'Challenges',
          Icons.flag,
          () => _navigateToChallenges(),
        ),
        _buildNavButton(
          'Achievements',
          Icons.emoji_events_outlined,
          () => _navigateToAchievements(),
        ),
      ],
    );
  }

  // Helper method to build a navigation button
  Widget _buildNavButton(String label, IconData icon, VoidCallback onTap) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.purple.shade700,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget _buildUserLevelCard() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.only(top: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.purple.shade700,
                  child: Text(
                    '$userLevel',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Your Level',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        _getLevelTitle(userLevel),
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      LinearProgressIndicator(
                        value: _getLevelProgress(),
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation(Colors.purple),
                        minHeight: 8,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '$userPoints',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                            ),
                          ),
                          Text(
                            '${_getNextLevelPoints()}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Next reward at level ${userLevel + 1}: ${_getNextLevelReward()}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getLevelTitle(int level) {
    switch (level) {
      case 1:
        return 'Beginner';
      case 2:
        return 'Explorer';
      case 3:
        return 'Achiever';
      case 4:
        return 'Master';
      case 5:
        return 'Champion';
      default:
        return 'Beginner';
    }
  }

  double _getLevelProgress() {
    final int currentLevelMinPoints = _getCurrentLevelMinPoints();
    final int nextLevelPoints = _getNextLevelPoints();
    final int levelRange = nextLevelPoints - currentLevelMinPoints;

    if (levelRange <= 0) return 1.0; // Max level

    final int pointsInCurrentLevel = userPoints - currentLevelMinPoints;
    return pointsInCurrentLevel / levelRange;
  }

  int _getCurrentLevelMinPoints() {
    switch (userLevel) {
      case 1:
        return 0;
      case 2:
        return 500;
      case 3:
        return 1000;
      case 4:
        return 2500;
      case 5:
        return 5000;
      default:
        return 0;
    }
  }

  int _getNextLevelPoints() {
    switch (userLevel) {
      case 1:
        return 500;
      case 2:
        return 1000;
      case 3:
        return 2500;
      case 4:
        return 5000;
      case 5:
        return 10000; // Just for display purposes
      default:
        return 500;
    }
  }

  String _getNextLevelReward() {
    switch (userLevel) {
      case 1:
        return 'Silver Badge';
      case 2:
        return 'Gold Badge';
      case 3:
        return 'Special Theme Unlock';
      case 4:
        return 'Platinum Badge';
      case 5:
        return 'Master Achievement';
      default:
        return 'Bronze Badge';
    }
  }

  Widget _buildProgressDashboard() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Row(
              children: [
                Icon(Icons.insights, color: Colors.purple),
                SizedBox(width: 8),
                Text(
                  'Module Progress',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildAnimatedCircularProgress(
                  speechSkillsProgress,
                  'Speech Skills',
                  Colors.blue,
                  '${(speechSkillsProgress * 100).toInt()} / 100',
                  Icons.record_voice_over,
                ),
                _buildAnimatedCircularProgress(
                  socialSkillsProgress,
                  'Social Skills',
                  Colors.green,
                  '${(socialSkillsProgress * 100).toInt()} / 100',
                  Icons.people,
                ),
                _buildAnimatedCircularProgress(
                  dailyLifeSkillsProgress,
                  'Daily Life Skills',
                  Colors.orange,
                  '${(dailyLifeSkillsProgress * 100).toInt()} / 100',
                  Icons.home,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildModuleButton(
                  'Speech Practice',
                  Icons.record_voice_over,
                  Colors.blue,
                  () => _navigateToModulePage('speech'),
                ),
                _buildModuleButton(
                  'Social Skills',
                  Icons.people,
                  Colors.green,
                  () => _navigateToModulePage('social'),
                ),
                _buildModuleButton(
                  'Daily Life',
                  Icons.home,
                  Colors.orange,
                  () => _navigateToModulePage('dailylife'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModuleButton(
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 16),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToModulePage(String moduleType) {
    // We'll implement this navigation in the next parts
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Navigating to $moduleType module...'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  Widget _buildAnimatedCircularProgress(
    double value,
    String label,
    Color color,
    String centerText,
    IconData icon,
  ) {
    return GestureDetector(
      onTap: () {
        _showProgressDetails(label, value, color, icon);
      },
      child: Column(
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return CircularProgressIndicator(
                      value: _controller.value * value,
                      strokeWidth: 12,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation(color),
                    );
                  },
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, size: 20, color: color),
                    Text(
                      centerText,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showProgressDetails(
      String label, double value, Color color, IconData icon) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 8),
            Text(label),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LinearProgressIndicator(
              value: value,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation(color),
              minHeight: 10,
            ),
            const SizedBox(height: 16),
            Text('Current progress: ${(value * 100).toInt()}%'),
            const SizedBox(height: 8),
            Text('${(value * 100).toInt()} out of 100 points'),
            const SizedBox(height: 16),
            _buildSkillDetails(label),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _navigateToModulePage(label.split(' ')[0].toLowerCase());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
            ),
            child: const Text('See Details'),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillDetails(String skillType) {
    List<String> details = [];

    if (skillType == 'Speech Skills') {
      details = [
        'Pronunciation',
        'Vocabulary Usage',
        'Sentence Construction',
        'Communication Clarity'
      ];
    } else if (skillType == 'Social Skills') {
      details = [
        'Eye Contact',
        'Turn Taking',
        'Social Cues Recognition',
        'Emotional Expression'
      ];
    } else if (skillType == 'Daily Life Skills') {
      details = [
        'Self-Care Routines',
        'Time Management',
        'Organization Skills',
        'Task Completion'
      ];
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Skill Components:',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ...details
            .map((detail) => Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle,
                          size: 14, color: Colors.green),
                      const SizedBox(width: 4),
                      Text(detail),
                    ],
                  ),
                ))
            .toList(),
      ],
    );
  }

  Widget _buildStreakSection() {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Your Streaks',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.local_fire_department,
                          color: Colors.orange.shade700, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        'Keep it up!',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildStreakType(
              icon: Icons.bolt,
              title: 'Speech Streak',
              days: context.user!.streaks.speechStreak,
              color: Colors.amber.shade600,
              description: 'Practice speaking daily',
            ),
            const SizedBox(height: 20),
            _buildStreakType(
              icon: Icons.people_alt_rounded,
              title: 'Social Streak',
              days: context.user!.streaks.socialStreak,
              color: Colors.teal.shade500,
              description: 'Engage in conversations',
            ),
            const SizedBox(height: 20),
            _buildStreakType(
              icon: Icons.auto_awesome,
              title: 'Daily Life Streak',
              days: context.user!.streaks.dailyLifeStreak,
              color: Colors.indigo.shade500,
              description: 'Complete everyday tasks',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStreakType({
    required IconData icon,
    required String title,
    required int days,
    required Color color,
    required String description,
  }) {
    final double percentage = days / 100; // Adjust denominator as needed
    final bool isHighStreak = days > 60;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.1), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              if (isHighStreak)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.local_fire_department,
                          color: Colors.red.shade400, size: 12),
                      const SizedBox(width: 2),
                      Text(
                        'Hot',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.red.shade400,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Text(
                '$days days',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const Spacer(),
              Text(
                '${(percentage * 100).toInt()}%',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: color.withOpacity(0.8),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Stack(
              children: [
                Container(
                  height: 8,
                  width: double.infinity,
                  color: Colors.grey.shade200,
                ),
                FractionallySizedBox(
                  widthFactor: percentage.clamp(0.0, 1.0),
                  child: Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: color.withOpacity(0.5),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
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

  Widget _buildWeeklyStreak() {
    final dayNames = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(7, (index) {
        final bool isCompleted = index < streakDays % 7;
        final bool isToday = index == streakDays % 7;

        return Column(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isCompleted
                    ? Colors.orange
                    : isToday
                        ? Colors.orange.withOpacity(0.3)
                        : Colors.grey.withOpacity(0.2),
                shape: BoxShape.circle,
                border:
                    isToday ? Border.all(color: Colors.orange, width: 2) : null,
              ),
              child: Center(
                child: isCompleted
                    ? const Icon(Icons.check, color: Colors.white, size: 20)
                    : Text(
                        dayNames[index],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isToday ? Colors.orange : Colors.grey,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              dayNames[index],
              style: TextStyle(
                fontSize: 12,
                color: isCompleted || isToday ? Colors.orange : Colors.grey,
                fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildRewardsPreviewSection() {
    final List<Map<String, dynamic>> rewards = [
      {
        'name': 'Bronze Badge',
        'icon': Icons.emoji_events,
        'color': Colors.brown,
        'unlocked': true,
      },
      {
        'name': 'Silver Badge',
        'icon': Icons.emoji_events,
        'color': Colors.grey.shade400,
        'unlocked': true,
      },
      {
        'name': 'Gold Badge',
        'icon': Icons.emoji_events,
        'color': Colors.amber,
        'unlocked': false,
      },
      {
        'name': 'Platinum Badge',
        'icon': Icons.emoji_events,
        'color': Colors.blue.shade300,
        'unlocked': false,
      },
    ];

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.card_giftcard, color: Colors.purple),
                    SizedBox(width: 8),
                    Text(
                      'Recent Rewards',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to Badges collection
                    _navigateToBadgesCollection();
                  },
                  child: const Text('See All'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: rewards.take(4).map((reward) {
                final bool isUnlocked = reward['unlocked'] as bool;

                return Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color:
                            isUnlocked ? reward['color'] : Colors.grey.shade300,
                        shape: BoxShape.circle,
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: Icon(
                              reward['icon'] as IconData,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          if (!isUnlocked)
                            const Positioned(
                              top: 5,
                              right: 5,
                              child: Icon(
                                Icons.lock,
                                color: Colors.white,
                                size: 14,
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      reward['name'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: isUnlocked ? Colors.black : Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToBadgesCollection() {
    // Define all possible badges
    final List<Map<String, dynamic>> allBadges = [
      {
        'name': 'Bronze Badge',
        'icon': Icons.emoji_events,
        'color': Colors.brown,
        'unlocked': true,
        'description': 'Earned by reaching Level 1',
        'criteria': 'Earn 0+ points'
      },
      {
        'name': 'Silver Badge',
        'icon': Icons.emoji_events,
        'color': Colors.grey.shade400,
        'unlocked': userLevel >= 2,
        'description': 'Earned by reaching Level 2',
        'criteria': 'Earn 500+ points'
      },
      {
        'name': 'Gold Badge',
        'icon': Icons.emoji_events,
        'color': Colors.amber,
        'unlocked': userLevel >= 3,
        'description': 'Earned by reaching Level 3',
        'criteria': 'Earn 1000+ points'
      },
      {
        'name': 'Platinum Badge',
        'icon': Icons.emoji_events,
        'color': Colors.blue.shade300,
        'unlocked': userLevel >= 4,
        'description': 'Earned by reaching Level 4',
        'criteria': 'Earn 2500+ points'
      },
      {
        'name': 'Diamond Badge',
        'icon': Icons.diamond,
        'color': Colors.cyan,
        'unlocked': userLevel >= 5,
        'description': 'Earned by reaching Level 5',
        'criteria': 'Earn 5000+ points'
      },
      {
        'name': 'Perfect Streak',
        'icon': Icons.local_fire_department,
        'color': Colors.orange,
        'unlocked': streakDays >= 7,
        'description': 'Maintained a 7+ day streak',
        'criteria': 'Complete activities for 7 consecutive days'
      },
      {
        'name': 'Speech Master',
        'icon': Icons.record_voice_over,
        'color': Colors.blue,
        'unlocked': speechSkillsProgress >= 0.8,
        'description': 'Achieved high proficiency in Speech Skills',
        'criteria': 'Reach 80% in Speech Skills'
      },
      {
        'name': 'Social Butterfly',
        'icon': Icons.people,
        'color': Colors.green,
        'unlocked': socialSkillsProgress >= 0.8,
        'description': 'Achieved high proficiency in Social Skills',
        'criteria': 'Reach 80% in Social Skills'
      }
    ];

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('My Badges'),
            backgroundColor: Colors.purple.shade800,
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.purple.shade200, Colors.white],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Badge Collection',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'You have unlocked ${allBadges.where((badge) => badge['unlocked'] as bool).length} out of ${allBadges.length} badges',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: allBadges.length,
                      itemBuilder: (context, index) {
                        final badge = allBadges[index];
                        final bool isUnlocked = badge['unlocked'] as bool;

                        return Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: InkWell(
                            onTap: () {
                              _showBadgeDetails(badge);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      color: isUnlocked
                                          ? badge['color'] as Color
                                          : Colors.grey.shade300,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Stack(
                                      children: [
                                        Center(
                                          child: Icon(
                                            badge['icon'] as IconData,
                                            color: Colors.white,
                                            size: 40,
                                          ),
                                        ),
                                        if (!isUnlocked)
                                          const Positioned(
                                            top: 10,
                                            right: 10,
                                            child: Icon(
                                              Icons.lock,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    badge['name'] as String,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: isUnlocked
                                          ? Colors.black
                                          : Colors.grey,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    isUnlocked ? 'Unlocked' : 'Locked',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isUnlocked
                                          ? Colors.green
                                          : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showBadgeDetails(Map<String, dynamic> badge) {
    final bool isUnlocked = badge['unlocked'] as bool;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              badge['icon'] as IconData,
              color: isUnlocked ? badge['color'] as Color : Colors.grey,
            ),
            const SizedBox(width: 8),
            Text(badge['name'] as String),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              badge['description'] as String,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'How to earn:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(badge['criteria'] as String),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isUnlocked
                    ? Colors.green.withOpacity(0.1)
                    : Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    isUnlocked ? Icons.check_circle : Icons.lock,
                    color: isUnlocked ? Colors.green : Colors.grey,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isUnlocked
                        ? 'Badge Unlocked'
                        : 'Badge Locked - Keep working to earn it!',
                    style: TextStyle(
                      color: isUnlocked ? Colors.green : Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildChallengesPreviewSection() {
    final challenges = [
      {
        'title': 'Speech Practice',
        'description': 'Complete 10 minutes of speaking exercises',
        'reward': '50 pts',
        'completed': true,
        'icon': Icons.record_voice_over,
      },
      {
        'title': 'Social Interaction',
        'description': 'Practice conversation skills with a peer',
        'reward': '100 pts',
        'completed': false,
        'icon': Icons.people,
      },
    ];

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.flag, color: Colors.purple),
                    SizedBox(width: 8),
                    Text(
                      'Daily Challenges',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to Challenges page
                    _navigateToChallenges();
                  },
                  child: const Text('See All'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...challenges
                .map((challenge) => InkWell(
                      onTap: () => _showChallengeDetails(challenge),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(
                            backgroundColor: challenge['completed'] as bool
                                ? Colors.green
                                : Colors.grey.shade300,
                            child: Icon(
                              challenge['icon'] as IconData,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            challenge['title'] as String,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              decoration: challenge['completed'] as bool
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                          subtitle: Text(challenge['description'] as String),
                          trailing: Text(
                            challenge['reward'] as String,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.purple,
                            ),
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }

  void _navigateToChallenges() {
    // Define all challenges
    final List<Map<String, dynamic>> dailyChallenges = [
      {
        'title': 'Speech Practice',
        'description': 'Complete 10 minutes of speaking exercises',
        'reward': '50 pts',
        'completed': true,
        'icon': Icons.record_voice_over,
        'type': 'daily'
      },
      {
        'title': 'Social Interaction',
        'description': 'Practice conversation skills with a peer',
        'reward': '100 pts',
        'completed': false,
        'icon': Icons.people,
        'type': 'daily'
      },
      {
        'title': 'Morning Routine',
        'description': 'Complete your morning routine checklist',
        'reward': '30 pts',
        'completed': false,
        'icon': Icons.wb_sunny,
        'type': 'daily'
      },
      {
        'title': 'Play Speech Game',
        'description': 'Complete one round in the speech practice game',
        'reward': '75 pts',
        'completed': false,
        'icon': Icons.videogame_asset,
        'type': 'daily'
      }
    ];

    final List<Map<String, dynamic>> weeklyChallenges = [
      {
        'title': 'Perfect Week',
        'description': 'Complete all daily challenges for 7 days',
        'reward': '300 pts',
        'completed': false,
        'icon': Icons.calendar_today,
        'type': 'weekly',
        'progress': '3/7'
      },
      {
        'title': 'Social Master',
        'description': 'Complete 5 social skills activities this week',
        'reward': '250 pts',
        'completed': false,
        'icon': Icons.groups,
        'type': 'weekly',
        'progress': '2/5'
      },
      {
        'title': 'Speech Champion',
        'description': 'Achieve 90% accuracy in 3 speech practice sessions',
        'reward': '200 pts',
        'completed': false,
        'icon': Icons.mic,
        'type': 'weekly',
        'progress': '1/3'
      }
    ];

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Daily Challenges'),
                backgroundColor: Colors.purple.shade800,
              ),
              body: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.purple.shade200, Colors.white],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Today's Challenges
                      const Text(
                        'Today\'s Challenges',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Complete daily challenges to earn points and maintain your streak',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Daily challenges list
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Daily challenges
                              ...dailyChallenges
                                  .map((challenge) => Card(
                                        margin:
                                            const EdgeInsets.only(bottom: 10),
                                        elevation: 2,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            _showChallengeDetailsWithCompletion(
                                                challenge, setState);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CircleAvatar(
                                                  backgroundColor:
                                                      challenge['completed']
                                                              as bool
                                                          ? Colors.green
                                                          : Colors
                                                              .purple.shade100,
                                                  child: Icon(
                                                    challenge['icon']
                                                        as IconData,
                                                    color:
                                                        challenge['completed']
                                                                as bool
                                                            ? Colors.white
                                                            : Colors.purple,
                                                  ),
                                                ),
                                                const SizedBox(width: 16),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            challenge['title']
                                                                as String,
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16,
                                                              decoration: challenge[
                                                                          'completed']
                                                                      as bool
                                                                  ? TextDecoration
                                                                      .lineThrough
                                                                  : null,
                                                            ),
                                                          ),
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                              horizontal: 8,
                                                              vertical: 4,
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .purple
                                                                  .shade50,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                            ),
                                                            child: Text(
                                                              challenge[
                                                                      'reward']
                                                                  as String,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .purple
                                                                    .shade700,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 4),
                                                      Text(
                                                        challenge['description']
                                                            as String,
                                                        style: TextStyle(
                                                          color: Colors
                                                              .grey.shade700,
                                                          decoration: challenge[
                                                                      'completed']
                                                                  as bool
                                                              ? TextDecoration
                                                                  .lineThrough
                                                              : null,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 8),
                                                      challenge['completed']
                                                              as bool
                                                          ? const Row(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .check_circle,
                                                                  color: Colors
                                                                      .green,
                                                                  size: 16,
                                                                ),
                                                                SizedBox(
                                                                    width: 4),
                                                                Text(
                                                                  'Completed',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .green,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          : ElevatedButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  challenge[
                                                                          'completed'] =
                                                                      true;
                                                                });
                                                              },
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                backgroundColor:
                                                                    Colors
                                                                        .purple,
                                                                padding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                  horizontal:
                                                                      16,
                                                                  vertical: 8,
                                                                ),
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                ),
                                                              ),
                                                              child: const Text(
                                                                  'Complete Challenge'),
                                                            ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ))
                                  .toList(),

                              const SizedBox(height: 24),

                              // Weekly challenges section
                              const Text(
                                'Weekly Challenges',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Long-term challenges with bigger rewards',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Weekly challenges list
                              ...weeklyChallenges
                                  .map((challenge) => Card(
                                        margin:
                                            const EdgeInsets.only(bottom: 10),
                                        elevation: 2,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            _showWeeklyChallengeDetails(
                                                challenge);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CircleAvatar(
                                                  backgroundColor:
                                                      challenge['completed']
                                                              as bool
                                                          ? Colors.green
                                                          : Colors
                                                              .blue.shade100,
                                                  child: Icon(
                                                    challenge['icon']
                                                        as IconData,
                                                    color:
                                                        challenge['completed']
                                                                as bool
                                                            ? Colors.white
                                                            : Colors.blue,
                                                  ),
                                                ),
                                                const SizedBox(width: 16),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            challenge['title']
                                                                as String,
                                                            style:
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                              horizontal: 8,
                                                              vertical: 4,
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .blue.shade50,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                            ),
                                                            child: Text(
                                                              challenge[
                                                                      'reward']
                                                                  as String,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .blue
                                                                    .shade700,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 4),
                                                      Text(
                                                        challenge['description']
                                                            as String,
                                                        style: TextStyle(
                                                          color: Colors
                                                              .grey.shade700,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child:
                                                                LinearProgressIndicator(
                                                              value: _getProgressValue(
                                                                  challenge[
                                                                          'progress']
                                                                      as String),
                                                              backgroundColor:
                                                                  Colors.grey
                                                                      .shade300,
                                                              valueColor:
                                                                  AlwaysStoppedAnimation(
                                                                      Colors
                                                                          .blue),
                                                              minHeight: 6,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 8),
                                                          Text(
                                                            challenge[
                                                                    'progress']
                                                                as String,
                                                            style: TextStyle(
                                                              color: Colors.grey
                                                                  .shade700,
                                                              fontSize: 12,
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
                                        ),
                                      ))
                                  .toList(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

// Helper method to calculate progress percentage
  double _getProgressValue(String progressText) {
    final parts = progressText.split('/');
    if (parts.length == 2) {
      return int.parse(parts[0]) / int.parse(parts[1]);
    }
    return 0.0;
  }

// Show challenge details with completion option
  void _showChallengeDetailsWithCompletion(
      Map<String, dynamic> challenge, StateSetter setStateCallback) {
    final bool isCompleted = challenge['completed'] as bool;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(challenge['icon'] as IconData, color: Colors.purple),
            const SizedBox(width: 8),
            Text(challenge['title'] as String),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(challenge['description'] as String),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.card_giftcard, size: 20, color: Colors.purple),
                const SizedBox(width: 8),
                Text(
                  'Reward: ${challenge['reward']}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Completing this challenge will help you:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 8),
            const Row(
              children: [
                Icon(Icons.check, size: 16, color: Colors.green),
                SizedBox(width: 8),
                Expanded(
                  child: Text('Improve your skills in this area'),
                ),
              ],
            ),
            const SizedBox(height: 4),
            const Row(
              children: [
                Icon(Icons.check, size: 16, color: Colors.green),
                SizedBox(width: 8),
                Expanded(
                  child: Text('Earn points to level up'),
                ),
              ],
            ),
            const SizedBox(height: 4),
            const Row(
              children: [
                Icon(Icons.check, size: 16, color: Colors.green),
                SizedBox(width: 8),
                Expanded(
                  child: Text('Maintain your daily streak'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (!isCompleted)
              ElevatedButton.icon(
                onPressed: () {
                  setStateCallback(() {
                    challenge['completed'] = true;
                    // We would also update userPoints here in a real app
                    // userPoints += int.parse((challenge['reward'] as String).split(' ')[0]);
                  });

                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Challenge completed! Earned ${challenge['reward']}'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                icon: const Icon(Icons.check_circle),
                label: const Text('Mark as Completed'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                ),
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

// Show weekly challenge details
  void _showWeeklyChallengeDetails(Map<String, dynamic> challenge) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(challenge['icon'] as IconData, color: Colors.blue),
            const SizedBox(width: 8),
            Text(challenge['title'] as String),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(challenge['description'] as String),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.card_giftcard, size: 20, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  'Reward: ${challenge['reward']}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Progress:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: _getProgressValue(challenge['progress'] as String),
                    backgroundColor: Colors.grey.shade300,
                    valueColor: AlwaysStoppedAnimation(Colors.blue),
                    minHeight: 10,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  challenge['progress'] as String,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.info,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Weekly challenges reset every Sunday at midnight',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _navigateToAchievements() {
    // Define achievement data
    final Map<String, List<Map<String, dynamic>>> achievements = {
      'Games': [
        {
          'title': 'Word Matcher',
          'highScore': 85,
          'totalPlays': 12,
          'icon': Icons.games,
        },
        {
          'title': 'Pronunciation Practice',
          'highScore': 92,
          'totalPlays': 8,
          'icon': Icons.record_voice_over,
        },
        {
          'title': 'Social Scenarios',
          'highScore': 78,
          'totalPlays': 6,
          'icon': Icons.people,
        },
      ],
      'Activities': [
        {
          'title': 'Morning Routine',
          'completionRate': 0.85,
          'timesCompleted': 17,
          'icon': Icons.wb_sunny,
        },
        {
          'title': 'Speech Exercises',
          'completionRate': 0.92,
          'timesCompleted': 23,
          'icon': Icons.mic,
        },
        {
          'title': 'Social Skills Practice',
          'completionRate': 0.75,
          'timesCompleted': 15,
          'icon': Icons.groups,
        },
      ],
    };
    // Create weekly progress data
    final List<Map<String, dynamic>> weeklyProgressData = [
      {'day': 'Mon', 'points': 120},
      {'day': 'Tue', 'points': 180},
      {'day': 'Wed', 'points': 150},
      {'day': 'Thu', 'points': 210},
      {'day': 'Fri', 'points': 190},
      {'day': 'Sat', 'points': 100},
      {'day': 'Sun', 'points': 140},
    ];
    // Create monthly skill progress data
    final List<double> monthlyProgressData = [0.3, 0.45, 0.6, 0.75];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('My Achievements'),
              //backgroundColor: Colors.purple.shade800,
              backgroundColor: const Color.fromARGB(255, 159, 80, 208),

              bottom: const TabBar(
                tabs: [
                  Tab(text: 'Overview'),
                  Tab(text: 'Games'),
                  Tab(text: 'Activities'),
                ],
                indicatorColor: Colors.black,
                labelColor: Colors.white,
              ),
            ),
            body: TabBarView(
              children: [
                // Overview Tab
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.purple.shade200, Colors.white],
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // User Stats Card
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Your Progress Summary',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    _buildStatItem(
                                        Icons.star, '1,240', 'Total Points'),
                                    _buildStatItem(Icons.calendar_today, '18',
                                        'Day Streak'),
                                    _buildStatItem(Icons.emoji_events, '12',
                                        'Achievements'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Weekly Progress
                        const Text(
                          'Weekly Points Progress',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: SizedBox(
                              height: 180,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'This Week: 1,090 points',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.green.shade100,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.trending_up,
                                              size: 16,
                                              color: Colors.green.shade700,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              '+20%',
                                              style: TextStyle(
                                                color: Colors.green.shade700,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: weeklyProgressData.map((data) {
                                        final double height =
                                            data['points'] / 2.5;
                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              data['points'].toString(),
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey.shade600,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Container(
                                              width: 30,
                                              height: height,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment.bottomCenter,
                                                  end: Alignment.topCenter,
                                                  colors: [
                                                    Colors.purple.shade300,
                                                    Colors.purple.shade500,
                                                  ],
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              data['day'] as String,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Monthly Skills Progress
                        const Text(
                          'Skills Growth This Month',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                _buildSkillProgressBar('Speech Clarity',
                                    monthlyProgressData[0], Colors.purple),
                                const SizedBox(height: 16),
                                _buildSkillProgressBar('Social Interactions',
                                    monthlyProgressData[1], Colors.blue),
                                const SizedBox(height: 16),
                                _buildSkillProgressBar('Daily Routines',
                                    monthlyProgressData[2], Colors.green),
                                const SizedBox(height: 16),
                                _buildSkillProgressBar('Communication',
                                    monthlyProgressData[3], Colors.orange),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Recent Badges
                        const Text(
                          'Recent Badges',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildBadgeItem(Icons.military_tech,
                                    'Master Speaker', Colors.purple.shade700),
                                _buildBadgeItem(Icons.emoji_people,
                                    'Social Star', Colors.blue.shade700),
                                _buildBadgeItem(Icons.local_fire_department,
                                    '10-Day Streak', Colors.orange),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Games Tab
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.purple.shade200, Colors.white],
                    ),
                  ),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: achievements['Games']!.length,
                    itemBuilder: (context, index) {
                      final game = achievements['Games']![index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.purple.shade100,
                                    child: Icon(
                                      game['icon'] as IconData,
                                      color: Colors.purple,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    game['title'] as String,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        '${game['highScore']}%',
                                        style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.purple,
                                        ),
                                      ),
                                      const Text('High Score'),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        game['totalPlays'].toString(),
                                        style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.purple,
                                        ),
                                      ),
                                      const Text('Total Plays'),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        '${(game['highScore'] as int) ~/ 10}/10',
                                        style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.purple,
                                        ),
                                      ),
                                      const Text('Level'),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton.icon(
                                onPressed: () {
                                  // Logic to play the game
                                },
                                icon: const Icon(Icons.play_arrow),
                                label: const Text('Play Now'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.purple,
                                  foregroundColor: Colors.white,
                                  minimumSize: const Size(double.infinity, 40),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Activities Tab
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.purple.shade200, Colors.white],
                    ),
                  ),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: achievements['Activities']!.length,
                    itemBuilder: (context, index) {
                      final activity = achievements['Activities']![index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.blue.shade100,
                                    child: Icon(
                                      activity['icon'] as IconData,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    activity['title'] as String,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'Completion Rate:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: LinearProgressIndicator(
                                      value:
                                          activity['completionRate'] as double,
                                      backgroundColor: Colors.grey.shade300,
                                      valueColor:
                                          AlwaysStoppedAnimation(Colors.blue),
                                      minHeight: 10,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '${((activity['completionRate'] as double) * 100).toInt()}%',
                                    style: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Times Completed: ${activity['timesCompleted']}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Logic to start activity
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: const Text('Start Activity'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// Helper widget to build stat items
  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.purple.shade50,
          child: Icon(
            icon,
            color: Colors.purple,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

// Helper widget to build skill progress bars
  Widget _buildSkillProgressBar(String label, double value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '${(value * 100).toInt()}%',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: value,
          backgroundColor: Colors.grey.shade200,
          valueColor: AlwaysStoppedAnimation(color),
          minHeight: 8,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }

// Helper widget to build badge items
  Widget _buildBadgeItem(IconData icon, String label, Color color) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: color.withOpacity(0.2),
          child: Icon(
            icon,
            color: color,
            size: 30,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  void _showChallengeDetails(Map<String, dynamic> challenge) {
    final bool isCompleted = challenge['completed'] as bool;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(challenge['icon'] as IconData, color: Colors.purple),
            const SizedBox(width: 8),
            Text(challenge['title'] as String),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(challenge['description'] as String),
            const SizedBox(height: 16),
            if (!isCompleted)
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    challenge['completed'] = true;
                    userPoints += int.parse(
                        (challenge['reward'] as String).split(' ')[0]);
                    _calculateUserLevel();
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Challenge completed! Earned ${challenge['reward']}'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                child: const Text('Mark as Completed'),
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

/*import 'package:flutter/material.dart';
import 'dart:math' as math;

class RewardsPage extends StatefulWidget {
  const RewardsPage({Key? key}) : super(key: key);

  @override
  State<RewardsPage> createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage>
    with SingleTickerProviderStateMixin {
  // Animation controller for the progress indicators
  late AnimationController _controller;

  // Current progress values
  double speechSkillsProgress = 0.75;
  double socialSkillsProgress = 0.5;
  double dailyLifeSkillsProgress = 0.3;

  // User points
  int userPoints = 1250;

  // Selected reward
  Map<String, dynamic>? selectedReward;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Remove automatic back button by using this custom AppBar
      appBar: AppBar(
        title: const Text('My Rewards'),
        centerTitle: true,
        backgroundColor: Colors.purple.shade800,
        elevation: 0,
        automaticallyImplyLeading: false, // This removes the back button
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade900,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 18),
                  const SizedBox(width: 4),
                  Text(
                    '$userPoints pts',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple.shade800, Colors.purple.shade100],
          ),
        ),
        // SafeArea removed to allow content to go all the way to the top
        child: SingleChildScrollView(
          // No top padding to allow content to start from the top
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
            child: Column(
              children: [
                // Progress Dashboard
                _buildProgressDashboard(),
                const SizedBox(height: 20),
                // Gamified Rewards Section
                _buildRewardsSection(),
                const SizedBox(height: 20),
                // Challenges Section
                _buildChallengesSection(),
              ],
            ),
          ),
        ),
      ),
      // Remove any bottom padding
      resizeToAvoidBottomInset: false,
    );
  }

  Widget _buildProgressDashboard() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.only(top: 10), // Reduced top margin
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Row(
              children: [
                Icon(Icons.insights, color: Colors.purple),
                SizedBox(width: 8),
                Text(
                  'Your Progress',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildAnimatedCircularProgress(
                  speechSkillsProgress,
                  'Speech Skills',
                  Colors.blue,
                  '${(speechSkillsProgress * 100).toInt()} / 100',
                  Icons.record_voice_over,
                ),
                _buildAnimatedCircularProgress(
                  socialSkillsProgress,
                  'Social Skills',
                  Colors.green,
                  '${(socialSkillsProgress * 100).toInt()} / 100',
                  Icons.people,
                ),
                _buildAnimatedCircularProgress(
                  dailyLifeSkillsProgress,
                  'Daily Life Skills',
                  Colors.orange,
                  '${(dailyLifeSkillsProgress * 100).toInt()} / 100',
                  Icons.home,
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.refresh),
              label: const Text('Update Progress'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: () {
                setState(() {
                  // Simulate progress update with random values
                  speechSkillsProgress = math.min(
                      1.0,
                      speechSkillsProgress +
                          (math.Random().nextDouble() * 0.2));
                  socialSkillsProgress = math.min(
                      1.0,
                      socialSkillsProgress +
                          (math.Random().nextDouble() * 0.2));
                  dailyLifeSkillsProgress = math.min(
                      1.0,
                      dailyLifeSkillsProgress +
                          (math.Random().nextDouble() * 0.2));

                  // Add points for progress
                  userPoints += 50;

                  // Reset animation
                  _controller.reset();
                  _controller.forward();
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedCircularProgress(
    double value,
    String label,
    Color color,
    String centerText,
    IconData icon,
  ) {
    return GestureDetector(
      onTap: () {
        _showProgressDetails(label, value, color, icon);
      },
      child: Column(
        children: [
          SizedBox(
            width: 110, // Increased size from 90
            height: 110, // Increased size from 90
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return CircularProgressIndicator(
                      value: _controller.value * value,
                      strokeWidth: 12, // Increased from 10
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation(color),
                    );
                  },
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, size: 20, color: color), // Increased from 16
                    Text(
                      centerText,
                      style: const TextStyle(
                        fontSize: 14, // Increased from 11
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showProgressDetails(
      String label, double value, Color color, IconData icon) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 8),
            Text(label),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LinearProgressIndicator(
              value: value,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation(color),
              minHeight: 10,
            ),
            const SizedBox(height: 16),
            Text('Current progress: ${(value * 100).toInt()}%'),
            const SizedBox(height: 8),
            if (label == 'Speech Skills')
              Text('${(value * 100).toInt()} out of 100 points')
            else if (label == 'Social Skills')
              Text('${(value * 100).toInt()} out of 100 points')
            else if (label == 'Daily Life Skills')
              Text('${(value * 100).toInt()} out of 100 points'),
            const SizedBox(height: 16),
            _buildSkillDetails(label),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillDetails(String skillType) {
    List<String> details = [];

    if (skillType == 'Speech Skills') {
      details = [
        'Pronunciation',
        'Vocabulary Usage',
        'Sentence Construction',
        'Communication Clarity'
      ];
    } else if (skillType == 'Social Skills') {
      details = [
        'Eye Contact',
        'Turn Taking',
        'Social Cues Recognition',
        'Emotional Expression'
      ];
    } else if (skillType == 'Daily Life Skills') {
      details = [
        'Self-Care Routines',
        'Time Management',
        'Organization Skills',
        'Task Completion'
      ];
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Skill Components:',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ...details
            .map((detail) => Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle,
                          size: 14, color: Colors.green),
                      const SizedBox(width: 4),
                      Text(detail),
                    ],
                  ),
                ))
            .toList(),
      ],
    );
  }

  Widget _buildRewardsSection() {
    final List<Map<String, dynamic>> rewards = [
      {
        'name': 'Bronze Badge',
        'icon': Icons.emoji_events,
        'color': Colors.brown,
        'points': 500,
        'unlocked': true,
        'description': 'Earned by completing 5 daily goals in a row.',
      },
      {
        'name': 'Silver Badge',
        'icon': Icons.emoji_events,
        'color': Colors.grey.shade400,
        'points': 1000,
        'unlocked': true,
        'description':
            'Earned by maintaining skill levels above 50% for 10 days.',
      },
      {
        'name': 'Gold Badge',
        'icon': Icons.emoji_events,
        'color': Colors.amber,
        'points': 2000,
        'unlocked': false,
        'description': 'Complete all daily activities for 15 consecutive days.',
      },
      {
        'name': 'Platinum Badge',
        'icon': Icons.emoji_events,
        'color': Colors.blue.shade300,
        'points': 5000,
        'unlocked': false,
        'description': 'Maintain all skill scores above 75 for a month.',
      },
    ];

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.card_giftcard, color: Colors.purple),
                SizedBox(width: 8),
                Text(
                  'Your Rewards',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.3,
              ),
              itemCount: rewards.length,
              itemBuilder: (context, index) {
                final reward = rewards[index];
                final isUnlocked = reward['unlocked'] as bool;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedReward = reward;
                    });
                    _showRewardDetails(reward);
                  },
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: selectedReward == reward
                            ? Colors.purple
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    color: isUnlocked ? reward['color'] : Colors.grey.shade700,
                    child: Stack(
                      children: [
                        if (!isUnlocked)
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                reward['icon'],
                                color: Colors.white,
                                size: 32,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                reward['name'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                '${reward['points']} pts',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (!isUnlocked)
                          const Positioned(
                            top: 5,
                            right: 5,
                            child: Icon(
                              Icons.lock,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showRewardDetails(Map<String, dynamic> reward) {
    final bool isUnlocked = reward['unlocked'] as bool;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: reward['color'],
              child: Icon(
                reward['icon'],
                color: Colors.white,
                size: 40,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              reward['name'],
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${reward['points']} points',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              reward['description'],
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            if (!isUnlocked) ...[
              const Text(
                'Keep going to unlock this reward!',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                icon: const Icon(Icons.lock_open),
                label: const Text('Unlock with Points'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: userPoints >= reward['points']
                    ? () {
                        setState(() {
                          userPoints -= reward['points'] as int;
                          reward['unlocked'] = true;
                        });
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Congratulations! You unlocked ${reward['name']}!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    : null,
              ),
            ],
            if (isUnlocked) ...[
              const SizedBox(height: 8),
              ElevatedButton.icon(
                icon: const Icon(Icons.share),
                label: const Text('Share this Achievement'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Sharing achievement...'),
                    ),
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildChallengesSection() {
    final challenges = [
      {
        'title': 'Speech Practice',
        'description': 'Complete 10 minutes of speaking exercises',
        'reward': '50 pts',
        'completed': true,
        'icon': Icons.record_voice_over,
      },
      {
        'title': 'Social Interaction',
        'description': 'Practice conversation skills with a peer',
        'reward': '100 pts',
        'completed': false,
        'icon': Icons.people,
      },
      {
        'title': 'Daily Task',
        'description': 'Complete a daily living skill independently',
        'reward': '200 pts',
        'completed': false,
        'icon': Icons.home,
      },
    ];

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.flag, color: Colors.purple),
                SizedBox(width: 8),
                Text(
                  'Daily Challenges',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...challenges
                .map((challenge) => Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: challenge['completed'] as bool
                              ? Colors.green
                              : Colors.grey.shade300,
                          child: Icon(
                            challenge['icon'] as IconData,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                          challenge['title'] as String,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: challenge['completed'] as bool
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        subtitle: Text(challenge['description'] as String),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              challenge['reward'] as String,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.purple,
                              ),
                            ),
                            const SizedBox(height: 4),
                            if (!(challenge['completed'] as bool))
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    challenge['completed'] = true;
                                    userPoints += int.parse(
                                        (challenge['reward'] as String)
                                            .split(' ')[0]);
                                  });

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Challenge completed! Earned ${challenge['reward']}'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.purple,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 0),
                                  minimumSize: const Size(60, 24),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: const Text('Complete',
                                    style: TextStyle(fontSize: 10)),
                              ),
                            if (challenge['completed'] as bool)
                              const Icon(Icons.check_circle,
                                  color: Colors.green, size: 20),
                          ],
                        ),
                        onTap: () {
                          // Show challenge details
                          _showChallengeDetails(challenge);
                        },
                      ),
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }

  void _showChallengeDetails(Map<String, dynamic> challenge) {
    final bool isCompleted = challenge['completed'] as bool;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(challenge['icon'] as IconData, color: Colors.purple),
            const SizedBox(width: 8),
            Text(challenge['title'] as String),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(challenge['description'] as String),
            const SizedBox(height: 16),
            if (!isCompleted)
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    challenge['completed'] = true;
                    userPoints += int.parse(
                        (challenge['reward'] as String).split(' ')[0]);
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Challenge completed! Earned ${challenge['reward']}'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                child: const Text('Mark as Completed'),
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
*/
