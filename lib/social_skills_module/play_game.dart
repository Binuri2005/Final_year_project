import 'package:app/social_skills_module/level_01.dart';
import 'package:app/viewmodels/social_skills/play_game/social_skill_play_game.viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayGamePage extends StatefulWidget {
  const PlayGamePage({super.key});

  @override
  State<PlayGamePage> createState() => _PlayGamePageState();
}

class _PlayGamePageState extends State<PlayGamePage> {
  @override
  void initState() {
    context.read<SocialSkillPlayGameViewModel>().getQuizData();
    super.initState();
  }

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
        child: Consumer<SocialSkillPlayGameViewModel>(
            builder: (context, snapshot, _) {
          if (snapshot.isQuizLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.isQuizError) {
            return Text(
              "Failed to load quizzes",
              style: TextStyle(color: Colors.red),
            );
          }
          return SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height *
                  1.05, // Adjust height to move boxes down
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        IconButton(
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.black),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20), // More spacing after the AppBar

                  const Center(
                    child: Text(
                      'Drag and Drop Play',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Center(
                    child: Text(
                      'Match accordingly and earn rewards ',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 30),

                  Column(
                      children: snapshot.quizData
                          .map(
                            (e) => Center(
                                child: _buildBox('${e.name}'.toUpperCase(), () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Level1Game(
                                          rounds: e.rounds,
                                          levelID: e.id,
                                        )),
                              );
                            })),
                          )
                          .toList()),

                  // SizedBox(height: 40),
                  //
                  // Center(
                  //     child: _buildBox('LEVEL 02', () {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => Level2Game()),
                  //   );
                  // })),
                  // SizedBox(height: 40),
                  //
                  // Center(child: _buildBox('LEVEL 03', () {})),
                ],
              ),
            ),
          );
        }),
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
                color: const Color.fromARGB(255, 9, 83, 144).withOpacity(0.7),
                spreadRadius: 4,
                blurRadius: 8,
                offset: const Offset(0, 4),
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
            style: const TextStyle(
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
