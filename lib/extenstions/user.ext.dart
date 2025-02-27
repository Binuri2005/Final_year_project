import 'package:app/viewmodels/user/user.viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

extension StringExtension on BuildContext {
  User? get user {
    return watch<UserViewModel>().user;
  }
}
