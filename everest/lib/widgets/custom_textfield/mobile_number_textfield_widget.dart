// import 'package:flutter/material.dart';
// import 'package:invoice_maker/utils/colors.dart';
// import 'package:invoice_maker/utils/common_styles.dart';
// import 'package:no_brainer/utilities/utils.dart';
// import 'package:no_brainer/view/widget/intl_phone_field/countries.dart';
// import 'package:no_brainer/view/widget/intl_phone_field/phone_number.dart';
// import 'package:no_brainer/view/widget/widget.dart';

// import '../intl_phone_field/intl_phone_field.dart';

// typedef OnPhoneNumberTap = void Function(PhoneNumber value);
// typedef OnCountryTap = void Function(Country value);

// class IntlPhoneFieldWidget extends StatefulWidget {
//   final TextEditingController? controller;
//   final String? hintText;
//   final String? lable;
//   final OnPhoneNumberTap? onPhoneNumberTap;
//   final OnCountryTap? onCountryTap;
//   final String? initialCountryCode;
//   const IntlPhoneFieldWidget({
//     Key? key,
//     this.controller,
//     this.hintText = '',
//     this.lable = '',
//     this.onPhoneNumberTap,
//     this.onCountryTap,
//     this.initialCountryCode = 'GB',
//   }) : super(key: key);

//   @override
//   State<IntlPhoneFieldWidget> createState() => _IntlPhoneFieldWidgetState();
// }

// class _IntlPhoneFieldWidgetState extends State<IntlPhoneFieldWidget> {
//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//     return SlideFadeInAnimation(
//       offset: const Offset(0, 50),
//       curve: Curves.decelerate,
//       duration: const Duration(milliseconds: 300),
//       delay: const Duration(milliseconds: 300),
//       child: SizedBox(
//         width: screenSize.width * 0.92,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(bottom: 3, left: 5),
//               child: Text(
//                 widget.lable ?? "",
//                 style: size14(fontColor: ColorUtils.whiteColor),
//               ),
//             ),
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: Center(
//                 child: IntlPhoneField(
//                   showCountryFlag: true,
//                   initialCountryCode: widget.initialCountryCode,
//                   showDropdownIcon: false,
//                   controller: widget.controller,
//                   initialValue: widget.initialCountryCode,
//                   onChanged: widget.onPhoneNumberTap ?? (value) {},
//                   onCountryChanged: widget.onCountryTap ?? (value) {},
//                   flagsButtonPadding: const EdgeInsets.only(left: 16),
//                   decoration: InputDecoration(
//                     isDense: true,
//                     fillColor: ColorUtils.oxffFFFFFF,
//                     filled: true,
//                     counterStyle: size14(fontColor: ColorUtils.oxffFFFFFF),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15),
//                       borderSide: BorderSide(
//                         color: ColorUtils.oxffE6E6E6,
//                         width: 2.5,
//                       ),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15),
//                       borderSide: BorderSide(
//                         color: ColorUtils.oxffE6E6E6,
//                         width: 2.5,
//                       ),
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15),
//                       borderSide: BorderSide(
//                         color: ColorUtils.oxffE6E6E6,
//                         width: 2.5,
//                       ),
//                     ),
//                     hintText: widget.hintText,
//                     hintStyle: size16(fontColor: ColorUtils.oxff858494, fw: FW.medium),
//                     errorStyle: size12(
//                       fontColor: ColorUtils.whiteColor,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
