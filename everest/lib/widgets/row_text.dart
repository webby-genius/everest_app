import 'package:everest/utils/colors.dart';
import 'package:everest/utils/common_styles.dart';
import 'package:flutter/material.dart';

class RowText extends StatelessWidget {
  String text1;
  String text2;
  TextStyle? style1;
  TextStyle? style2;
  int? flex1;
  int? flex2;
  RowText({
    super.key,
    this.text1 = '',
    this.text2 = '',
    this.style1,
    this.style2,
    this.flex1,
    this.flex2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: flex1 ?? 2,
          child: Text(text1, style: style1 ?? size14(fontColor: ColorUtils.blackColor60)),
        ),
        const Text(" : "),
        Expanded(
          flex: flex2 ?? 4,
          child: Text(capitalize(text2) ?? "", style: style2 ?? size15(fw: FW.medium)),
        ),
      ],
    );
  }
}

String? capitalize(String s) => (s != null && s.length > 1)
    ? s[0].toUpperCase() + s.substring(1)
    : s != null
        ? s.toUpperCase()
        : null;

class RowTextWidget extends StatelessWidget {
  String text1;
  String text2;
  TextStyle? style1;
  TextStyle? style2;
  RowTextWidget({
    super.key,
    this.text1 = '',
    this.text2 = '',
    this.style1,
    this.style2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text1, style: style1 ?? size14(fontColor: ColorUtils.blackColor60)),
        Spacer(),
        SizedBox(width: 30),
        Text(capitalize(text2) ?? "", style: style2 ?? size15(fw: FW.medium)),
      ],
    );
  }
}
