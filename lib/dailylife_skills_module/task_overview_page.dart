import 'package:app/dailylife_skills_module/datastructure_dailyskill.dart';
import 'package:app/dailylife_skills_module/task_completion_page.dart';
import 'package:app/global/step_item.dart';
import 'package:flutter/material.dart';


class TaskPage extends StatefulWidget {
  final Task task;

  const TaskPage({required this.task});

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  int get completedSteps =>
      widget.task.steps.where((step) => step.isCompleted).length;
  int get totalSteps => widget.task.steps.length;

  void _checkForMissedSteps() {
    for (var step in widget.task.steps) {
      if (!step.isCompleted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Don’t forget to ${step.instruction.toLowerCase()}!'),
            duration: Duration(seconds: 2),
          ),
        );
        break; // Show reminder for the first missed step
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task.title),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearProgressIndicator(
              value: completedSteps / totalSteps,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),
            SizedBox(height: 20),
            Text(
              widget.task.description,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Steps:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: widget.task.steps.length,
                itemBuilder: (context, index) {
                  return StepItem(
                    step: widget.task.steps[index],
                    stepNumber: index + 1,
                    onCompleted: (isCompleted) {
                      setState(() {
                        widget.task.steps[index].isCompleted = isCompleted;
                        if (isCompleted && completedSteps == totalSteps) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TaskCompletionPage(task: widget.task),
                            ),
                          );
                        }
                      });
                    },
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _checkForMissedSteps,
              child: Text('Check for Missed Steps'),
            ),
          ],
        ),
      ),
    );
  }
}
