import 'package:flutter/material.dart';
import 'dart:math';
import 'datastructure_playgame.dart';

class Level2Game extends StatefulWidget {
  @override
  _Level2GameState createState() => _Level2GameState();
}

class _Level2GameState extends State<Level2Game> {
  late List<Map<String, String>> scenarioData;
  late List<String> shuffledTerms;
  Map<String, String?> droppedTerms = {};
  int score = 0;
  bool showResults = false;
  int round = 1;

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    scenarioData = List.from(scenarioToTerm)..shuffle(Random());
    final uniqueTerms = <String>{};
    scenarioData = scenarioData
        .where((scenario) {
          if (!uniqueTerms.contains(scenario['term'])) {
            uniqueTerms.add(scenario['term']!);
            return true;
          }
          return false;
        })
        .take(5)
        .toList();

    shuffledTerms = scenarioData.map((e) => e['term']!).toList()
      ..shuffle(Random());
    droppedTerms.clear();
    showResults = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Level 2: Match Scenarios - Round $round")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Terms (Top Section)
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: shuffledTerms
                  .where((term) => !droppedTerms.containsValue(term))
                  .map((term) => Draggable<String>(
                        data: term,
                        feedback: Material(
                          child: _buildTermBox(term, isDragging: true),
                        ),
                        childWhenDragging: Container(),
                        child: _buildTermBox(term),
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
                          if (droppedTerms[scenario] != null)
                            Draggable<String>(
                              data: droppedTerms[scenario]!,
                              feedback: Material(
                                child: _buildTermBox(droppedTerms[scenario]!,
                                    isDragging: true),
                              ),
                              childWhenDragging: Container(),
                              child: _buildTermBox(droppedTerms[scenario]!),
                            ),
                        ],
                      ),
                    ),
                    onAccept: (term) {
                      setState(() {
                        droppedTerms.removeWhere((key, value) => value == term);
                        droppedTerms[scenario] = term;
                      });
                    },
                  );
                }).toList(),
              ),
            ),

            FloatingActionButton(
              onPressed: _calculateScore,
              child: Icon(Icons.check),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTermBox(String term, {bool isDragging = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isDragging ? Colors.blue[300] : Colors.blue,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        term,
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }

  void _calculateScore() {
    int correctMatches = 0;
    for (var scenario in scenarioData) {
      if (droppedTerms[scenario['scenario']!] == scenario['term']) {
        correctMatches++;
      }
    }
    setState(() {
      score += correctMatches;
      showResults = true;
    });
    _showScoreDialog(correctMatches);
  }

  void _showScoreDialog(int correctMatches) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Round $round Complete"),
        content: Text("You got $correctMatches out of 5 correct!"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (round == 1) {
                setState(() {
                  round = 2;
                  _initializeGame();
                });
              } else {
                _restartGame();
              }
            },
            child: Text(round == 1 ? "Next Round" : "Play Again"),
          ),
        ],
      ),
    );
  }

  void _restartGame() {
    setState(() {
      score = 0;
      round = 1;
      _initializeGame();
    });
  }
}
