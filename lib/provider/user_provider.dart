import 'package:flutter/material.dart';
import 'package:tjini_app/models/login_response.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  User? getUser() {
    return _user;
  }
}
