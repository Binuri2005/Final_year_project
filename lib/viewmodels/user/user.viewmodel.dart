import 'package:app/services/api/api_service.dart';
import 'package:app/services/api/constants.dart';
import 'package:flutter/cupertino.dart';

class UserViewModel extends ChangeNotifier {
  User? _user;
  User? get user => _user;

  bool _isEditingUser = false;
  bool get isEditingUser => _isEditingUser;

  bool _isUserError = false;
  bool get isUserError => _isUserError;

  String _userErrorMessage = "";
  String get userErrorMessage => _userErrorMessage;

  Future<bool> getUser() async {
    try {
      var user = await ApiService.sendRequest(
        method: HTTPMethod.GET,
        url: ApiConstants.getUser,
      );

      _user = User.fromJson(user);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  void changeName({
    required String firstName,
    required String lastName,
    required VoidCallback onSuccess,
    required VoidCallback onError,
  }) async {
    try {
      _isEditingUser = true;
      notifyListeners();

      var body = await ApiService.sendRequest(
        method: HTTPMethod.PUT,
        url: ApiConstants.getUser,
        body: {
          'firstName': firstName,
          'lastName': lastName,
        },
      );

      _user = User.fromJson(body['data']);
      _isEditingUser = false;
      notifyListeners();

      onSuccess();
    } catch (err) {
      _isEditingUser = false;
      _isUserError = true;
      _userErrorMessage = err.toString();
      onError();
    }
  }
}

class Streaks {
  final int dailyLifeStreak;
  final int speechStreak;
  final int socialStreak;

  Streaks(
      {required this.dailyLifeStreak,
      required this.speechStreak,
      required this.socialStreak});
}

class User {
  final String id;
  final String firstName;
  final String lastName;

  final String email;

  final Streaks streaks;

  final bool isVerified;

  final DateTime createdAt;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.streaks,
    required this.id,
    this.isVerified = false,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      streaks: Streaks(
        dailyLifeStreak:
            int.parse(json['UserStreaks'][0]['dailySkillStreak'].toString()),
        speechStreak:
            int.parse(json['UserStreaks'][0]['speechSkillStreak'].toString()),
        socialStreak:
            int.parse(json['UserStreaks'][0]['socialSkillStreak'].toString()),
      ),
      email: json['email'],
      isVerified: json['isVerified'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
