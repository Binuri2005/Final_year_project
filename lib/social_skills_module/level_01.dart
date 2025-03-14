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

class _Level1GameState extends State<Level1Game> with TickerProviderStateMixin {
  late AnimationController _shakeController;
  bool showResults = false;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _initializeGame();
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  void _initializeGame() {
    // Start with the first incomplete round
    final nextRound = widget.rounds.firstWhere(
      (element) => element.attemptedRoundResult == null,
      orElse: () => widget.rounds.first,
    );

    context.read<SocialSkillPlayGameViewModel>().setActiveRoundId(
          levelID: widget.levelID,
          roundID: nextRound.id,
        );
  }

  Widget _buildProgressIndicator() {
    final viewModel = context.read<SocialSkillPlayGameViewModel>();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor.withOpacity(0.1),
            Theme.of(context).primaryColor.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.rounds.map((round) {
          final isActive = round.id == viewModel.activeRoundId;
          final isCompleted = round.attemptedRoundResult != null;
          final roundNumber = widget.rounds.indexOf(round) + 1;

          // Check if previous rounds are completed
          final isUnlocked = widget.rounds
              .take(widget.rounds.indexOf(round))
              .every((r) => r.attemptedRoundResult != null);

          return GestureDetector(
            onTap: () {
              if (isCompleted || isUnlocked) {
                viewModel.setActiveRoundId(
                  levelID: widget.levelID,
                  roundID: round.id,
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      isCompleted
                          ? "Reattempting round $roundNumber"
                          : "Starting round $roundNumber",
                    ),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.1,
                      left: 20,
                      right: 20,
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        const Icon(Icons.lock, color: Colors.white),
                        const SizedBox(width: 12),
                        Text("Complete previous rounds first."),
                      ],
                    ),
                    backgroundColor: Colors.redAccent.shade200,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.1,
                      left: 20,
                      right: 20,
                    ),
                  ),
                );
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 6,
              ),
              height: 48,
              width: 48,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                gradient: isCompleted
                    ? LinearGradient(
                        colors: [Colors.green.shade500, Colors.green.shade700],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : isActive
                        ? LinearGradient(
                            colors: [
                              Theme.of(context).primaryColor,
                              Theme.of(context).primaryColor.withOpacity(0.8),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : null,
                color: !isActive && !isCompleted
                    ? isUnlocked
                        ? Colors.white
                        : Colors.grey.shade200
                    : null,
                shape: BoxShape.circle,
                boxShadow: isActive || isCompleted
                    ? [
                        BoxShadow(
                          color: (isCompleted
                                  ? Colors.green.shade600
                                  : Theme.of(context).primaryColor)
                              .withOpacity(0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        )
                      ]
                    : [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        )
                      ],
                border: !isActive && !isCompleted && isUnlocked
                    ? Border.all(
                        color: Theme.of(context).primaryColor.withOpacity(0.5),
                        width: 2,
                      )
                    : null,
              ),
              child: Center(
                child: isCompleted
                    ? const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 20,
                      )
                    : Text(
                        "$roundNumber",
                        style: TextStyle(
                          color: (isActive)
                              ? Colors.white
                              : isUnlocked
                                  ? Theme.of(context).primaryColor
                                  : Colors.black45,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  void _submitRound() {
    final viewModel = context.read<SocialSkillPlayGameViewModel>();

    viewModel.submitActiveRound(
      (data) {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 28,
                ),
                SizedBox(width: 10),
                Text("Round Submitted"),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Your answers have been submitted."),
                const SizedBox(height: 24),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${data['correctQuestionCount']}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade700,
                        ),
                      ),
                      Text(
                        "/${data['totalQuestionCount']}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                child: const Text(
                  "Got it!",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
        viewModel.getQuizData();
      },
      (error) {
        _shakeController.forward().then((_) => _shakeController.reset());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.error_outline, color: Colors.white),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Failed to submit round. Please try again.",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.red.shade600,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.1,
              left: 20,
              right: 20,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SocialSkillPlayGameViewModel>(
      builder: (context, viewModel, _) {
        final activeRound = widget.rounds
                .where((item) =>
                    context
                        .read<SocialSkillPlayGameViewModel>()
                        .activeRoundId ==
                    item.id)
                .isEmpty
            ? null
            : widget.rounds
                .where((item) =>
                    context
                        .read<SocialSkillPlayGameViewModel>()
                        .activeRoundId ==
                    item.id)
                .first;

        var currentRoundIndex = widget.rounds.indexWhere(
                (element) => element.id == viewModel.activeRoundId) +
            1;

        // reset the active round if all rounds are completed
        if (showResults) {
          viewModel.setActiveRoundId(
              levelID: widget.levelID, roundID: widget.rounds.first.id);
          currentRoundIndex = widget.rounds
              .where((element) => element.attemptedRoundResult != null)
              .length;
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Round $currentRoundIndex",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                letterSpacing: 0.5,
              ),
            ),
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 4,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(16),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.help_outline, size: 28),
                tooltip: 'Instructions',
                onPressed: () => _showInstructionsDialog(),
              ),
              const SizedBox(width: 8),
            ],
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).scaffoldBackgroundColor,
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
                ],
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: activeRound == null
                    ? _buildCompletedView()
                    : _buildGameContent(activeRound, viewModel),
              ),
            ),
          ),
          floatingActionButton: activeRound == null
              ? FloatingActionButton(
                  onPressed: () => Navigator.pop(context),
                  backgroundColor: Colors.green,
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 28),
                )
              : FloatingActionButton.extended(
                  onPressed: _submitRound,
                  backgroundColor: Theme.of(context).primaryColor,
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  icon: const Icon(Icons.check, color: Colors.white),
                  label: const Text(
                    "Submit",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }

  Widget _buildCompletedView() {
    int correctAnswers = 0;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.celebration,
            size: 80,
            color: Colors.amber,
          ),
          const SizedBox(height: 24),
          Text(
            "Level Complete!",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            "Score: $correctAnswers/${widget.rounds.length}",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 32),
          _buildRoundSummary(),
        ],
      ),
    );
  }

  Widget _buildRoundSummary() {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.rounds.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final round = widget.rounds[index];
          final isCorrect = false;

          return Container(
            width: 60,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: isCorrect ? Colors.green : Colors.red,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                "${index + 1}",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGameContent(
      SocialQuizRound activeRound, SocialSkillPlayGameViewModel viewModel) {
    return Column(
      children: [
        _buildProgressIndicator(),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildQuestions(activeRound),
                const SizedBox(height: 24),
                _buildAnswerTargets(activeRound, viewModel),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuestions(SocialQuizRound activeRound) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Questions",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Wrap(
              alignment: WrapAlignment.start,
              spacing: 16,
              runSpacing: 16,
              children: activeRound.mixedQuestions.map((item) {
                return Draggable<QuizQuestion>(
                  data: item,
                  feedback: Material(
                    color: Colors.transparent,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        item.questionImageURL,
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  childWhenDragging: Opacity(
                    opacity: 0.3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        item.questionImageURL,
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        item.questionImageURL,
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerTargets(
      SocialQuizRound activeRound, SocialSkillPlayGameViewModel viewModel) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Match to correct expressions",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Wrap(
              alignment: WrapAlignment.start,
              spacing: 16,
              runSpacing: 16,
              children: activeRound.mixedAnswers.map((expression) {
                return DragTarget<QuizQuestion>(
                  builder: (context, candidateData, rejectedData) {
                    bool isHovered = candidateData.isNotEmpty;

                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 160,
                      height: 180,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isHovered
                            ? Theme.of(context).primaryColor.withOpacity(0.1)
                            : Colors.white,
                        border: Border.all(
                          color: isHovered
                              ? Theme.of(context).primaryColor
                              : Colors.grey.shade300,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            expression.answer,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const SizedBox(height: 12),
                          if (expression.draggedQuestionID != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                expression.draggedQuestionID!.questionImageURL,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            )
                          else
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.add_photo_alternate_outlined,
                                  color: Colors.grey,
                                  size: 32,
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                  onAcceptWithDetails: (details) {
                    viewModel.injectQuestionToAnAnswer(
                      question: details.data,
                      answer: expression,
                    );
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  void _showInstructionsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("How to Play"),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "1. Drag the images to match them with the correct expressions."),
            SizedBox(height: 8),
            Text(
                "2. Once all images are matched, tap Submit to check your answers."),
            SizedBox(height: 8),
            Text("3. Complete all rounds to finish the level."),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Got it!"),
          ),
        ],
      ),
    );
  }
}
