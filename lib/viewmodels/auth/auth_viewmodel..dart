import 'package:flutter/cupertino.dart';

class AuthViewModel extends ChangeNotifier {
  //   auth logic

  double _myLoveForArya = 1;
  double get myLoveForArya => _myLoveForArya;

  void setMyLoveForArya(double value) {
    _myLoveForArya = value;
    notifyListeners();
  }

  String getStringFromDouble() {
    if (_myLoveForArya == 0) {
      return 'I hate Arya';
    } else if (_myLoveForArya == 1) {
      return 'I love Arya';
    } else {
      return 'I like Arya';
    }
  }
}
