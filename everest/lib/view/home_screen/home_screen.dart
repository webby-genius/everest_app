import 'package:everest/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

class HomeScreen extends StatefulWidget {
  AdvancedDrawerController advancedDrawerController;
  HomeScreen({super.key, required this.advancedDrawerController});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtils.darkChatBubbleColor,
        leading: TextButton(
          onPressed: () {
            widget.advancedDrawerController.showDrawer();
          },
          child: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: widget.advancedDrawerController,
              builder: (context, value, _) {
                return Icon(
                  value.visible ? Icons.clear : Icons.menu,
                  key: ValueKey<bool>(value.visible),
                  color: Colors.white,
                );
              }),
        ),
      ),
    );
  }
}
