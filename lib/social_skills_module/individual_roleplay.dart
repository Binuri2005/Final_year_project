import 'package:app/social_skills_module/detailed_Scenario_page_individual%20.dart';
import 'package:flutter/material.dart';

class IndividualRolePlayPage extends StatelessWidget {
  // Define a list of scenarios for each box
  final List<String> scenarios = [
    'Greeting a Friend',
    'Introducing Yourself',
    'Asking for Help',
    'Ordering Food',
    'Inviting Someone to Play',
    'Apologizing',
    'Giving a Compliment',
    'Saying Goodbye',
    'Expressing Feelings',
    'Thanking Someone',
  ];

  IndividualRolePlayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/light_background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              const Center(
                child: Text(
                  'Select Scenario',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),

              // Generate scenario boxes dynamically
              for (String scenario in scenarios)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Center(
                    child: _buildBox(scenario, context),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildBox(String text, BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => IndividualScenarioDetailPage(scenario: text),
        ),
      );
    },
    child: Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 55,
          width: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 9, 83, 144).withOpacity(0.7),
                spreadRadius: 4,
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
        ),
        Container(
          height: 50,
          width: 240,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.white, width: 1),
          ),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    ),
  );
}
