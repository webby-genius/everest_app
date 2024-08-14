import 'dart:io';
import 'package:everest/utils/colors.dart';
import 'package:everest/utils/common_styles.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  String? title;
  Widget? trailing;
  bool visible;
  void Function()? backOnPressed;
  AppBarWidget({
    super.key,
    this.title,
    this.trailing,
    this.visible = true,
    this.backOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
        color: ColorUtils.primaryColor,
      ),
      child: ListTile(
        leading: Visibility(
          visible: visible,
          child: IconButton(
            onPressed: backOnPressed ??
                () {
                  Navigator.pop(context);
                },
            icon: Icon(
              Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios_new,
              color: ColorUtils.whiteColor,
            ),
          ),
        ),
        title: Text(
          title ?? '',
          style: size21(fw: FW.semiBold, fontColor: ColorUtils.whiteColor),
        ),
        trailing: trailing,
      ),
    );
  }
}

class DashBoardAppBarWidget extends StatelessWidget {
  List<Widget> trailing;
  Widget? title;
  bool isCenterTitle;
  void Function()? onTapDrawer;
  DashBoardAppBarWidget({
    super.key,
    this.title,
    this.trailing = const <Widget>[],
    this.onTapDrawer,
    this.isCenterTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 63,
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
          color: ColorUtils.primaryColor,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Row(
          children: [
            GestureDetector(
              onTap: onTapDrawer,
              child: const Icon(
                Icons.menu,
                color: ColorUtils.whiteColor,
                size: 30,
              ),
            ),
            SizedBox(width: isCenterTitle == true ? 50 : 15),
            SizedBox(child: title),
            const Spacer(),
            Row(children: trailing),
          ],
        ));
  }
}
