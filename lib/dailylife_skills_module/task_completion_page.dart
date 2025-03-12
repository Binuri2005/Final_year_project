/*import 'package:app/dailylife_skills_module/datastructure_dailyskill.dart';
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
    final double completionPercentage =
        totalSteps > 0 ? (completedSteps / totalSteps) * 100 : 0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Task Completion'),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated completion indicator
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.withOpacity(0.1),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircularProgressIndicator(
                    value: completedSteps / totalSteps,
                    strokeWidth: 12,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      allStepsCompleted ? Colors.green : Colors.blue,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        allStepsCompleted ? Icons.celebration : Icons.star,
                        size: 50,
                        color: allStepsCompleted ? Colors.green : Colors.amber,
                      ),
                      Text(
                        '${completionPercentage.toInt()}%',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: allStepsCompleted ? Colors.green : Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),

            // Completion message
            Text(
              allStepsCompleted ? 'Great job!' : 'Almost there!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: allStepsCompleted ? Colors.green : Colors.blue,
              ),
            ),
            SizedBox(height: 15),

            // Task details
            Text(
              allStepsCompleted
                  ? 'You completed ${task.title.toLowerCase()} successfully!'
                  : 'You completed $completedSteps out of $totalSteps steps in ${task.title.toLowerCase()}.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),

            // Encouraging message
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                allStepsCompleted
                    ? 'You are doing amazing! Keep up the great work!'
                    : 'Progress is progress! You are on the right track!',
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            Spacer(),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!allStepsCompleted)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context); // Go back to the task
                      },
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: Text('Continue Task'),
                    ),
                  ),
                SizedBox(width: allStepsCompleted ? 0 : 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DailyLifeSkillsScreen()),
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      backgroundColor:
                          allStepsCompleted ? Colors.green : Colors.blue,
                    ),
                    child: Text('Return to Main Page'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

/*import 'package:app/dailylife_skills_module/datastructure_dailyskill.dart';
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

*/*/
