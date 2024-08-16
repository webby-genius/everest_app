import 'package:flutter/material.dart';

class ForgetPwdProvider extends ChangeNotifier {
  final forgetEmailController = TextEditingController();
  final newPasswordController = TextEditingController();
  final conformPasswordController = TextEditingController();

  clearFields() {
    forgetEmailController.clear();
    newPasswordController.clear();
    conformPasswordController.clear();
    notifyListeners();
  }

  bool _obSecureData = true;
  bool get obSecureData => _obSecureData;
  set obSecureData(bool value) {
    _obSecureData = value;
    notifyListeners();
  }

  bool _newObSecureData = true;
  bool get newObSecureData => _newObSecureData;
  set newObSecureData(bool value) {
    _newObSecureData = value;
    notifyListeners();
  }
}
