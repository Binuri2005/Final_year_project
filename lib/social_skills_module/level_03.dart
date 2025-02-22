import 'package:flutter/material.dart';
import 'dart:math';
import 'datastructure_playgame.dart'; // Ensure this contains your image and scenario data

class Level3Game extends StatefulWidget {
  @override
  _Level3GameState createState() => _Level3GameState();
}

class _Level3GameState extends State<Level3Game> {
  late List<Map<String, String>> expressionData; // Holds the scenario data
  late List<Map<String, String>> shuffledImages; // Holds the shuffled images
  late List<Map<String, String>> shuffledScenarios; // Holds the shuffled scenarios
  Map<String, String?> droppedExpressions = {}; // Tracks dropped expressions
  int score = 0; // Player's score
  bool showResults = false; // Flag to show results
  int round = 1; // Current round
  List<Map<String, String>> roundHistory = []; // Store round history

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    // Shuffle and select 5 expressions for the current round
    expressionData = List.from(scenarioToImage)..shuffle(Random());
    expressionData = expressionData.take(5).toList();

    shuffledImages = List.from(expressionData)..shuffle(Random());
    shuffledScenarios = List.from(expressionData)..shuffle(Random());

    droppedExpressions.clear();
    showResults = false;
  }

  void _calculateScore() {
    // Check if all scenarios have been filled
    if (droppedExpressions.length < shuffledScenarios.length) {
      showIncompleteMessage();
      return;
    }

    int correctMatches = 0;
    for (var expression in expressionData) {
      if (droppedExpressions[expression["scenario"]!] == expression["image"]) {
        correctMatches++;
      }
    }
    setState(() {
      score += correctMatches; // Accumulate score over all rounds
      showResults = true;
    });

    // Save round history
    roundHistory.add({
      "round": round.toString(),
      "score": correctMatches.toString(),
      "data": expressionData.toString(),
    });

    if (round < 3) {
      showRoundDialog(correctMatches);
    } else {
      showFinalScoreDialog();
    }
  }

  void showIncompleteMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Incomplete"),
          content: Text("Please match all images before proceeding!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void showRoundDialog(int correctMatches) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Round $round Complete"),
          content: Text("You got $correctMatches out of 5 correct!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  round++;
                  _initializeGame();
                });
              },
              child: Text("Next Round"),
            ),
          ],
        );
      },
    );
  }

  void showFinalScoreDialog() {
    String encouragementMessage = "Great job! Keep it up!";
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Game Over"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Your final score is $score out of 15!"),
              SizedBox(height: 10),
              Text(encouragementMessage,
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _restartGame();
              },
              child: Text("Play Again"),
            ),
          ],
        );
      },
    );
  }

  void _restartGame() {
    setState(() {
      score = 0;
      round = 1;
      roundHistory.clear();
      _initializeGame();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Level 3: Match Images - Round $round")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Images (Top Section)
            Wrap(
 spacing: 8.0,
              children: shuffledImages.map((imageData) {
                return Draggable<String>(
                  data: imageData["image"]!,
                  child: Image.asset(imageData["image"]!, width: 100, height: 100),
                  feedback: Opacity(
                    opacity: 0.7,
                    child: Image.asset(imageData["image"]!, width: 100, height: 100),
                  ),
                  childWhenDragging: Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey[300],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            // Scenarios (Bottom Section)
            Expanded(
              child: ListView(
                children: shuffledScenarios.map((scenarioData) {
                  return DragTarget<String>(
                    onAccept: (data) {
                      setState(() {
                        droppedExpressions[scenarioData["scenario"]!] = data;
                      });
                    },
                    builder: (context, candidateData, rejectedData) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.circular(8),
                          color: droppedExpressions[scenarioData["scenario"]!] != null
                              ? Colors.green[100]
                              : Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(scenarioData["scenario"]!, style: TextStyle(fontSize: 16)),
                            SizedBox(height: 10),
                            if (droppedExpressions[scenarioData["scenario"]!] != null)
                              Text("Dropped: ${droppedExpressions[scenarioData["scenario"]!]!}"),
                          ],
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            ElevatedButton(
              onPressed: _calculateScore,
              child: Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}