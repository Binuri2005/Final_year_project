import 'package:flutter/material.dart';

class ScenarioDetailPage extends StatelessWidget {
  final String scenario;

  const ScenarioDetailPage({required this.scenario, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> steps = [
      "1️Smile and wave.",
      "2️ Say, \"Hi [Friend's Name]! How are you?\"",
      "3️ Listen to their response and reply warmly."
    ];

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
        // Prevents overflow
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
                  'assets/images/greeting_A_friend.png',
                  height: 150,
                  width: 150,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 10),

              // Description Box
              Container(
                width: double.infinity,
                constraints: BoxConstraints(minHeight: 150),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  "Learn how to greet a friend jsjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjslsssssssssss",
                  style: TextStyle(fontSize: 16),
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

              // Steps Boxes
              Column(
                children: steps
                    .map(
                      (step) => Center(
                        child: Container(
                          width: 300,
                          padding: EdgeInsets.all(15),
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            step,
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
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
