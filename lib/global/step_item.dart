import 'package:app/dailylife_skills_module/datastructure_dailyskill.dart';
import 'package:flutter/material.dart';

class StepItem extends StatelessWidget {
  final TaskStep step;
  final int stepNumber;
  final bool isCurrent;
  final bool isCompleted;
  final bool isSkipped;
  final Function(bool) onCompleted;

  const StepItem({
    required this.step,
    required this.stepNumber,
    required this.isCurrent,
    required this.isCompleted,
    required this.isSkipped,
    required this.onCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: isSkipped
          ? Colors.grey[200] // Grey for skipped steps
          : (isCompleted
              ? Colors.blue[50]
              : (isCurrent
                  ? Colors.blue[50]
                  : Colors.grey[200])), // Completed or current steps are blue
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(step.imagePath),
        ),
        title: Text(
          'Step $stepNumber: ${step.instruction}',
          style: TextStyle(
            color: isSkipped
                ? Colors.grey // Grey for skipped steps
                : (isCompleted || isCurrent
                    ? Colors.blue
                    : Colors.grey), // Completed or current steps are blue
            fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        trailing: isCompleted
            ? Icon(Icons.check,
                color: Colors.green) // Show checkmark for completed steps
            : Checkbox(
                value: isCompleted,
                onChanged: (value) {
                  onCompleted(value ?? false);
                },
              ),
      ),
    );
  }
}
