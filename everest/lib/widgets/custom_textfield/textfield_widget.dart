import 'package:everest/utils/colors.dart';
import 'package:everest/utils/common_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef OnTap = String? Function(String? value);
typedef OnChange = String? Function(String? value);

class TextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? lable;
  final bool? isObSecure;
  final OnTap? validator;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final VoidCallback? onTap;
  final bool? isReadOnly;
  final bool? enabled;
  final double? width;
  final List<TextInputFormatter>? textInputFormatter;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final void Function(String)? onChanged;
  final int? maxLines;
  final int? maxLength;

  const TextFieldWidget({
    Key? key,
    required this.controller,
    this.hintText = '',
    this.prefixIcon,
    this.suffixIcon,
    this.lable = '',
    this.isObSecure = false,
    this.validator,
    this.onTap,
    this.isReadOnly = false,
    this.enabled = true,
    this.textInputFormatter = const [],
    this.width,
    this.focusNode,
    this.nextFocus,
    this.onChanged,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.maxLines = 1,
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: TextFormField(
              onTap: onTap,
              validator: validator,
              controller: controller,
              obscureText: isObSecure!,
              readOnly: isReadOnly!,
              enabled: enabled,
              onChanged: onChanged,
              focusNode: focusNode,
              textInputAction: textInputAction,
              keyboardType: keyboardType,
              maxLines: maxLines,
              maxLength: maxLength,
              cursorColor: ColorUtils.blackColor,
              onFieldSubmitted: (_) {
                focusNode!.unfocus();
                FocusScope.of(context).requestFocus(nextFocus);
              },
              inputFormatters: textInputFormatter,
              decoration: InputDecoration(
                isDense: true,
                errorMaxLines: 2,
                fillColor: Colors.white,
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1.5,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1.5,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1.5,
                  ),
                ),
                labelText: hintText,
                // hintText: hintText,
                labelStyle: size13(),
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                errorStyle: const TextStyle(
                  color: Colors.red,
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: Colors.red,
                    width: 1.5,
                  ),
                ),
              ),
              autofocus: false,
            ),
          ),
        ),
      ],
    );
  }
}
