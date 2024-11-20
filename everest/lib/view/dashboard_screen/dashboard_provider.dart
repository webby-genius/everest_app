import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

class DashBoardProvider extends ChangeNotifier {
  AdvancedDrawerController advancedDrawerController = AdvancedDrawerController();
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  set currentIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }

  void setScreen(int index) {
    currentIndex = index;
    notifyListeners();
    advancedDrawerController.hideDrawer();
  }

  // @override
  // void dispose() {
  //   debugPrint("---------------------DISPOSE PROVIDER-----------------------------");
  //   advancedDrawerController.dispose();
  //   super.dispose();
  // }
}
