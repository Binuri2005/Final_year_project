// lib/dailylife_skills_module/datastructure_dailyskill.dart

import 'package:flutter/material.dart';

class Task {
  final String id;
  final String title;
  final String description;
  final List<TaskStep> steps;

  Task({
    required this.title,
    required this.description,
    required this.steps,
    this.id = '', 
  });
}

class TaskStep {
  final String title;
  final String description;
  final String? imagePath; 
  bool isCompleted;

  TaskStep({
    required this.description,
    this.title = '',
    this.imagePath,
    this.isCompleted = false,
  });
}

// Example tasks
final List<Task> tasks = [
  Task(
    id: 'morning_routine',
    title: 'Morning Routine',
    description: 'Lets have a productive morning!',
    steps: [
      TaskStep(
        title: 'Start with brushing',
        description: 'Pick up your toothbrush',
      ),
      TaskStep(
        title: 'Prepare toothbrush',
        description: 'Apply toothpaste',
      ),
      TaskStep(
        title: 'Brush teeth',
        description: 'Brush for 2 minutes',
      ),
      TaskStep(
        title: 'Finish up',
        description: 'Rinse your mouth',
      ),
    ],
  ),
  Task(
    id: 'night_routine',
    title: 'Night Routine',
    description: 'Time to wind down and relax!',
    steps: [
      TaskStep(
        title: 'Get comfortable',
        description: 'Put on your pajamas',
        imagePath: 'assets/images/step1.jpg',
      ),
      TaskStep(
        title: 'Clean teeth',
        description: 'Brush your teeth',
        imagePath: 'assets/images/step2.jpg',
      ),
      TaskStep(
        title: 'Bedtime story',
        description: 'Read a bedtime story',
        imagePath: 'assets/images/step3.jpg',
      ),
    ],
  ),
  Task(
    id: 'meal_prep',
    title: 'Meal Prep',
    description: 'Prepare healthy food for the week!',
    steps: [
      TaskStep(
        title: 'Plan meals',
        description: 'Decide what you want to eat this week',
      ),
      TaskStep(
        title: 'Shopping list',
        description: 'Make a list of ingredients you need',
      ),
      TaskStep(
        title: 'Go shopping',
        description: 'Buy all the ingredients from your list',
      ),
      TaskStep(
        title: 'Prepare containers',
        description: 'Clean and prepare your food containers',
      ),
      TaskStep(
        title: 'Cook',
        description: 'Cook your meals according to plan',
      ),
    ],
  ),
  Task(
    id: 'personal_hygiene',
    title: 'Personal Hygiene',
    description: 'Keep yourself clean and fresh!',
    steps: [
      TaskStep(
        title: 'Wash hands',
        description: 'Wash your hands with soap for at least 20 seconds',
      ),
      TaskStep(
        title: 'Shower',
        description: 'Take a shower using soap and shampoo',
      ),
      TaskStep(
        title: 'Dental care',
        description: 'Brush teeth and use floss',
      ),
      TaskStep(
        title: 'Clean nails',
        description: 'Clean under your fingernails',
      ),
    ],
  ),
  Task(
    id: 'chores',
    title: 'Chores',
    description: 'Keep your space clean and organized!',
    steps: [
      TaskStep(
        title: 'Make bed',
        description: 'Straighten sheets and arrange pillows',
      ),
      TaskStep(
        title: 'Clear surfaces',
        description: 'Clear tables and counters of any items',
      ),
      TaskStep(
        title: 'Dust',
        description: 'Dust all surfaces with a clean cloth',
      ),
      TaskStep(
        title: 'Vacuum',
        description: 'Vacuum the floors in all rooms',
      ),
      TaskStep(
        title: 'Take out trash',
        description: 'Empty all trash bins and replace bags',
      ),
    ],
  ),
  Task(
    id: 'school_prep',
    title: 'School Prep',
    description: 'Get ready for a successful school day!',
    steps: [
      TaskStep(
        title: 'Check schedule',
        description: 'Review your classes for tomorrow',
      ),
      TaskStep(
        title: 'Pack books',
        description: 'Pack the books and materials you need',
      ),
      TaskStep(
        title: 'Complete homework',
        description: 'Make sure all assignments are finished',
      ),
      TaskStep(
        title: 'Prepare clothes',
        description: 'Choose and lay out clothes for tomorrow',
      ),
      TaskStep(
        title: 'Pack lunch',
        description: 'Prepare lunch or pack lunch money',
      ),
    ],
  ),
];
