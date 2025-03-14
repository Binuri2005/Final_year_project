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
    if (widget.rounds
        .where((element) => element.attemptedRoundResult == null)
        .isEmpty) {
      setState(() => showResults = true);
      return;
    }

    context.read<SocialSkillPlayGameViewModel>().setActiveRoundId(
          levelID: widget.levelID,
          roundID: widget.rounds
              .where((element) => element.attemptedRoundResult == null)
              .first
              .id,
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
            title: const Text("Round Submitted"),
            content: Column(
              children: [
                const Text("Your answers have been submitted."),
                const SizedBox(height: 16),
                Text(
                  "You scored ${data['correctQuestionCount']}/${data['totalQuestionCount']} correct answers.",
                ),
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
        viewModel.getQuizData();
      },
      (error) {
        _shakeController.forward().then((_) => _shakeController.reset());
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Failed to submit round. Please try again.",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
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
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(Icons.help_outline),
                onPressed: () => _showInstructionsDialog(),
              ),
            ],
          ),
          body: activeRound == null
              ? _buildCompletedView()
              : _buildGameContent(activeRound, viewModel),
          floatingActionButton: activeRound == null
              ? FloatingActionButton(
                  onPressed: () => Navigator.pop(context),
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.check, color: Colors.white),
                )
              : FloatingActionButton.extended(
                  onPressed: _submitRound,
                  backgroundColor: Theme.of(context).primaryColor,
                  icon: const Icon(Icons.check, color: Colors.white),
                  label: Text("Submit", style: TextStyle(color: Colors.white)),
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

  Widget _buildProgressIndicator() {
    final viewModel = context.read<SocialSkillPlayGameViewModel>();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.rounds.map((round) {
          final isActive = round.id == viewModel.activeRoundId;
          final isCompleted = round.attemptedRoundResult != null;
          final roundNumber = widget.rounds.indexOf(round) + 1;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 6,
            ),
            height: 42,
            margin: const EdgeInsets.symmetric(horizontal: 6),
            decoration: BoxDecoration(
              color: isCompleted
                  ? Colors.green.shade600
                  : isActive
                      ? Theme.of(context).primaryColor
                      : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(21),
              boxShadow: isActive || isCompleted
                  ? [
                      BoxShadow(
                        color: (isCompleted
                                ? Colors.green.shade600
                                : Theme.of(context).primaryColor)
                            .withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      )
                    ]
                  : null,
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$roundNumber",
                    style: TextStyle(
                      color: (isActive || isCompleted)
                          ? Colors.white
                          : Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  if (isCompleted)
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: InkWell(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "You have now going back to this round.",
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.green,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                          // switch to the round
                          viewModel.setActiveRoundId(
                            levelID: widget.levelID,
                            roundID: round.id,
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.replay,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
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
