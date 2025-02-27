// lib/data/datastructure_dailyskill.dart

import 'package:flutter/material.dart';

class Task {
  final String title;
  final String description;
  final List<TaskStep> steps; // Renamed to TaskStep

  Task({
    required this.title,
    required this.description,
    required this.steps,
  });
}

class TaskStep {
  // Renamed to TaskStep
  final String instruction;
  final String imagePath;
  bool isCompleted;

  TaskStep({
    required this.instruction,
    required this.imagePath,
    this.isCompleted = false,
  });
}

// Example tasks
final List<Task> tasks = [
  Task(
    title: 'Morning Routine',
    description: 'Let’s have a productive morning!',
    steps: [
      TaskStep(
        // Updated to TaskStep
        instruction: 'Pick up your toothbrush',
        imagePath: 'assets/images/step1.jpg',
      ),
      TaskStep(
        // Updated to TaskStep
        instruction: 'Apply toothpaste',
        imagePath: 'assets/images/step2.jpg',
      ),
      TaskStep(
        // Updated to TaskStep
        instruction: 'Brush for 2 minutes',
        imagePath: 'assets/images/step3.jpg',
      ),
      TaskStep(
        // Updated to TaskStep
        instruction: 'Rinse your mouth',
        imagePath: 'assets/images/step4.jpg',
      ),
    ],
  ),
  Task(
    title: 'Night Routine',
    description: 'Time to wind down and relax!',
    steps: [
      TaskStep(
        // Updated to TaskStep
        instruction: 'Put on your pajamas',
        imagePath: 'assets/images/step1.jpg',
      ),
      TaskStep(
        // Updated to TaskStep
        instruction: 'Brush your teeth',
        imagePath: 'assets/images/step2.jpg',
      ),
      TaskStep(
        // Updated to TaskStep
        instruction: 'Read a bedtime story',
        imagePath: 'assets/images/step3.jpg',
      ),
    ],
  ),
  // Add more tasks as needed
];
