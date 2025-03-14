import 'package:app/services/api/api_service.dart';
import 'package:app/services/api/constants.dart';
import 'package:flutter/material.dart';

class DailySkillViewModel extends ChangeNotifier {
  bool _isCreatingChallenge = false;
  bool get isCreatingChallenge => _isCreatingChallenge;

  List<DailySkill> _dailySkills = [];
  List<DailySkill> get dailySkills => _dailySkills;

  List<DailySkill> _commonChallenges = [];
  List<DailySkill> get commonChallenges => _commonChallenges;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isFetchingDailySkills = false;
  bool get isFetchingDailySkills => _isFetchingDailySkills;

  submitRoutine(String challengeId, List<String> completedSteps,
      VoidCallback onSuccess) async {
    try {
      await ApiService.sendRequest(
        method: HTTPMethod.POST,
        url: ApiConstants.submitDailySkill,
        body: {
          'challengeId': challengeId,
          'completedSteps': completedSteps,
        },
      );

      onSuccess();
    } catch (e) {
      print(e);
    }
  }

  void getDailySkills() async {
    try {
      _isFetchingDailySkills = true;
      notifyListeners();

      // Call the API to get the daily skills
      var response = await ApiService.sendRequest(
        method: HTTPMethod.GET,
        url: ApiConstants.getDailySkills,
      );

      List<DailySkill> dailySkills = [];
      List<DailySkill> commonTemp = [];

      for (var dailySkill in response['commonChallenges']) {
        List<DailySkillStep> steps = [];

        for (var step in dailySkill['DailyChallengeItem']) {
          steps.add(DailySkillStep(
            id: step['id'],
            text: step['text'],
          ));
        }

        commonTemp.add(DailySkill(
          id: dailySkill['id'],
          title: dailySkill['title'],
          startTime: DateTime.parse(dailySkill['startAtTime']),
          endTime: DateTime.parse(dailySkill['endAtTime']),
          steps: steps,
        ));
      }

      for (var dailySkill in response['userChallenges']) {
        List<DailySkillStep> steps = [];

        for (var step in dailySkill['DailyChallengeItem']) {
          steps.add(DailySkillStep(
            id: step['id'],
            text: step['text'],
          ));
        }

        dailySkills.add(DailySkill(
          id: dailySkill['id'],
          title: dailySkill['title'],
          startTime: DateTime.parse(dailySkill['startAtTime']),
          endTime: DateTime.parse(dailySkill['endAtTime']),
          steps: steps,
        ));
      }

      _dailySkills = dailySkills;
      _commonChallenges = commonTemp;
      _isFetchingDailySkills = false;
      notifyListeners();
    } on ApiError catch (e) {
      _errorMessage = e.message;
      notifyListeners();
    } catch (e, st) {
      print(st);
      _errorMessage = e.toString();
      notifyListeners();
    } finally {
      _isFetchingDailySkills = false;
      notifyListeners();
    }
  }

  void createChallenge({
    required String title,
    required TimeOfDay startTime,
    required TimeOfDay endTime,
    required List<String> steps,
    required VoidCallback onSuccess,
    required VoidCallback onFailure,
  }) async {
    try {
      _isCreatingChallenge = true;
      notifyListeners();

      // Call the API to create the challenge
      await ApiService.sendRequest(
        method: HTTPMethod.POST,
        url: ApiConstants.createChallenge,
        body: {
          'title': title,
          'startTime': formatTimeOfDay(startTime),
          'endTime': formatTimeOfDay(endTime),
          'text': steps,
        },
      );

      getDailySkills();

      _isCreatingChallenge = false;
      notifyListeners();

      onSuccess();
    } on ApiError catch (e) {
      _errorMessage = e.message;
      notifyListeners();
      onFailure();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      onFailure();
    } finally {
      _isCreatingChallenge = false;
      notifyListeners();
    }
  }
}

class DailySkill {
  final String id;

  final DateTime startTime;
  final DateTime endTime;

  final String title;
  final List<DailySkillStep> steps;

  DailySkill({
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.id,
    required this.steps,
  });
}

class DailySkillStep {
  final String id;
  final String text;

  DailySkillStep({required this.id, required this.text});
}

String formatTimeOfDay(TimeOfDay time) {
  final String hour = time.hour.toString().padLeft(2, '0');
  final String minute = time.minute.toString().padLeft(2, '0');
  return '$hour:$minute:00';
}
