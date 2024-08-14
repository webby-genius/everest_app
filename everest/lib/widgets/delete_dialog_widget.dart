import 'package:everest/utils/colors.dart';
import 'package:everest/utils/common_styles.dart';
import 'package:flutter/material.dart';

class CustomDialogWidget extends StatelessWidget {
  final String title;
  final String cancelTxt;
  final String content;
  void Function()? onPressed;
  Widget? okButton;

  CustomDialogWidget({
    Key? key,
    this.title = 'Delete',
    this.cancelTxt = 'Cancel',
    this.content = 'Are you sure you want to delete this item?',
    required this.onPressed,
    this.okButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorUtils.whiteColor,
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        MaterialButton(
          child: Text(cancelTxt),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        MaterialButton(
          onPressed: onPressed,
          child: okButton ?? const Text("Delete"),
        ),
      ],
    );
  }
}