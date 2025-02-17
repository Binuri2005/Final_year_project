import 'package:flutter/material.dart';
import 'package:app/social_skills_module/group_roleplay_datastructure.dart'; // Correct import

class GroupScenarioDetailPage extends StatelessWidget {
  final String scenario;

  const GroupScenarioDetailPage({required this.scenario, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Fetching the data for the specific group scenario
    var scenarioContent = groupScenarioDetails[scenario] ??
        {
          'description': 'Description not available',
          'steps': ['No steps available'],
          'image': '', // Use the image path from the data structure
          'participants': 'N/A',
          'roles': [],
          'dialogues': [],
        };

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Scenario Title
              Center(
                child: Text(
                  scenario,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 5),

              // Image (using the image path from the data structure)
              if (scenarioContent['image'] != '')
                Center(
                  child: Image.asset(
                    scenarioContent['image'], // Dynamically set image from data
                    height: 150,
                    width: 150,
                    fit: BoxFit.contain,
                  ),
                ),
              SizedBox(height: 10),

              // Description Box
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  scenarioContent['description'], // Dynamically set description
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.left, // Align text to the left
                ),
              ),
              SizedBox(height: 20),

              // "Roles" Heading
              Center(
                child: Text(
                  "Roles Involved",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),

              // Roles List
              Column(
                children: scenarioContent['roles']
                    .map<Widget>(
                      (role) => Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.orange[100],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          role,
                          style: TextStyle(fontSize: 16),
                          textAlign:
                              TextAlign.left, // Align role text to the left
                        ),
                      ),
                    )
                    .toList(),
              ),
              SizedBox(height: 20),

              // "Steps to Follow" Heading
              Center(
                child: Text(
                  "Steps to Follow",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),

              // Steps Boxes with Borders and Left-aligned Text
              Column(
                children: scenarioContent['steps']
                    .map<Widget>(
                      (step) => Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.blue, // Border color
                            width: 1, // Border width
                          ),
                        ),
                        child: Text(
                          step,
                          style: TextStyle(fontSize: 16),
                          textAlign:
                              TextAlign.left, // Align step text to the left
                        ),
                      ),
                    )
                    .toList(),
              ),
              SizedBox(height: 20),

              // "Participants Involved" Heading
              Center(
                child: Text(
                  "Participants Involved",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),

              // Participants
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  scenarioContent[
                      'participants'], // Dynamically set participants
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 20),

              // "Role Dialogues" Heading
              Center(
                child: Text(
                  "Role Dialogues",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),

              // Role dialogues for each role
              Column(
                children: scenarioContent['dialogues']
                    .map<Widget>(
                      (dialogue) => Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          dialogue,
                          style: TextStyle(fontSize: 16),
                          textAlign:
                              TextAlign.left, // Align dialogue text to the left
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
