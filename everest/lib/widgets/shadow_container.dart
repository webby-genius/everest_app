import 'package:everest/utils/colors.dart';
import 'package:flutter/material.dart';

Widget shadowContainer({
  required Widget child,
  void Function()? onTap,
  EdgeInsetsGeometry? margin,
  EdgeInsetsGeometry? padding,
  Color? color,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      margin: margin,
      decoration: BoxDecoration(
        color: color ?? ColorUtils.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 1),
            blurRadius: 12,
            spreadRadius: 0.5,
            color: Colors.black26,
          ),
        ],
      ),
      child: child,
    ),
  );
}
