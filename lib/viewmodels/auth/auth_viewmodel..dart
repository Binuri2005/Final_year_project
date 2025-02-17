import 'package:app/services/api/api_service.dart';
import 'package:flutter/cupertino.dart';

class AuthViewModel extends ChangeNotifier {
  bool _isRegisteringUser = false;
  bool get isRegisteringUser => _isRegisteringUser;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> registerUser(
      {required String name,
      required String email,
      required String password,
      required String confirmPassword}) async {
    try {
      _isRegisteringUser = true;
      notifyListeners();

      await Future.delayed(const Duration(seconds: 2));

      var response = await ApiService.sendRequest(
        method: HTTPMethod.POST,
        url: 'http://localhost:3000/auth/register',
        body: {
          'username': name,
          'email': email,
          'password': password,
          'confirmPassword': confirmPassword
        },
      );

      _isRegisteringUser = false;
      notifyListeners();

      return true;
    } on ApiError catch (e) {
      _errorMessage = e.message;
      notifyListeners();
      return false;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    } finally {
      _isRegisteringUser = false;
      notifyListeners();
    }
  }
}
