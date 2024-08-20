import 'dart:io';
import 'package:everest/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircularIndicatorWidget extends StatelessWidget {
  final Widget child;
  final bool visible;
  const CircularIndicatorWidget({
    Key? key,
    required this.child,
    this.visible = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Stack(
      children: [
        child,
        Visibility(
          visible: visible,
          child: Container(
            height: screenSize.height,
            width: screenSize.width,
            // color: Colors.white24,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: screenSize.width * 0.25,
                  width: screenSize.width * 0.25,
                  decoration: BoxDecoration(
                    color: ColorUtils.loaderColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Center(
                    child: CupertinoActivityIndicator(
                      radius: 20,
                      color: ColorUtils.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CircularProgressIndicatorWidget extends StatelessWidget {
  final Widget child;
  final bool visible;
  final Color? color;
  const CircularProgressIndicatorWidget({
    Key? key,
    required this.child,
    this.visible = false,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Stack(
      children: [
        child,
        Visibility(
          visible: visible,
          child: Container(
            height: screenSize.height,
            width: screenSize.width,
            color: color ?? const Color.fromARGB(9, 0, 0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: screenSize.width * 0.23,
                  width: screenSize.width * 0.23,
                  decoration: BoxDecoration(color: ColorUtils.darkChatBubbleColor.withOpacity(0.20), borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: Platform.isIOS
                        ? const CupertinoActivityIndicator(radius: 20, color: ColorUtils.darkChatBubbleColor)
                        : const CircularProgressIndicator(color: ColorUtils.darkChatBubbleColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
