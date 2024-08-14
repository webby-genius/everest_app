// ignore_for_file: dead_code
import 'package:everest/view/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';

class RouteUtils {
  static const String welcomeScreen = 'WelcomeScreen';
  static const String loginScreen = 'LoginScreen';
  static const String registerScreen = 'RegisterScreen';
  static const String homeScreen = 'HomeScreen';
  static const String profileScreen = 'ProfileScreen';

  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteUtils.welcomeScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
        break;
      default:
        debugPrint('onGenerateRoute Default Call');
        return null;
        break;
    }
  }
}
