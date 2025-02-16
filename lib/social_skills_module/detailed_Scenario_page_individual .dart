import 'package:flutter/material.dart';
import 'package:app/social_skills_module/individual_roleplay_datastructure.dart';

class IndividualScenarioDetailPage extends StatelessWidget {
  final String scenario;

  const IndividualScenarioDetailPage({required this.scenario, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Fetching the data for the specific scenario
    var scenarioContent = scenarioDetails[scenario] ??
        {
          'description': 'Description not available',
          'steps': ['No steps available'],
          'image': 'assets/images/default_image.png',
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

              // Image
              Center(
                child: Image.asset(
                  scenarioContent['image'], // Dynamically set image
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
            ],
          ),
        ),
      ),
    );
  }
}
