// ignore_for_file: must_be_immutable

import 'package:everest/utils/colors.dart';
import 'package:everest/utils/common_styles.dart';
import 'package:everest/widgets/animation/animation.dart';
import 'package:everest/widgets/bounce_click_widget.dart';
import 'package:flutter/material.dart';

class CenterTextButtonWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final String? title;
  final TextStyle? style;
  final VoidCallback? onTap;
  final List<Color>? gradientColor;
  final double? elevation;
  final Color? titleColor;
  Decoration? decoration;
  Color? color;
  Widget? child;
  CenterTextButtonWidget({
    Key? key,
    this.height,
    this.width,
    this.title,
    this.style,
    this.gradientColor,
    this.onTap,
    this.elevation,
    this.color,
    this.titleColor,
    this.child,
    this.decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SlideFadeInAnimation(
      offset: const Offset(0, 50),
      curve: Curves.decelerate,
      duration: const Duration(milliseconds: 100),
      delay: const Duration(milliseconds: 10),
      child: BounceClickWidget(
        onTap: onTap,
        child: Card(
          elevation: elevation ?? 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            height: height ?? 54,
            width: width ?? screenSize.width * 0.92,
            decoration: decoration ??
                BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: color ?? ColorUtils.darkChatBubbleColor,
                  gradient: LinearGradient(
                    colors: gradientColor ?? ColorUtils.darkRedGradient,
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
            child: Center(
              child: child ??
                  Text(
                    title ?? '',
                    style: style ??
                        size22(
                          fontColor: titleColor ?? ColorUtils.whiteColor,
                          fw: FW.bold,
                        ),
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
