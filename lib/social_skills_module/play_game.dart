import 'package:app/models/social_skills/social_skill_quiz.model.dart';
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back, color: Color(0xFF095390)),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
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
              return const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF095390),
                  strokeWidth: 3,
                ),
              );
            }
            if (snapshot.isQuizError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Failed to load quizzes",
                      style: TextStyle(
                        color: Colors.red[700],
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context
                          .read<SocialSkillPlayGameViewModel>()
                          .getQuizData(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF095390),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        "Retry",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 24),
                      _buildHeader(),
                      const SizedBox(height: 40),
                      _buildLevelsList(snapshot.quizData, context),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF095390).withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              const Text(
                'Drag and Drop Play',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF095390),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 100,
                height: 3,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Match accordingly and earn rewards',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF555555),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLevelsList(
      List<SocialQuizLevel> quizData, BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: quizData.length,
      itemBuilder: (context, index) {
        final quiz = quizData[index];
        return _buildLevelCard(
          quiz,
          context,
          Color(0xFF095390).withOpacity(0.6 + (index * 0.1)),
          index,
        );
      },
    );
  }

  Widget _buildLevelCard(
    SocialQuizLevel quiz,
    BuildContext context,
    Color color,
    int index,
  ) {
    final completedRounds = quiz.rounds
        .where((element) => element.attemptedRoundResult != null)
        .toList();
    final totalRounds = quiz.rounds.length;
    final progress =
        totalRounds > 0 ? completedRounds.length / totalRounds : 0.0;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Level1Game(
                rounds: quiz.rounds,
                levelID: quiz.id,
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color, color.withOpacity(0.8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.4),
                blurRadius: 8,
                spreadRadius: 2,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: completedRounds.length == totalRounds
                            ? Colors.green.withOpacity(0.2)
                            : color.withOpacity(0.8),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Center(
                        child: completedRounds.length == totalRounds
                            ? const Icon(
                                Icons.check,
                                color: Colors.green,
                                size: 30,
                              )
                            : Text(
                                '${index + 1}',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: color,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            quiz.name.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Complete ${completedRounds.length} out of $totalRounds rounds',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 20,
                    ),
                  ],
                ),
              ),
              Container(
                height: 10,
                decoration: const BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: progress,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
