import 'package:flutter/material.dart';

Widget assetPngUtils({
  required String assetImage,
  double? height,
  double? width,
  Color? color,
  BoxFit fit = BoxFit.contain,
}) {
  return Image.asset(
    assetImage,
    height: height ?? 20,
    width: width ?? 20,
    color: color,
    fit: fit,
  );
}

Widget networkPngUtils({
  required String networkImage,
  double? height,
  double? width,
  Color? color,
  BoxFit fit = BoxFit.contain,
}) {
  return Image.network(
    networkImage,
    height: height ?? 20,
    width: width ?? 20,
    color: color,
    fit: fit,
  );
}
