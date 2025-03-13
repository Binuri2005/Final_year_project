import 'package:app/dailylife_skills_module/create_skill_tast.view.dart';
import 'package:app/dailylife_skills_module/datastructure_dailyskill.dart';
import 'package:app/dailylife_skills_module/task_overview_page.dart';
import 'package:app/viewmodels/daily_skills/daily_skills.viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DailyLifeSkillsScreen extends StatefulWidget {
  @override
  State<DailyLifeSkillsScreen> createState() => _DailyLifeSkillsScreenState();
}

class _DailyLifeSkillsScreenState extends State<DailyLifeSkillsScreen> {
  final List<Map<String, dynamic>> categories = [
    {
      'icon': Icons.wb_sunny,
      'label': 'Morning Routine',
      'color': Colors.amber,
      'task': tasks.length > 0 ? tasks[0] : null,
    },
    {
      'icon': Icons.nightlight_round,
      'label': 'Night Routine',
      'color': Colors.indigo,
      'task': tasks.length > 1 ? tasks[1] : null,
    },
    {
      'icon': Icons.restaurant,
      'label': 'Meal Prep',
      'color': Colors.green,
      'task': tasks.length > 2 ? tasks[2] : null,
    },
    {
      'icon': Icons.soap,
      'label': 'Personal Hygiene',
      'color': Colors.blue,
      'task': tasks.length > 3 ? tasks[3] : null,
    },
    {
      'icon': Icons.cleaning_services,
      'label': 'Chores',
      'color': Colors.purple,
      'task': tasks.length > 4 ? tasks[4] : null,
    },
    {
      'icon': Icons.school,
      'label': 'School Prep',
      'color': Colors.red,
      'task': tasks.length > 5 ? tasks[5] : null,
    },
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DailySkillViewModel>().getDailySkills();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.surface,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: Theme.of(context).colorScheme.primary),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Daily Life Skills',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline,
                color: Theme.of(context).colorScheme.primary),
            onPressed: () {
              // Show help information
              showModalBottomSheet(
                context: context,
                builder: (context) => Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Daily Life Skills Help',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'This screen helps you manage routine tasks and build daily life skills. Tap on a category to view tasks or create your own routine.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Got it'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50),
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
      body: Consumer<DailySkillViewModel>(
        builder: (context, state, _) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).colorScheme.surface,
                  Theme.of(context).colorScheme.surface.withOpacity(0.8),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select a Category',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: state.isFetchingDailySkills
                        ? Center(child: CircularProgressIndicator())
                        : GridView(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16.0,
                              mainAxisSpacing: 16.0,
                              childAspectRatio: 1.0,
                            ),
                            children: [
                              ...categories.map((category) {
                                return _buildCategoryCard(category);
                              }).toList(),
                              if (state.dailySkills.isNotEmpty) ...[
                                ...state.dailySkills.map((dailySkill) {
                                  return _buildCategoryCard({
                                    'icon': Icons.star,
                                    'label': dailySkill.title,
                                    'color': Colors.orange,
                                    'task': dailySkill,
                                  });
                                }).toList()
                              ]
                            ],
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChallengeCreator(),
            ),
          );
        },
        child: Icon(Icons.add),
        tooltip: 'Create new routine',
      ),
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> category) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          if (category['task'] != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TaskOverviewPage(task: category['task']),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChallengeCreator(),
              ),
            );
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                category['color'] ?? Theme.of(context).colorScheme.primary,
                (category['color'] ?? Theme.of(context).colorScheme.primary)
                    .withOpacity(0.7),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  category['icon'],
                  size: 40,
                  color: Colors.white,
                ),
                SizedBox(height: 12),
                Text(
                  category['label'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
