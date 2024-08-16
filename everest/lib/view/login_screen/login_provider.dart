import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  clearFields() {
    emailController.clear();
    passwordController.clear();
    notifyListeners();
  }

  bool _obSecureData = true;
  bool get obSecureData => _obSecureData;
  set obSecureData(bool value) {
    _obSecureData = value;
    notifyListeners();
  }
}
