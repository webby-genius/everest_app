import 'dart:convert';
import 'package:everest/Routes/app_route.dart';
import 'package:everest/apis/api.dart';
import 'package:everest/apis/api_manager.dart';
import 'package:everest/apis/api_urls.dart';
import 'package:everest/apis/models/login_model.dart';
import 'package:everest/widgets/shared_prefs.dart';
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

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  LoginResponse loginResponse = LoginResponse();
  Future loginApiResponse({required BuildContext context}) async {
    isLoading = true;
    Map<String, String> bodyData = {
      "grant_type": "password",
      "username": emailController.text,
      "password": passwordController.text,
    };
    debugPrint("bodyData -->> $bodyData");

    String username = emailController.text;
    String password = passwordController.text;
    String basicAuth = 'Basic ' + base64.encode(utf8.encode('$username:$password'));
    print("BASIC AUTH --->>>>> $basicAuth");
    try {
      APIResponse response = await APIManager.callAPI(
          context: context,
          url: ApiUrlPage.loginUrl,
          type: APIMethodType.POST,
          apiBodyType: APIBodyType.X_WWW_FORM_URL_ENCODED,
          body: bodyData,
          header: <String, String>{
            "Content-Type": "application/x-www-form-urlencoded",
            'Authorization': basicAuth,
          });

      if (response.success) {
        loginResponse = LoginResponse.fromJson(response.response!);

        // await SharedPrefs.prefs.setInt(SharedPrefs.userId, loginResponse.userinfo!.userid!);
        await SharedPrefs.prefs.setString(SharedPrefs.userToken, jsonEncode(loginResponse.accessToken));
        await SharedPrefs.prefs.setString(SharedPrefs.isRoute, 'Login');
        Navigator.pushNamedAndRemoveUntil(context, RouteUtils.dashBoardScreen, (route) => false);
        clearFields();
        isLoading = false;
        emailController.clear();
        passwordController.clear();

        notifyListeners();
      } else {
        isLoading = false;
      }
    } catch (e) {
      isLoading = false;
      debugPrint("ERROR -->> $e");
    }
    notifyListeners();
  }
}
