/*import 'package:flutter/material.dart';
import 'dart:math';
import 'datastructure_playgame.dart'; // Import the data structure

class Level1Game extends StatefulWidget {
  @override
  _Level1GameState createState() => _Level1GameState();
}

class _Level1GameState extends State<Level1Game> {
  late List<Map<String, String>> expressionData;
  late List<Map<String, String>> shuffledTerms;
  late List<Map<String, String>> shuffledImages;
  Map<String, String?> droppedExpressions = {};
  int score = 0;
  bool showResults = false;
  int round = 1;

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    expressionData = List.from(expressionDataList)..shuffle(Random());
    expressionData = expressionData.take(5).toList();

    shuffledTerms = List.from(expressionData)..shuffle(Random());
    shuffledImages = List.from(expressionData)..shuffle(Random());

    droppedExpressions.clear();
    showResults = false;
  }

  void checkMatch(String imagePath, String term) {
    setState(() {
      droppedExpressions[term] = imagePath;
    });
  }

  void calculateScore() {
    int correctMatches = 0;
    for (var expression in expressionData) {
      if (droppedExpressions[expression["term"]!] == expression["image"]) {
        correctMatches++;
      }
    }
    setState(() {
      score += correctMatches; // Accumulate score over two rounds
      showResults = true;
    });

    if (round == 1) {
      showRoundDialog(correctMatches);
    } else {
      showFinalScoreDialog();
    }
  }

  void showRoundDialog(int correctMatches) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Round 1 Complete"),
          content: Text("You got $correctMatches out of 5 correct!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  round = 2;
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
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Game Over"),
          content: Text("Your final score is $score out of 10!"),
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
      _initializeGame();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Level 1: Match Expressions - Round $round")),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              // Images section
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 16,
                runSpacing: 16,
                children: shuffledImages
                    .where((item) =>
                        !droppedExpressions.values.contains(item["image"]))
                    .map((item) {
                  return Draggable<String>(
                    data: item["image"]!,
                    feedback: Material(
                      color: Colors.transparent,
                      child: Image.asset(
                        item["image"]!,
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    childWhenDragging: Opacity(
                      opacity: 0.5,
                      child: Image.asset(
                        item["image"]!,
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Image.asset(
                      item["image"]!,
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  );
                }).toList(),
              ),

              SizedBox(height: 24),

              // Terms section
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 16,
                runSpacing: 16,
                children: shuffledTerms.map((expression) {
                  final term = expression["term"]!;
                  return DragTarget<String>(
                    builder: (context, candidateData, rejectedData) {
                      return Container(
                        width: 180,
                        height: 170,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: showResults
                                ? (droppedExpressions[term] ==
                                        expression["image"]
                                    ? Colors.green
                                    : (droppedExpressions[term] != null
                                        ? Colors.red
                                        : Colors.blue))
                                : Colors.blue,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(term,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black)),
                            if (droppedExpressions[term] != null)
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    droppedExpressions[term] = null;
                                  });
                                },
                                child: Draggable<String>(
                                  data: droppedExpressions[term]!,
                                  feedback: Material(
                                    color: Colors.transparent,
                                    child: Image.asset(
                                      droppedExpressions[term]!,
                                      width: 120,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  childWhenDragging: Container(),
                                  child: Image.asset(
                                    droppedExpressions[term]!,
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                    onAccept: (imagePath) {
                      setState(() {
                        droppedExpressions
                            .removeWhere((key, value) => value == imagePath);
                        droppedExpressions[term] = imagePath;
                      });
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: calculateScore,
        child: Icon(Icons.check),
      ),
    );
  }
}*/
import 'dart:math';

import 'package:app/models/social_skills/social_skill_quiz.model.dart';
import 'package:app/viewmodels/social_skills/play_game/social_skill_play_game.viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Level1Game extends StatefulWidget {
  final List<SocialQuizRound> rounds;
  final String levelID;

  const Level1Game({super.key, required this.rounds, required this.levelID});
  @override
  _Level1GameState createState() => _Level1GameState();
}

class _Level1GameState extends State<Level1Game> {
  // late List<Map<String, String>> expressionData;
  // late List<Map<String, String>> shuffledTerms;
  // late List<Map<String, String>> shuffledImages;
  // Map<String, String?> droppedExpressions = {};
  int score = 0;
  bool showResults = false;

  bool _isShaking = false; // For shake animation
  List<Map<String, String>> roundHistory = []; // Store round history

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    // expressionData = List.from(expressionDataList)..shuffle(Random());
    // expressionData = expressionData.take(5).toList();
    //
    // shuffledTerms = List.from(expressionData)..shuffle(Random());
    // shuffledImages = List.from(expressionData)..shuffle(Random());
    //
    // droppedExpressions.clear();
    context.read<SocialSkillPlayGameViewModel>().setActiveRoundId(
        levelID: widget.levelID, roundID: widget.rounds.first.id);
    showResults = false;
  }

  void checkMatch(String imagePath, String term) {
    setState(() {
      // droppedExpressions[term] = imagePath;
    });
  }

  void calculateScore() {
    // Check if all terms have been filled
    // if (droppedExpressions.length < shuffledTerms.length) {
    //   showIncompleteMessage();
    //   return;
    // }
    //
    // int correctMatches = 0;
    // for (var expression in expressionData) {
    //   if (droppedExpressions[expression["term"]!] == expression["image"]) {
    //     correctMatches++;
    //   }
    // }
    // setState(() {
    //   score += correctMatches; // Accumulate score over all rounds
    //   showResults = true;
    // });
    //
    // Save round history
    // roundHistory.add({
    //   "round": round.toString(),
    //   "score": correctMatches.toString(),
    //   "data": expressionData.toString(),
    // });
    //
    // if (round < 3) {
    //   showRoundDialog(correctMatches);
    // } else {
    //   showFinalScoreDialog();
    // }
  }

  void showIncompleteMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Incomplete"),
          content: Text("Please match all terms before proceeding!"),
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
            // title: Text("Round $sna Complete"),
            // content: Text("You got $correctMatches out of 5 correct!"),
            // actions: [
            //   TextButton(
            //     onPressed: () {
            //       Navigator.pop(context);
            //       setState(() {
            //         round++;
            //         _initializeGame();
            //       });
            //     },
            //     child: Text("Next Round"),
            //   ),
            // ],
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
      // round = 1;
      roundHistory.clear();
      _initializeGame();
    });
  }

  void _viewRoundHistory(int roundNumber) {
    // if (roundNumber > round) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text("Complete Round ${roundNumber - 1} first!")),
    //   );
    //   return;
    // }
    //
    // final roundData = roundHistory[roundNumber - 1];
    // final roundScore = roundData["score"];
    // final roundExpressions =
    //     expressionDataList.take(5).toList(); // Assuming 5 expressions per round
    //
    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     return AlertDialog(
    //       title: Text("Round $roundNumber History"),
    //       content: Column(
    //         mainAxisSize: MainAxisSize.min,
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Text("Score: $roundScore/5",
    //               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    //           SizedBox(height: 10),
    //           ...roundExpressions.map((expression) {
    //             final term = expression["term"]!;
    //             final image = expression["image"]!;
    //             // final userImage = droppedExpressions[term];
    //             // final isCorrect = userImage == image;
    //
    //             return Container(
    //               margin: EdgeInsets.only(bottom: 8),
    //               padding: EdgeInsets.all(8),
    //               decoration: BoxDecoration(
    //                 // border: Border.all(
    //                 //     color: isCorrect ? Colors.green : Colors.red),
    //                 borderRadius: BorderRadius.circular(8),
    //               ),
    //               child: Row(
    //                 children: [
    //                   Text(term, style: TextStyle(fontSize: 14)),
    //                   SizedBox(width: 10),
    //                   // if (userImage != null)
    //                   //   Image.asset(userImage,
    //                   //       width: 50, height: 50, fit: BoxFit.cover),
    //                   SizedBox(width: 10),
    //                   // Icon(isCorrect ? Icons.check : Icons.close,
    //                   //     color: isCorrect ? Colors.green : Colors.red),
    //                 ],
    //               ),
    //             );
    //           }).toList(),
    //         ],
    //       ),
    //       actions: [
    //         TextButton(
    //           onPressed: () {
    //             Navigator.pop(context);
    //           },
    //           child: Text("Close"),
    //         ),
    //       ],
    //     );
    //   },
    // );
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
    return Consumer<SocialSkillPlayGameViewModel>(
        builder: (context, snapshot, _) {
      return Scaffold(
        appBar: AppBar(
            title: Text(
                "Level 1: Match Expressions - Round ${snapshot.activeRoundId}")),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                // Images section
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 16,
                  runSpacing: 16,
                  children: widget.rounds.first.mixedQuestions.map((item) {
                    return Draggable<QuizQuestion>(
                      data: item,
                      // disable dragging if the item is already dropped
                      feedback: Material(
                        color: Colors.transparent,
                        child: Image.network(
                          item.questionImageURL,
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      childWhenDragging: Opacity(
                        opacity: 0.5,
                        child: Image.network(
                          item.questionImageURL,
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Image.network(
                        item.questionImageURL,
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    );
                  }).toList(),
                ),

                SizedBox(height: 24),

                // Terms section
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 16,
                  runSpacing: 16,
                  children: widget.rounds.first.mixedAnswers.map((expression) {
                    return DragTarget<QuizQuestion>(
                      builder: (context, candidateData, rejectedData) {
                        return Container(
                          width: 180,
                          height: 170,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue),
                            // border: Border.all(
                            //   color: showResults
                            //       ? (droppedExpressions[term] ==
                            //               expression["image"]
                            //           ? Colors.green
                            //           : (droppedExpressions[term] != null
                            //               ? Colors.red
                            //               : Colors.blue))
                            //       : Colors.blue,
                            // ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(expression.answer,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black)),

                              if (expression.draggedQuestionID != null)
                                GestureDetector(
                                  onTap: () {
                                    // snapshot.removeQuestionFromAnAnswer(
                                    //     questionID: expression.draggedQuestionID);
                                  },
                                  child: Draggable<QuizQuestion>(
                                    data: expression.draggedQuestionID,
                                    feedback: Material(
                                      color: Colors.transparent,
                                      child: Image.network(
                                        expression.draggedQuestionID!
                                            .questionImageURL,
                                        width: 120,
                                        height: 120,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    childWhenDragging: Container(),
                                    child: Image.network(
                                      expression
                                          .draggedQuestionID!.questionImageURL,
                                      width: 120,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              // if (droppedExpressions[term] != null)
                              //   GestureDetector(
                              //     onTap: () {
                              //       setState(() {
                              //         droppedExpressions[term] = null;
                              //       });
                              //     },
                              //     child: Draggable<String>(
                              //       data: droppedExpressions[term]!,
                              //       feedback: Material(
                              //         color: Colors.transparent,
                              //         child: Image.asset(
                              //           droppedExpressions[term]!,
                              //           width: 120,
                              //           height: 120,
                              //           fit: BoxFit.cover,
                              //         ),
                              //       ),
                              //       childWhenDragging: Container(),
                              //       child: Image.asset(
                              //         droppedExpressions[term]!,
                              //         width: 120,
                              //         height: 120,
                              //         fit: BoxFit.cover,
                              //       ),
                              //     ),
                              //   ),
                            ],
                          ),
                        );
                      },
                      onAcceptWithDetails: (d) {
                        snapshot.injectQuestionToAnAnswer(
                            question: d.data, answer: expression);

                        // setState(() {
                        //   droppedExpressions
                        //       .removeWhere((key, value) => value == imagePath);
                        //   droppedExpressions[term] = imagePath;
                        // });
                      },
                    );
                  }).toList(),
                ),

                SizedBox(height: 24),

                // Round Navigation
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.rounds.map((roundNumber) {
                    bool isLocked = roundNumber.id != snapshot.activeRoundId;
                    return GestureDetector(
                      onTap: () {
                        if (isLocked) {
                          // _showLockedRoundMessage(roundNumber);
                        } else {
                          // _viewRoundHistory(roundNumber);
                        }
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isLocked
                              ? Colors.grey[300]
                              : (roundNumber.id == snapshot.activeRoundId
                                  ? Colors.blue
                                  : Colors.grey[300]),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        transform: _isShaking && isLocked
                            ? Matrix4.rotationZ(0.1 *
                                sin(DateTime.now().millisecondsSinceEpoch /
                                    100))
                            : Matrix4.identity(),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Text(
                              "Round ${roundNumber.round}",
                              style: TextStyle(
                                fontSize: 16,
                                color: isLocked
                                    ? Colors.black.withOpacity(0.5)
                                    : (roundNumber.id == snapshot.activeRoundId
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
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: calculateScore,
          child: Icon(Icons.check),
        ),
      );
    });
  }
}
