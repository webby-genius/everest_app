import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  final forgetEmailController = TextEditingController();
  final newPasswordController = TextEditingController();
  final conformPasswordController = TextEditingController();

  bool _obSecureData = false;
  bool get obSecureData => _obSecureData;
  set obSecureData(bool value) {
    _obSecureData = value;
    notifyListeners();
  }

  bool _newObSecureData = false;
  bool get newObSecureData => _newObSecureData;
  set newObSecureData(bool value) {
    _newObSecureData = value;
    notifyListeners();
  }
}
