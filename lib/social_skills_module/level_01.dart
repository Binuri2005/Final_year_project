import 'package:flutter/material.dart';
import 'datastructure_level01.dart'; // Import the data structure

class Level1Game extends StatefulWidget {
  @override
  _Level1GameState createState() => _Level1GameState();
}

class _Level1GameState extends State<Level1Game> {
  late List<Map<String, String>> expressionData;
  Map<String, String> droppedExpressions = {}; // Track dropped images

  @override
  void initState() {
    super.initState();
    expressionData = List.from(
        expressionDataList); // Use the data from datastructure_level01.dart
    print(
        expressionData); // Print the data to ensure it's correctly initialized
  }

  void checkMatch(String imagePath, String term) {
    setState(() {
      droppedExpressions[term] = imagePath; // Update the dropped image
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Level 1: Match Expressions"),
      ),
      body: Column(
        children: [
          // Top part: Images to drag
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: expressionData.length,
              itemBuilder: (context, index) {
                final item = expressionData[index];
                return Draggable<String>(
                  data: item["image"]!, // Pass image path, not the term
                  feedback: Material(
                    color: Colors.transparent,
                    child: Image.asset(
                      item["image"]!,
                      width: 100,
                      height: 100,
                    ),
                  ),
                  childWhenDragging: Opacity(
                    opacity: 0.5,
                    child: Image.asset(
                      item["image"]!,
                      width: 100,
                      height: 100,
                    ),
                  ),
                  child: Image.asset(
                    item["image"]!,
                    width: 100,
                    height: 100,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                          child: Icon(Icons
                              .error)); // Show error icon if image fails to load
                    },
                  ),
                );
              },
            ),
          ),
          // Bottom part: Drag targets (text boxes)
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: expressionData.length,
              itemBuilder: (context, index) {
                final term = expressionData[index]["term"];
                return DragTarget<String>(
                  builder: (context, candidateData, rejectedData) {
                    return Container(
                      alignment: Alignment.center,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: droppedExpressions[term] != null
                          ? Image.asset(
                              droppedExpressions[term]!,
                              width: 100,
                              height: 100,
                            ) // Show dropped image
                          : Text(
                              term!,
                              style: TextStyle(fontSize: 18),
                            ),
                    );
                  },
                  onAccept: (imagePath) {
                    checkMatch(
                        imagePath, term!); // Check match with the image path
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
