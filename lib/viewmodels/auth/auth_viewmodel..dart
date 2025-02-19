import 'package:app/services/api/api_service.dart';
import 'package:app/services/storage/storage.service.dart';
import 'package:flutter/cupertino.dart';

class AuthViewModel extends ChangeNotifier {
  bool _isRegisteringUser = false;
  bool get isRegisteringUser => _isRegisteringUser;

  bool _isLoggingInUser = false;
  bool get isLoggingInUser => _isLoggingInUser;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // Register user
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
          'confirmPassword': confirmPassword,
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

// login user loginUser

// Login user
  Future<bool> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      _isLoggingInUser = true;
      notifyListeners();

      // Simulate login delay

      var response = await ApiService.sendRequest(
        method: HTTPMethod.POST,
        url: 'http://localhost:3000/auth/login',
        body: {
          'email': email,
          'password': password,
        },
      );

      _isLoggingInUser = false;
      notifyListeners();

      // Check if login was successful based on the response
      if (response['token'] != null) {
        await SecureStorageService().write("access_token", response['token']);
        return true; // Login successful
      } else {
        _errorMessage = response['message'] ?? 'Login failed';
        notifyListeners();
        return false;
      }
    } on ApiError catch (e) {
      _errorMessage = e.message;
      notifyListeners();
      return false;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    } finally {
      _isLoggingInUser = false;
      notifyListeners();
    }
  }
}
