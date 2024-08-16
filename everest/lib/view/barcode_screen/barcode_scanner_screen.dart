import 'dart:io';
import 'package:everest/utils/colors.dart';
import 'package:everest/utils/common_styles.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class BarcodeScanScreen extends StatefulWidget {
  const BarcodeScanScreen({Key? key}) : super(key: key);

  @override
  State<BarcodeScanScreen> createState() => _BarcodeScanScreenState();
}

class _BarcodeScanScreenState extends State<BarcodeScanScreen> {
  String? barcodeResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtils.darkChatBubbleColor,
        title: Text(
          "Search Product",
          style: size20(fw: FW.bold, fontColor: ColorUtils.whiteColor),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Platform.isIOS ? Icons.arrow_back_ios_new_outlined : Icons.arrow_back_sharp,
            color: ColorUtils.whiteColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(height: 15),
            Container(
              width: double.infinity,
              height: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                border: Border.all(),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: MobileScanner(
                  onDetect: (barcode) {
                    setState(() {
                      barcodeResult = barcode.barcodes[0].rawValue;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      barcodeResult != null ? "Product Found: $barcodeResult" : "No Product Found.",
                      style: size15(fw: FW.medium),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
