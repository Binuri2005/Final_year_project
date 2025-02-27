import 'package:app/dailylife_skills_module/datastructure_dailyskill.dart';
import 'package:app/dailylife_skills_module/task_overview_page.dart';
import 'package:flutter/material.dart';
import 'package:app/global/category_button.dart';

class DailyLifeSkillsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {
      'icon': Icons.wb_sunny,
      'label': 'Morning Routine',
      'task': tasks[0], // Updated to use Task class
    },
    {
      'icon': Icons.nightlight_round,
      'label': 'Night Routine',
      'task': tasks[1], // Updated to use Task class
    },
    {
      'icon': Icons.restaurant,
      'label': 'Meal Prep',
      'task': tasks[2], // Updated to use Task class
    },
    {
      'icon': Icons.soap,
      'label': 'Personal Hygiene',
      'task': tasks[3], // Updated to use Task class
    },
    {
      'icon': Icons.cleaning_services,
      'label': 'Chores',
      'task': tasks[4], // Updated to use Task class
    },
    {
      'icon': Icons.school,
      'label': 'School Prep',
      'task': tasks[5], // Updated to use Task class
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        TaskPage(task: categories[index]['task']),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
