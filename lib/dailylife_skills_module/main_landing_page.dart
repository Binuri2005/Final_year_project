// lib/screens/daily_life_skills.dart

import 'package:flutter/material.dart';
import 'package:app/dailylife_skills_module/datastructure_dailyskill.dart';
import 'package:app/global/category_button.dart';

class DailyLifeSkillsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to the previous screen
            Navigator.pop(context);
          },
        ),
        title: Text('Daily Life Skills'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 columns
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 1.0, // Square buttons
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return CategoryButton(
              icon: categories[index].icon,
              label: categories[index].label,
              onTap: categories[index].onTap,
            );
          },
        ),
      ),
    );
  }
}
