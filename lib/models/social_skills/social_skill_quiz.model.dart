class SocialQuizLevel {
  final String id;
  final String name;
  final String description;
  final List<SocialQuizRound> rounds;

  SocialQuizLevel(
      {required this.id,
      required this.name,
      required this.description,
      required this.rounds});

  factory SocialQuizLevel.fromJson(Map<String, dynamic> json) {
    return SocialQuizLevel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      rounds: (json['LevelRound'] as List)
          .map((round) => SocialQuizRound(
                id: round['id'],
                round: round['round'],
                createdAt: DateTime.parse(round['createdAt']),
                mixedQuestions: (round['mixedQuestions'] as List)
                    .map((question) => QuizQuestion(
                          id: question['id'],
                          levelRound: question['levelRoundId'],
                          questionImageURL: question['questionImageURL'],
                        ))
                    .toList(),
                mixedAnswers: (round['mixedAnswers'] as List)
                    .map((answer) => QuizAnswer(
                          id: answer['id'],
                          answer: answer['answer'],
                        ))
                    .toList(),
              ))
          .toList(),
    );
  }
}

class SocialQuizRound {
  final String id;
  final int round;
  final DateTime createdAt;
  final List<QuizQuestion> mixedQuestions;
  final List<QuizAnswer> mixedAnswers;

  SocialQuizRound(
      {required this.id,
      required this.round,
      required this.createdAt,
      required this.mixedQuestions,
      required this.mixedAnswers});
}

class QuizQuestion {
  final String id;
  final String levelRound;
  final String questionImageURL;

  QuizAnswer? draggedAnswerID;

  QuizQuestion({
    required this.id,
    required this.levelRound,
    required this.questionImageURL,
    this.draggedAnswerID,
  });

  void markAsAnswered(QuizAnswer answer) {
    draggedAnswerID = answer;
  }
}

class QuizAnswer {
  final String id;
  final String answer;

  QuizQuestion? draggedQuestionID;

  QuizAnswer({
    required this.id,
    required this.answer,
    this.draggedQuestionID,
  });

  void setDraggedQuestionID(QuizQuestion question) {
    draggedQuestionID = question;
  }
}
