import 'package:app/social_skills_module/group_roleplay.dart';
import 'package:app/social_skills_module/individual_roleplay.dart';
import 'package:flutter/material.dart';
import 'package:app/social_skills_module/detailed_Scenario_page_individual%20.dart';

class RolePlayPage extends StatelessWidget {
  const RolePlayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/light_background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // App Bar with Back Button
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new_rounded,
                            size: 20),
                        color: Colors.black87,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.star_rounded,
                              color: Colors.amber.shade600, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            '520 XP',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Welcome Message
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.purple.shade600.withOpacity(0.9),
                      Colors.deepPurple.shade700.withOpacity(0.9),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.shade800.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      'Role Play Practice',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Improve your social skills by practicing conversations in different scenarios',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.purple.shade50,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Activities Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'CHOOSE A PRACTICE MODE',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // First Box (Individual Practice)
              _buildActivityCard(
                context: context,
                title: 'Individual Practice',
                description: 'Practice one-on-one conversation scenarios',
                icon: Icons.person_rounded,
                color: Colors.purple.shade600,
                onTap: () {
                  // Navigate to individual practice page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => IndividualRolePlayPage(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              // Second Box (Group Practice)
              _buildActivityCard(
                context: context,
                title: 'Group Scenario',
                description: 'Practice managing group conversations',
                icon: Icons.groups_rounded,
                color: Colors.indigo.shade600,
                showBadge: true,
                badgeText: 'NEW',
                onTap: () {
                  // Navigate to group practice page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GroupRolePlayPage(),
                    ),
                  );
                },
              ),

              const Spacer(),

              // Progress Bar at Bottom
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 24),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Weekly Progress',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        Text(
                          '65%',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.blue.shade800,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: 0.65,
                        minHeight: 10,
                        backgroundColor: Colors.grey.shade200,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.blue.shade600),
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

  Widget _buildActivityCard({
    required BuildContext context,
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    bool showBadge = false,
    String badgeText = '',
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Ink(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      icon,
                      size: 30,
                      color: color,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (showBadge) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade100,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  badgeText,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red.shade800,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: Colors.grey.shade400,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
