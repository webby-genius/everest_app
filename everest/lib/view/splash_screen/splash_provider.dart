import 'package:everest/Routes/app_route.dart';

import 'package:everest/view/login_screen/login_screen.dart';
import 'package:everest/widgets/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashProvider extends ChangeNotifier {
  onReady({required BuildContext context}) async {
    int userID = SharedPrefs.prefs.getInt(SharedPrefs.userId) ?? 0;
    Future.delayed(const Duration(seconds: 3), () async {
      SharedPrefs.prefs = await SharedPreferences.getInstance();
      String isRoute = SharedPrefs.prefs.getString(SharedPrefs.isRoute) ?? 'Nothing';
      debugPrint('isRoute -------------------- $isRoute');
      switch (isRoute) {
        case 'Nothing':
          Navigator.pushNamedAndRemoveUntil(context, RouteUtils.loginScreen, (route) => false);
          break;
        case 'Login':
          Navigator.pushNamedAndRemoveUntil(context, RouteUtils.dashBoardScreen, (route) => false);
          break;
        default:
          Navigator.pushNamedAndRemoveUntil(context, RouteUtils.loginScreen, (route) => false);
          break;
      }
    });
  }
}
