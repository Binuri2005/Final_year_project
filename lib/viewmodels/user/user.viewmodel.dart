import 'package:app/services/api/api_service.dart';
import 'package:flutter/cupertino.dart';

class UserViewModel extends ChangeNotifier {
  User? _user;
  User? get user => _user;

  Future<bool> getUser() async {
    try {
      var user = await ApiService.sendRequest(
        method: HTTPMethod.GET,
        url: 'http://localhost:3000/user',
      );

      _user = User.fromJson(user);
      return true;
    } catch (e) {
      return false;
    }
  }
}

class User {
  final String id;
  final String username;
  final String email;

  final bool isVerified;

  final DateTime createdAt;

  User({
    required this.username,
    required this.email,
    required this.id,
    this.isVerified = false,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      isVerified: json['isVerified'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
