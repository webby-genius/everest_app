import 'package:everest/view/dashboard_screen/dashboard_screen.dart';
import 'package:everest/view/login_screen/login_screen.dart';
import 'package:everest/widgets/shared_prefs.dart';
import 'package:flutter/material.dart';

class SplashProvider extends ChangeNotifier {
  onReady({required BuildContext context}) async {
    int userID = SharedPrefs.prefs.getInt(SharedPrefs.userId) ?? 0;
    Future.delayed(const Duration(seconds: 3), () {
      // if (userID == 0) {
      //   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginScreen()), (route) => false);
      // } else {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const DashBoardScreen()), (route) => false);
      // }
    });
  }
}
