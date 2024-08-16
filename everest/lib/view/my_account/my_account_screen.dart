import 'package:everest/utils/colors.dart';
import 'package:everest/utils/common_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

class MyAccountScreen extends StatefulWidget {
  AdvancedDrawerController advancedDrawerController;
  MyAccountScreen({super.key, required this.advancedDrawerController});

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtils.darkChatBubbleColor,
        leading: TextButton(
          onPressed: () {
            widget.advancedDrawerController.showDrawer();
          },
          child: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: widget.advancedDrawerController,
              builder: (context, value, _) {
                return Icon(
                  value.visible ? Icons.clear : Icons.menu,
                  key: ValueKey<bool>(value.visible),
                  color: Colors.white,
                );
              }),
        ),
        title: Text(
          "My Account",
          style: size20(fontColor: ColorUtils.whiteColor, fw: FW.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text("Business Name", style: size20(fw: FW.bold)),
            Container(
              decoration: BoxDecoration(
                color: ColorUtils.whiteColor,
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 1),
                    blurRadius: 12,
                    spreadRadius: 0.5,
                    color: Colors.black26,
                  ),
                ],
                border: Border.all(),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Shipping Address", style: size20(fw: FW.bold)),
                  SizedBox(height: 10),
                  Text("Contact Person", style: size15(fw: FW.medium)),
                  Text("Company Name", style: size15(fw: FW.medium)),
                  Text("Street Address", style: size15(fw: FW.medium)),
                  Text("Town/City, Country/Region", style: size15(fw: FW.medium)),
                  Text("Postcode", style: size15(fw: FW.medium)),
                  Text("Phone Number", style: size15(fw: FW.medium)),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: ColorUtils.whiteColor,
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 1),
                    blurRadius: 12,
                    spreadRadius: 0.5,
                    color: Colors.black26,
                  ),
                ],
                border: Border.all(),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Billing Address", style: size20(fw: FW.bold)),
                  SizedBox(height: 10),
                  Text("Contact Person", style: size15(fw: FW.medium)),
                  Text("Company Name", style: size15(fw: FW.medium)),
                  Text("Street Address", style: size15(fw: FW.medium)),
                  Text("Town/City, Country/Region", style: size15(fw: FW.medium)),
                  Text("Postcode", style: size15(fw: FW.medium)),
                  Text("Phone Number", style: size15(fw: FW.medium)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
