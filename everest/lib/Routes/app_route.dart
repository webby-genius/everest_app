// ignore_for_file: dead_code
import 'package:everest/view/dashboard_screen/dashboard_screen.dart';
import 'package:everest/view/login_screen/login_screen.dart';
import 'package:everest/view/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';

class RouteUtils {
  static const String welcomeScreen = 'WelcomeScreen';
  static const String loginScreen = 'LoginScreen';
  static const String dashBoardScreen = 'dashBoardScreen';

  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteUtils.welcomeScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
        break;
      case RouteUtils.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
        break;
      case RouteUtils.dashBoardScreen:
        return MaterialPageRoute(builder: (_) => const DashBoardScreen());
        break;
      default:
        debugPrint('onGenerateRoute Default Call');
        return null;
        break;
    }
  }
}
