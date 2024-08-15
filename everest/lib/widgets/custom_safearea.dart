import 'package:everest/utils/colors.dart';
import 'package:flutter/material.dart';

class SafeAreaWidget extends StatelessWidget {
  final Color? color;
  final Widget? child;
  final bool? isTop;
  final bool? isBottom;
  const SafeAreaWidget({
    Key? key,
    this.color,
    required this.child,
    this.isTop,
    this.isBottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? ColorUtils.darkChatBubbleColor,
      child: SafeArea(
        top: isTop ?? true,
        bottom: isBottom ?? false,
        child: child!,
      ),
    );
  }
}
