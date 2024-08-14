import 'package:everest/utils/colors.dart';
import 'package:everest/utils/common_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

class MyAccountScreen extends StatefulWidget {
  AdvancedDrawerController advancedDrawerController;
  MyAccountScreen({super.key, required this.advancedDrawerController});

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
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
        title: Text(
          "My Account",
          style: size20(fontColor: ColorUtils.whiteColor, fw: FW.bold),
        ),
      ),
    );
  }
}
