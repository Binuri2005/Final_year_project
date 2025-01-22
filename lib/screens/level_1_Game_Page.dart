import 'package:flutter/material.dart';

// Main widget for the game page
class Level1GamePage extends StatefulWidget {
  @override
  _Level1GamePageState createState() => _Level1GamePageState();
}

class _Level1GamePageState extends State<Level1GamePage> {
  // List of expressions and their emojis
  final List<Map<String, String>> expressions = [
    {"term": "Happy", "emoji": "😊"},
    {"term": "Sad", "emoji": "😢"},
    {"term": "Angry", "emoji": "😠"},
    {"term": "Surprised", "emoji": "😲"},
    {"term": "Confused", "emoji": "😕"},
    {"term": "Love", "emoji": "😍"},
  ];

  // Map to track which emoji has been dropped onto each expression
  Map<String, String> droppedExpressions = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Match the Emoji!")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // shows Draggable Emojis
            Padding(
              padding: const EdgeInsets.all(
                  16.0), // padding to add tht box around the emoji set
              child: Column(
                children: [
                  // First Row of Emojis (3 emojis)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: expressions.sublist(0, 3).map((expression) {
                      return Draggable<String>(
                        data: expression['emoji'],
                        child: EmojiBox(emoji: expression['emoji']!),
                        feedback: EmojiBox(emoji: expression['emoji']!),
                        childWhenDragging:
                            EmojiBox(emoji: "❓"), // Placeholder during drag
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  // Second Row of Emojis (3 emojis)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: expressions.sublist(3, 6).map((expression) {
                      return Draggable<String>(
                        data: expression['emoji'],
                        child: EmojiBox(emoji: expression['emoji']!),
                        feedback: EmojiBox(emoji: expression['emoji']!),
                        childWhenDragging: EmojiBox(emoji: "❓"),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Drop targets for matching expressions to emojis
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: expressions.map((expression) {
                  return DragTarget<String>(
                    onAccept: (data) {
                      setState(() {
                        // Store the emoji dropped on this expression
                        droppedExpressions[expression['term']!] = data;
                      });
                    },
                    builder: (context, candidateData, rejectedData) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding: EdgeInsets.all(8),
                        height: 40, // Smaller height
                        width: 100, // Smaller width
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        child: Center(
                          child: Text(
                            // Display the dropped emoji or the term
                            droppedExpressions[expression['term']!] ??
                                expression['term']!,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20),
            // Button to check answers
            ElevatedButton(
              onPressed: () {
                checkAnswers(); // Call the answer checking function
              },
              child: Text("Check Answers"),
            ),
          ],
        ),
      ),
    );
  }

  // Method to check if all the answers are correct
  void checkAnswers() {
    bool isCorrect = true; // Assume answers are correct
    expressions.forEach((expression) {
      if (droppedExpressions[expression['term']!] != expression['emoji']) {
        isCorrect = false; // Set to false if any match is incorrect
      }
    });

    String message = isCorrect
        ? "Congratulations! All matches are correct!"
        : "Oops! Try again!";

    // Show a dialog with the result

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Result"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  droppedExpressions
                      .clear(); // Clear all the dropped expressions to start over
                });
              },
              child: Text("Try Again"),
            ),
          ],
        );
      },
    );
  }
}

// Widget for displaying emojis inside a box
class EmojiBox extends StatelessWidget {
  final String emoji; // Emoji to display

  EmojiBox({required this.emoji});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.yellow[100],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Center(
        child: Text(
          emoji,
          style: TextStyle(fontSize: 36),
        ),
      ),
    );
  }
}
