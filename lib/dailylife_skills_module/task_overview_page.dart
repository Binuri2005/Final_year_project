// lib/screens/task_page.dart

import 'package:app/dailylife_skills_module/datastructure_dailyskill.dart';
import 'package:app/global/step_item.dart';
import 'package:flutter/material.dart';


class TaskPage extends StatefulWidget {
  final Task task;

  const TaskPage({required this.task});

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
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
                    step: widget.task.steps[index], // Updated to TaskStep
                    stepNumber: index + 1,
                    onCompleted: (isCompleted) {
                      setState(() {
                        widget.task.steps[index].isCompleted = isCompleted;
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
