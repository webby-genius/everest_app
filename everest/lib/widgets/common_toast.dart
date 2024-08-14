import 'package:everest/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FlutterToastWidget {
  static show(text, action, {ToastGravity? gravity}) {
    return Fluttertoast.showToast(
      msg: text,
      backgroundColor: action == "error"
          ? ColorUtils.primaryColor
          : action == "success"
              ? Colors.green[500]
              : ColorUtils.blackColor,
      timeInSecForIosWeb: 2,
      gravity: gravity ?? ToastGravity.BOTTOM,
    );
  }
}
