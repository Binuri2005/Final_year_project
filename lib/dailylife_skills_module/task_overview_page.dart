/*import 'package:app/dailylife_skills_module/datastructure_dailyskill.dart';
import 'package:flutter/material.dart';

class TaskOverviewPage extends StatelessWidget {
  final Task task;

  const TaskOverviewPage({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task.title),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category Icon and Description
              _buildCategoryHeader(context),

              SizedBox(height: 24),

              // Progress Card
              _buildProgressCard(),

              SizedBox(height: 24),

              // Steps Preview
              Text(
                'Steps Overview:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),

              SizedBox(height: 16),

              // List of Steps
              _buildStepsList(),

              SizedBox(height: 24),

              // Start Button
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskOverviewPage(task: task),
                      ),
                    );
                  },
                  icon: Icon(Icons.play_arrow),
                  label: Text('Start Routine'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                ),
              ),

              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryHeader(BuildContext context) {
    // Get the appropriate icon based on the task title
    IconData categoryIcon = _getCategoryIcon();

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    categoryIcon,
                    size: 36,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              task.description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressCard() {
    int completedSteps = task.steps.where((step) => step.isCompleted).length;
    int totalSteps = task.steps.length;
    double progress = totalSteps > 0 ? completedSteps / totalSteps : 0.0;

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Progress',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$completedSteps of $totalSteps steps completed',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepsList() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: task.steps.length,
          separatorBuilder: (context, index) => Divider(),
          itemBuilder: (context, index) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.steps[index]
                            .title, // Use instruction instead of title
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        task.steps[index]
                            .description, // Use imagePath instead of description
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Checkbox(
                  value: task.steps[index].isCompleted,
                  onChanged: null, // Read-only in overview mode
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  IconData _getCategoryIcon() {
    // Return appropriate icon based on task title
    String title = task.title.toLowerCase();

    if (title.contains('morning')) {
      return Icons.wb_sunny;
    } else if (title.contains('night')) {
      return Icons.nightlight_round;
    } else if (title.contains('meal')) {
      return Icons.restaurant;
    } else if (title.contains('hygiene')) {
      return Icons.soap;
    } else if (title.contains('chores')) {
      return Icons.cleaning_services;
    } else if (title.contains('school')) {
      return Icons.school;
    } else {
      return Icons.list_alt; // Default icon
    }
  }
}

/*import 'package:app/dailylife_skills_module/datastructure_dailyskill.dart';
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

*/*/