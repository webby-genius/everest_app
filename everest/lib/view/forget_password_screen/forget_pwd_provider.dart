import 'package:flutter/material.dart';

class ForgetPwdProvider extends ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _obSecureData = false;
  bool get obSecureData => _obSecureData;
  set obSecureData(bool value) {
    _obSecureData = value;
    notifyListeners();
  }
}
