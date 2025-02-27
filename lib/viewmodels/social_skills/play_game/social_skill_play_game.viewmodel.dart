import 'package:app/models/social_skills/social_skill_quiz.model.dart';
import 'package:app/services/api/api_service.dart';
import 'package:app/services/api/constants.dart';
import 'package:flutter/cupertino.dart';

class SocialSkillPlayGameViewModel extends ChangeNotifier {
  bool _isQuizLoading = false;
  bool get isQuizLoading => _isQuizLoading;

  bool _isQuizError = false;
  bool get isQuizError => _isQuizError;

  // TODO :Change to handle it as index for better performance
  String? _activeRoundId;
  String? get activeRoundId => _activeRoundId;

  String? _activeLevelId;
  String? get activeLevelId => _activeLevelId;

  List<SocialQuizLevel> _quizData = [];
  List<SocialQuizLevel> get quizData => _quizData;

  void setActiveRoundId({String? levelID, String? roundID}) {
    _activeRoundId = roundID;
    _activeLevelId = levelID;
    notifyListeners();
  }

  void goToNextRound() {
    //   check current round all questions are answered
    bool isAllQuestionsAnswered = _quizData
        .firstWhere((element) => element.id == _activeLevelId)
        .rounds
        .firstWhere((element) => element.id == _activeRoundId)
        .mixedQuestions
        .every((element) => element.draggedAnswerID != null);

    if (isAllQuestionsAnswered) {
      // TODO  : move to next round
    }
  }

  void moveToNextRound() {}

  void injectQuestionToAnAnswer(
      {required QuizQuestion question, required QuizAnswer answer}) async {
    try {
      answer.setDraggedQuestionID(question);
      question.markAsAnswered(answer);
      notifyListeners();
    } catch (err) {
      print(err);
    }
  }

  void getQuizData() async {
    try {
      _isQuizLoading = true;

      var data = await ApiService.sendRequest(
          method: HTTPMethod.GET, url: ApiConstants.getSocialSkillQuizzes);

      _quizData = (data['data'] as List)
          .map((e) => SocialQuizLevel.fromJson(e))
          .toList();
    } catch (err) {
      _isQuizError = true;
      notifyListeners();
    } finally {
      _isQuizLoading = false;
      notifyListeners();
    }
  }
}
