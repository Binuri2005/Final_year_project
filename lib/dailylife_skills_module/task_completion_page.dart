import 'package:app/dailylife_skills_module/datastructure_dailyskill.dart';
import 'package:app/dailylife_skills_module/main_landing_page.dart';
import 'package:app/dailylife_skills_module/task_overview_page.dart';
import 'package:flutter/material.dart';

class TaskCompletionPage extends StatelessWidget {
  final Task task;
  final int completedSteps;
  final int totalSteps;

  const TaskCompletionPage({
    required this.task,
    required this.completedSteps,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    final bool allStepsCompleted = completedSteps == totalSteps;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.star,
              size: 100,
              color: Colors.amber,
            ),
            SizedBox(height: 20),
            Text(
              allStepsCompleted
                  ? 'Great job! You completed ${task.title.toLowerCase()}!'
                  : 'You completed $completedSteps out of $totalSteps steps. Next time, do better!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'You’re doing amazing! Keep it up!',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DailyLifeSkillsScreen()),
                  (route) => false,
                );
              },
              child: Text('Return to Main Page'),
            ),
          ],
        ),
      ),
    );
  }
}
