import 'package:app/models/speech_skills/speech_skill_level.dart';
import 'package:app/services/api/api_service.dart';
import 'package:app/services/api/constants.dart';
import 'package:flutter/cupertino.dart';

class SpeechSkillViewModel extends ChangeNotifier {
  bool _isSpeechSkillLoading = false;
  bool get isSpeechSkillLoading => _isSpeechSkillLoading;

  bool _isSpeechSkillError = false;
  bool get isSpeechSkillError => _isSpeechSkillError;

  String _speechSkillErrorMessage = "";
  String get speechSkillErrorMessage => _speechSkillErrorMessage;

  List<SpeechSkillLevel> _speechSkillLevels = [];
  List<SpeechSkillLevel> get speechSkillLevels => _speechSkillLevels;

  Future<void> getSpeechSkill() async {
    try {
      _isSpeechSkillLoading = true;

      var res = await ApiService.sendRequest(
          method: HTTPMethod.GET, url: ApiConstants.getAllSpeechSkills);

      print(res);

      _speechSkillLevels = res['data']
          .map<SpeechSkillLevel>((skill) => SpeechSkillLevel.fromJson(skill))
          .toList();

      _isSpeechSkillLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
      _isSpeechSkillError = true;
      _speechSkillErrorMessage = e.toString();
      notifyListeners();
    }
  }

  markStepAsComplete(String stepId, VoidCallback onSuccess) async {
    try {
      await ApiService.sendRequest(
        method: HTTPMethod.POST,
        url: ApiConstants.markStepAsComplete,
        body: {
          'speechSkillId': stepId,
        },
      );
      onSuccess();
    } catch (e) {
      print(e);
    }
  }
}
