import 'package:everest/utils/colors.dart';
import 'package:everest/utils/common_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  TextInputType? keyboardType;
  int? maxLength;
  List<TextInputFormatter>? inputFormatters;
  bool readOnly;
  Widget? suffix;
  Widget? suffixIcon;
  bool? showCursor;
  TextInputAction? textInputAction;
  int maxLines;
  String? label;
  bool? isDense;
  Color? fillColor;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  void Function()? onTap;
  void Function(String)? onChanged;

  CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.keyboardType,
    this.maxLength,
    this.inputFormatters,
    this.readOnly = false,
    this.suffix,
    this.label,
    this.suffixIcon,
    this.isDense,
    this.showCursor,
    this.textInputAction,
    this.maxLines = 1,
    this.fillColor,
    this.onTap,
    this.onChanged,
    this.focusNode,
    this.nextFocus,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: label != "" ? true : false,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              label ?? "",
            ),
          ),
        ),
        TextFormField(
          controller: controller,
          readOnly: readOnly,
          showCursor: showCursor,
          maxLines: maxLines,
          onChanged: onChanged ?? (value) {},
          onTap: onTap,
          focusNode: focusNode,
          onFieldSubmitted: (_) {
            focusNode!.unfocus();
            FocusScope.of(context).requestFocus(nextFocus);
          },
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: size15(fontColor: ColorUtils.blackColor40),
            filled: true,
            isDense: isDense ?? true,
            suffix: suffix,
            suffixIcon: suffixIcon,
            fillColor: fillColor ?? const Color(0xffF1F2F7),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 16,
            ),
          ),
          validator: validator,
          keyboardType: keyboardType ?? TextInputType.text,
          maxLength: maxLength,
          inputFormatters: inputFormatters,
          textInputAction: textInputAction ?? TextInputAction.next,
        ),
      ],
    );
  }
}
