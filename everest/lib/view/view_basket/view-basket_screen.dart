import 'package:everest/utils/colors.dart';
import 'package:everest/utils/common_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

// class ViewBasketScreen extends StatefulWidget {
//   AdvancedDrawerController advancedDrawerController;
//   ViewBasketScreen({super.key, required this.advancedDrawerController});

//   @override
//   State<ViewBasketScreen> createState() => _ViewBasketScreenState();
// }

// class _ViewBasketScreenState extends State<ViewBasketScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: ColorUtils.darkChatBubbleColor,
//         leading: TextButton(
//           onPressed: () {
//             widget.advancedDrawerController.showDrawer();
//           },
//           child: ValueListenableBuilder<AdvancedDrawerValue>(
//               valueListenable: widget.advancedDrawerController,
//               builder: (context, value, _) {
//                 return Icon(
//                   value.visible ? Icons.clear : Icons.menu,
//                   key: ValueKey<bool>(value.visible),
//                   color: Colors.white,
//                 );
//               }),
//         ),
//         title: Text(
//           "Basket",
//           style: size20(fontColor: ColorUtils.whiteColor, fw: FW.bold),
//         ),
//       ),
//     );
//   }
// }
