import 'package:flutter/material.dart';

class ScenarioDetailPage extends StatelessWidget {
  final String scenario;

  const ScenarioDetailPage({required this.scenario, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(scenario),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Text(
          _getScenarioContent(scenario), //  dynamic content
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  // Function to return content based on scenario
  String _getScenarioContent(String scenario) {
    switch (scenario) {
      case '1. Greeting a Friend':
        return "When greeting a friend, you can say 'Hi' or 'Hello' with a smile!";
      case '2. Introducing Yourself':
        return "When introducing yourself, say 'Hi, my name is...'.";
      case '3. Asking for Help':
        return "You can ask for help by saying 'Excuse me, can you help me with...'.";
      case '4. Ordering Food':
        return "When ordering food, say 'I'd like to have a...'.";
      case '5. Inviting Someone to Play':
        return "Say 'Would you like to play with me?' with a friendly tone.";
      case '6. Apologizing':
        return "Say 'I'm sorry for...' and express it sincerely.";
      case '7. Giving a Compliment':
        return "Give a compliment like 'You did a great job!' with enthusiasm.";
      case '8. Saying Goodbye':
        return "Say 'Goodbye! See you soon!' with a smile.";
      case '9. Expressing Feelings':
        return "You can say 'I feel happy/sad/excited today' to express emotions.";
      case '10. Thanking Someone':
        return "Say 'Thank you so much!' with appreciation.";
      default:
        return "Scenario not found.";
    }
  }
}
