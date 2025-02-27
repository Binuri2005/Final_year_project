import 'package:app/dailylife_skills_module/datastructure_dailyskill.dart';
import 'package:app/dailylife_skills_module/task_overview_page.dart';
import 'package:flutter/material.dart';
import 'package:app/global/category_button.dart';

class DailyLifeSkillsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {
      'icon': Icons.wb_sunny,
      'label': 'Morning Routine',
      'task': tasks.length > 0 ? tasks[0] : null, // ✅ Check before accessing
    },
    {
      'icon': Icons.nightlight_round,
      'label': 'Night Routine',
      'task': tasks.length > 1 ? tasks[1] : null, // ✅ Check before accessing
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
  ];

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 1.0,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return CategoryButton(
              icon: categories[index]['icon'],
              label: categories[index]['label'],
              onTap: () {
                if (categories[index]['task'] != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          TaskPage(task: categories[index]['task']),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Task not available!')));
                }
              },
            );
          },
        ),
      ),
    );
  }
}
