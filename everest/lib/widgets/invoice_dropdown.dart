import 'package:everest/utils/colors.dart';
import 'package:flutter/material.dart';

class DropDownWidget extends StatefulWidget {
  final String hintText;
  final List list;
  final String value;
  final Function onChange;
  final FocusNode? focusNode;
  TextStyle? textStyle;

  DropDownWidget({
    super.key,
    required this.hintText,
    required this.list,
    required this.value,
    required this.onChange,
    this.focusNode,
    this.textStyle,
  });
  @override
  _DropDownWidgetState createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 5, top: 2, bottom: 2),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black38),
        color: ColorUtils.whiteColor,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          style: widget.textStyle,
          isExpanded: true,
          focusNode: widget.focusNode,
          hint: Text(widget.hintText
          ),
          value: widget.value,
          dropdownColor: ColorUtils.whiteColor,
          onChanged: (newValue) {
            widget.onChange(newValue);
          },
          items: widget.list.map((location) {
            return DropdownMenuItem(value: location, child: Text(location, softWrap: true));
          }).toList(),
        ),
      ),
    );
  }
}
