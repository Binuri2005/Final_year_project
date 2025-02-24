import 'package:flutter/material.dart';



class DailySkillsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Skills',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TaskListScreen(),
    );
  }
}

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = [
    Task(name: "Brushing Teeth", steps: [
      "Pick up the toothbrush",
      "Apply toothpaste",
      "Brush all teeth",
      "Rinse mouth",
    ]),
    Task(name: "Getting Dressed", steps: [
      "Pick clothes",
      "Wear top",
      "Wear bottom",
      "Put on shoes",
    ]),
  ];

  void _navigateToTask(Task task) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TaskDetailScreen(task: task)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Daily Skills")),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(tasks[index].name),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => _navigateToTask(tasks[index]),
          );
        },
      ),
    );
  }
}

class TaskDetailScreen extends StatefulWidget {
  final Task task;

  TaskDetailScreen({required this.task});

  @override
  _TaskDetailScreenState createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  late List<bool> stepCompletion;

  @override
  void initState() {
    super.initState();
    stepCompletion = List.generate(widget.task.steps.length, (index) => false);
  }

  void _toggleStep(int index) {
    setState(() {
      stepCompletion[index] = !stepCompletion[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.task.name)),
      body: ListView.builder(
        itemCount: widget.task.steps.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            title: Text(widget.task.steps[index]),
            value: stepCompletion[index],
            onChanged: (bool? value) {
              _toggleStep(index);
            },
          );
        },
      ),
    );
  }
}

class Task {
  final String name;
  final List<String> steps;

  Task({required this.name, required this.steps});
}
