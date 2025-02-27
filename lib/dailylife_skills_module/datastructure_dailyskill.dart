// lib/dailylife_skills_module/datastructure_dailyskill.dart

import 'package:flutter/material.dart';

class Category {
  final IconData icon;
  final String label;
  final VoidCallback onTap; // Use VoidCallback instead of Function

  Category({
    required this.icon,
    required this.label,
    required this.onTap,
  });
}

// List of categories for the Daily Life Skills module
final List<Category> categories = [
  Category(
    icon: Icons.wb_sunny,
    label: 'Morning Routine',
    onTap: () {
      // Navigate to Morning Routine screen
      print('Morning Routine tapped');
    },
  ),
  Category(
    icon: Icons.nightlight_round,
    label: 'Night Routine',
    onTap: () {
      // Navigate to Night Routine screen
      print('Night Routine tapped');
    },
  ),
  Category(
    icon: Icons.restaurant,
    label: 'Meal Prep',
    onTap: () {
      // Navigate to Meal Prep screen
      print('Meal Prep tapped');
    },
  ),
  Category(
    icon: Icons.soap,
    label: 'Personal Hygiene',
    onTap: () {
      // Navigate to Personal Hygiene screen
      print('Personal Hygiene tapped');
    },
  ),
  Category(
    icon: Icons.cleaning_services,
    label: 'Chores',
    onTap: () {
      // Navigate to Chores screen
      print('Chores tapped');
    },
  ),
  Category(
    icon: Icons.school,
    label: 'School Prep',
    onTap: () {
      // Navigate to School Prep screen
      print('School Prep tapped');
    },
  ),
];
