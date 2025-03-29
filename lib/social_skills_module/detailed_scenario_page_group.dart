import 'package:flutter/material.dart';
import 'package:app/social_skills_module/group_roleplay_datastructure.dart';

class GroupScenarioDetailPage extends StatelessWidget {
  final String scenario;

  const GroupScenarioDetailPage({required this.scenario, Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Fetching the data for the specific group scenario
    var scenarioContent = groupScenarioDetails[scenario] ??
        {
          'description': 'Description not available',
          'steps': ['No steps available'],
          'roles': [],
          'dialogues': {},
        };

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/light_background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // App Bar with Back Button
                  Row(
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
                  const SizedBox(height: 24),

                  // Scenario Title
                  Center(
                    child: Text(
                      scenario,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Description Box
                  Container(
                    width: double.infinity,
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
                    child: Text(
                      scenarioContent['description'],
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // "Roles Involved" Heading
                  Center(
                    child: Text(
                      "Roles Involved",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Roles List
                  Column(
                    children: scenarioContent['roles']
                        .map<Widget>(
                          (role) => Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      Colors.purple.shade600.withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                              border: Border.all(
                                color: Colors.purple.shade600,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              role,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 20),

                  // "Steps to Follow" Heading
                  Center(
                    child: Text(
                      "Steps to Follow",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Steps Boxes with Borders and Left-aligned Text
                  Column(
                    children: scenarioContent['steps']
                        .map<Widget>(
                          (step) => Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      Colors.purple.shade600.withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                              border: Border.all(
                                color: Colors.purple.shade600,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              step,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 20),

                  // "Role Dialogues" Heading
                  Center(
                    child: Text(
                      "Role Dialogues",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Role dialogues for each role
                  Column(
                    children: (scenarioContent['dialogues']
                            as Map<String, List<String>>)
                        .entries
                        .map<Widget>(
                          (entry) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Role Name Heading
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 5),
                                child: Text(
                                  entry.key,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                              ),
                              // Dialogue Box
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(20),
                                margin: const EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.purple.shade600
                                          .withOpacity(0.2),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                  border: Border.all(
                                    color: Colors.purple.shade600,
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: entry.value
                                      .map<Widget>(
                                        (dialogue) => Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 8),
                                          child: Text(
                                            "• $dialogue",
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList(),
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
