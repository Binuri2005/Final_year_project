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
  int currentStepIndex = -1; // -1 means no step is active initially
  bool isStarted = false; // Track if the task has started
  Set<int> skippedSteps = {}; // Track skipped steps

  int get completedSteps =>
      widget.task.steps.where((step) => step.isCompleted).length;
  int get totalSteps => widget.task.steps.length;

  void _startTask() {
    setState(() {
      isStarted = true;
      currentStepIndex = 0; // Activate the first step
    });
  }

  void _onStepCompleted(int index, bool isCompleted) {
    if (skippedSteps.contains(index)) {
      // If the step was skipped, show the skip/continue dialog
      _showSkipDialog(index);
      return;
    }

    setState(() {
      widget.task.steps[index].isCompleted = isCompleted;
      if (isCompleted && index == currentStepIndex) {
        // Move to the next step if the current step is completed
        if (currentStepIndex < widget.task.steps.length - 1) {
          currentStepIndex++;
        }
      }
    });

    // Check if all steps are completed
    if (completedSteps == totalSteps) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TaskCompletionPage(
            task: widget.task,
            completedSteps: completedSteps,
            totalSteps: totalSteps,
          ),
        ),
      );
    }
  }

  void _onSkipPressed() {
    if (currentStepIndex < widget.task.steps.length - 1) {
      setState(() {
        skippedSteps.add(currentStepIndex); // Mark the current step as skipped
        currentStepIndex++; // Move to the next step
      });
    }
  }

  void _showSkipDialog(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Incomplete Step'),
          content: Text(
              'Step ${index + 1} isn’t completed. Should we skip or continue?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  skippedSteps.add(index); // Skip the step
                  currentStepIndex++; // Move to the next step
                });
              },
              child: Text('Skip'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  currentStepIndex = index; // Go back to the skipped step
                });
              },
              child: Text('Continue'),
            ),
          ],
        );
      },
    );
  }

  void _onDonePressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskCompletionPage(
          task: widget.task,
          completedSteps: completedSteps,
          totalSteps: totalSteps,
        ),
      ),
    );
  }

  void _onStartOverPressed() {
    setState(() {
      currentStepIndex = -1; // Reset to no active step
      isStarted = false; // Reset start state
      skippedSteps.clear(); // Clear skipped steps
      for (var step in widget.task.steps) {
        step.isCompleted = false; // Reset all steps
      }
    });
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
            Center(
              child: ElevatedButton.icon(
                onPressed:
                    isStarted ? null : _startTask, // Disable after pressing
                icon: Icon(Icons.play_arrow),
                label: Text('Start'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isStarted ? Colors.grey : Colors.blue,
                ),
              ),
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
                    isCurrent: index == currentStepIndex,
                    isCompleted: widget.task.steps[index].isCompleted,
                    isSkipped: skippedSteps.contains(index),
                    onCompleted: (isCompleted) {
                      _onStepCompleted(index, isCompleted);
                    },
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _onSkipPressed,
                  child: Text('Skip'),
                ),
                ElevatedButton(
                  onPressed: _onStartOverPressed,
                  child: Text('Start Over'),
                ),
                ElevatedButton(
                  onPressed: _onDonePressed,
                  child: Text('Done'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
