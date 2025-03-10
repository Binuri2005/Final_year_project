import 'package:flutter/material.dart';
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
