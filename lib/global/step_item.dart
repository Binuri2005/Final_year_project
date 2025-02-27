// lib/widgets/step_item.dart

import 'package:flutter/material.dart';
import 'package:app/dailylife_skills_module/datastructure_dailyskill.dart';

class StepItem extends StatelessWidget {
  final TaskStep step; // Updated to TaskStep
  final int stepNumber;
  final Function(bool) onCompleted;

  const StepItem({
    required this.step,
    required this.stepNumber,
    required this.onCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(step.imagePath),
        ),
        title: Text('Step $stepNumber: ${step.instruction}'),
        trailing: Checkbox(
          value: step.isCompleted,
          onChanged: (value) {
            onCompleted(value ?? false);
          },
        ),
      ),
    );
  }
}
