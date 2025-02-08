import 'package:flutter/material.dart';

class RolePlayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/light_background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Container(
            height:
                MediaQuery.of(context).size.height * 1.05, // Moves boxes down
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(width: 8),
                    ],
                  ),
                ),
                SizedBox(height: 10), // More spacing after the AppBar

                // Centered Title
                Center(
                  child: Text(
                    'Welcome to Role Plays',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    'Engage with different scenarios and improve your social and communication skills',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 30), // Pushes boxes lower

                // Role Play Boxes
                Center(child: _buildBox('Individual Role-plays', () {})),
                SizedBox(height: 40),
                Center(child: _buildBox('Dual Role-plays', () {})),
                SizedBox(height: 40),
                Center(child: _buildBox('Peer Role-plays', () {})),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildBox(String text, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 110,
          width: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 9, 83, 144).withOpacity(0.7),
                spreadRadius: 4,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
        ),
        Container(
          height: 100,
          width: 240,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.white, width: 1),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ],
    ),
  );
}
