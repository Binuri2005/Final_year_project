/*import 'package:app/dailylife_skills_module/create_skill_tast.view.dart';
import 'package:app/dailylife_skills_module/datastructure_dailyskill.dart';
import 'package:app/dailylife_skills_module/task_overview_page.dart';
import 'package:app/global/category_button.dart';
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
      'task': tasks.length > 0 ? tasks[0] : null,
    },
    {
      'icon': Icons.nightlight_round,
      'label': 'Night Routine',
      'task': tasks.length > 1 ? tasks[1] : null,
    },
    {
      'icon': Icons.restaurant,
      'label': 'Meal Prep',
      'task': tasks.length > 2 ? tasks[2] : null,
    },
    {
      'icon': Icons.soap,
      'label': 'Personal Hygiene',
      'task': tasks.length > 3 ? tasks[3] : null,
    },
    {
      'icon': Icons.cleaning_services,
      'label': 'Chores',
      'task': tasks.length > 4 ? tasks[4] : null,
    },
    {
      'icon': Icons.school,
      'label': 'School Prep',
      'task': tasks.length > 5 ? tasks[5] : null,
    },
    {
      'icon': Icons.add_circle_outline,
      'label': 'Create Your Own Routine',
      'task': null,
    },
  ];

  @override
  void initState() {
    context.read<DailySkillViewModel>().getDailySkills();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Daily Life Skills'),
      ),
      body: Consumer<DailySkillViewModel>(
        builder: (context, state, _) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                        childAspectRatio: 1.0,
                      ),
                      children: [
                        ...categories.map((category) {
                          return CategoryButton(
                            icon: category['icon'],
                            label: category['label'],
                            onTap: () {
                              if (category['task'] != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TaskOverviewPage(
                                        task: category['task']),
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
                          );
                        }).toList(),
                        ...[
                          ...state.dailySkills.map((dailySkill) {
                            return CategoryButton(
                              icon: Icons.add_alert,
                              label: dailySkill.title,
                             // onTap: () {
                               // Navigator.push(
                                //  context,
                                 // MaterialPageRoute(
                                  //  builder: (context) =>
                                     //   TaskOverviewPage(task: task),
                                 // ),
                               // );
                            //  },
                           // );
                          }).toList()
                        ]
                      ]),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/*import 'package:app/dailylife_skills_module/create_skill_tast.view.dart';
import 'package:app/dailylife_skills_module/datastructure_dailyskill.dart';
import 'package:app/dailylife_skills_module/task_overview_page.dart';
import 'package:app/global/category_button.dart';
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
      'task': tasks.length > 0 ? tasks[0] : null,
    },
    {
      'icon': Icons.nightlight_round,
      'label': 'Night Routine',
      'task': tasks.length > 1 ? tasks[1] : null,
    },
    {
      'icon': Icons.restaurant,
      'label': 'Meal Prep',
      'task': tasks.length > 2 ? tasks[2] : null,
    },
    {
      'icon': Icons.soap,
      'label': 'Personal Hygiene',
      'task': tasks.length > 3 ? tasks[3] : null,
    },
    {
      'icon': Icons.cleaning_services,
      'label': 'Chores',
      'task': tasks.length > 4 ? tasks[4] : null,
    },
    {
      'icon': Icons.school,
      'label': 'School Prep',
      'task': tasks.length > 5 ? tasks[5] : null,
    },
    {
      'icon': Icons.add_circle_outline,
      'label': 'Create Your Own Routine',
      'task': null,
    },
  ];

  @override
  void initState() {
    context.read<DailySkillViewModel>().getDailySkills();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Daily Life Skills'),
      ),
      body: Consumer<DailySkillViewModel>(
        builder: (context, state, _) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                        childAspectRatio: 1.0,
                      ),
                      children: [
                        ...categories.map((category) {
                          return CategoryButton(
                            icon: category['icon'],
                            label: category['label'],
                            onTap: () {
                              if (category['task'] != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TaskOverviewPage(
                                        task: category['task']),
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
                          );
                        }).toList(),
                        ...[
                          ...state.dailySkills.map((task) {
                            return CategoryButton(
                              icon: Icons.add_alert,
                              label: task.title,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        TaskOverviewPage(task: task),
                                  ),
                                );
                              },
                            );
                          }).toList()
                        ]
                      ]),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}*/
*/