import 'package:flutter/material.dart';
import 'dart:math';
import 'datastructure_playgame.dart'; // Import the data structure

class Level3Game extends StatefulWidget {
  @override
  _Level3GameState createState() => _Level3GameState();
}

class _Level3GameState extends State<Level3Game> {
  late List<Map<String, String>> scenarioData;
  late List<String> shuffledImages;
  Map<String, String?> droppedImages = {};
  int score = 0;
  bool showResults = false;
  int round = 1;
  bool _isShaking = false; // For shake animation
  List<Map<String, String>> roundHistory = [];

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    // Ensure no repeats in the next round
    scenarioData = List.from(scenarioToImage)..shuffle(Random());
    final uniqueImages = <String>{};
    scenarioData = scenarioData
        .where((scenario) {
          if (!uniqueImages.contains(scenario['image'])) {
            uniqueImages.add(scenario['image']!);
            return true;
          }
          return false;
        })
        .take(5)
        .toList();

    shuffledImages = scenarioData.map((e) => e['image']!).toList()
      ..shuffle(Random());

    droppedImages.clear();
    showResults = false;
  }

  void checkMatch(String scenario, String image) {
    setState(() {
      droppedImages[scenario] = image;
    });
  }

  void _calculateScore() {
    // Check if all scenarios are filled
    if (droppedImages.length < scenarioData.length) {
      showIncompleteMessage();
      return;
    }

    int correctMatches = 0;
    for (var scenario in scenarioData) {
      if (droppedImages[scenario['scenario']!] == scenario['image']) {
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
      "data": scenarioData.toString(),
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
          content: Text("Please match all scenarios before proceeding!"),
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

  void _viewRoundHistory(int roundNumber) {
    if (roundNumber > round) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Complete Round ${roundNumber - 1} first!")),
      );
      return;
    }

    final roundData = roundHistory[roundNumber - 1];
    final roundScore = roundData["score"];
    final roundScenarios = scenarioData;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Round $roundNumber History"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Score: $roundScore/5",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              ...roundScenarios.map((scenario) {
                final scenarioText = scenario["scenario"]!;
                final image = scenario["image"]!;
                final userImage = droppedImages[scenarioText];
                final isCorrect = userImage == image;

                return Container(
                  margin: EdgeInsets.only(bottom: 8),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: isCorrect ? Colors.green : Colors.red),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Text(scenarioText, style: TextStyle(fontSize: 14)),
                      SizedBox(width: 10),
                      if (userImage != null)
                        Image.asset(
                          userImage,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      SizedBox(width: 10),
                      Icon(isCorrect ? Icons.check : Icons.close,
                          color: isCorrect ? Colors.green : Colors.red),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  void _showLockedRoundMessage(int roundNumber) {
    final snackBar = SnackBar(
      content:
          Text("Play round ${roundNumber - 1} to access Round $roundNumber"),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    // Shake animation
    setState(() {
      _isShaking = true;
    });

    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _isShaking = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Level 3: Match Images to Scenarios - Round $round")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Images (Top Section)
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: shuffledImages
                  .where((image) => !droppedImages.containsValue(image))
                  .map((image) => Draggable<String>(
                        data: image,
                        feedback: Material(
                          child: _buildImageBox(image, isDragging: true),
                        ),
                        childWhenDragging: Container(),
                        child: _buildImageBox(image),
                      ))
                  .toList(),
            ),

            SizedBox(height: 16),

            // Scenarios (Bottom Section)
            Expanded(
              child: ListView(
                children: scenarioData.map((scenarioItem) {
                  final scenario = scenarioItem['scenario']!;
                  return DragTarget<String>(
                    builder: (context, candidateData, rejectedData) =>
                        Container(
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(scenario, textAlign: TextAlign.center),
                          SizedBox(height: 8),
                          if (droppedImages[scenario] != null)
                            Draggable<String>(
                              data: droppedImages[scenario]!,
                              feedback: Material(
                                child: _buildImageBox(droppedImages[scenario]!,
                                    isDragging: true),
                              ),
                              childWhenDragging: Container(),
                              child: _buildImageBox(droppedImages[scenario]!),
                            ),
                        ],
                      ),
                    ),
                    onAccept: (image) {
                      setState(() {
                        droppedImages
                            .removeWhere((key, value) => value == image);
                        droppedImages[scenario] = image;
                      });
                    },
                  );
                }).toList(),
              ),
            ),

            // Round Navigation
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [1, 2, 3].map((roundNumber) {
                bool isLocked = roundNumber > round;
                return GestureDetector(
                  onTap: () {
                    if (isLocked) {
                      _showLockedRoundMessage(roundNumber);
                    } else {
                      _viewRoundHistory(roundNumber);
                    }
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isLocked
                          ? Colors.grey[300]
                          : (roundNumber == round
                              ? Colors.blue
                              : Colors.grey[300]),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    transform: _isShaking && isLocked
                        ? Matrix4.rotationZ(0.1 *
                            sin(DateTime.now().millisecondsSinceEpoch / 100))
                        : Matrix4.identity(),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Text(
                          "Round $roundNumber",
                          style: TextStyle(
                            fontSize: 16,
                            color: isLocked
                                ? Colors.black.withOpacity(0.5)
                                : (roundNumber == round
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                        if (isLocked)
                          Positioned(
                            right: 8,
                            child: Icon(Icons.lock,
                                color: Colors.black.withOpacity(0.5)),
                          ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _calculateScore,
        child: Icon(Icons.check),
      ),
    );
  }

  Widget _buildImageBox(String image, {bool isDragging = false}) {
    return Container(
      width: 130,
      height: 130,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Image.asset(
        image,
        fit: BoxFit.cover,
      ),
    );
  }
}
