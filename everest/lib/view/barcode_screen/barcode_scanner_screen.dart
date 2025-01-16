import 'dart:async';
import 'dart:io';
import 'package:everest/apis/models/product_item_model.dart';
import 'package:everest/utils/colors.dart';
import 'package:everest/utils/common_styles.dart';
import 'package:everest/view/barcode_screen/barcode_provider.dart';
import 'package:everest/view/home_screen/home_provider.dart';
import 'package:everest/widgets/LoadingWidget.dart';
import 'package:everest/widgets/custom_images/asset_utils.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';

class BarcodeScanScreen extends StatefulWidget {
  const BarcodeScanScreen({Key? key}) : super(key: key);

  @override
  State<BarcodeScanScreen> createState() => _BarcodeScanScreenState();
}

class _BarcodeScanScreenState extends State<BarcodeScanScreen> {
  String? barcodeResult;
  bool isScanningActive = true; // Control scanning state
  double scanningLinePosition = 0.0; // Control position of the scanning line
  late Timer scanningLineTimer;
  bool showScanningLine = true; // Control visibility of the scanning line

  @override
  void initState() {
    super.initState();
    startScanningLineAnimation();
  }

  void startScanningLineAnimation() {
    scanningLineTimer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      if (showScanningLine) {
        setState(() {
          scanningLinePosition += 5; // Move the line down
          if (scanningLinePosition > 220) {
            // Reset when it goes beyond the container height
            scanningLinePosition = 0.0;
          }
        });
      }
    });
  }

  @override
  void dispose() {
    scanningLineTimer.cancel(); // Stop the timer when disposing
    super.dispose();
  }

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
      body: Consumer2<HomeProvider, BarcodeProvider>(
        builder: (context, homeProvider, barcodeProvider, _) {
          final scannedProduct = barcodeProvider.scannedProduct;
          barcodeProvider.productsToShow = scannedProduct != null
              ? homeProvider.categoryList.where((product) => product.itemCode == scannedProduct.itemCode).toList()
              : [];

          return Padding(
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
                    child: Stack(
                      children: [
                        MobileScanner(
                          onDetect: (barcode) {
                            setState(() {
                              barcodeResult = barcode.barcodes[0].rawValue;
                              if (barcodeResult != null && isScanningActive) {
                                isScanningActive = false;
                                showScanningLine = false; // Hide the scanning line

                                // Provide vibration feedback
                                Vibration.vibrate(duration: 500); // Vibrate for 500ms

                                barcodeProvider.getItemByBarcodeApiResponse(
                                  context: context,
                                  barcode: barcodeResult!,
                                );

                                Future.delayed(
                                  Duration(seconds: 4), // Delay before reactivating scanning
                                  () {
                                    isScanningActive = true;
                                    showScanningLine = true; // Show scanning line again
                                  },
                                );
                              }
                            });
                          },
                        ),
                        // Moving scanning line
                        AnimatedPositioned(
                          duration: Duration(milliseconds: 50),
                          top: scanningLinePosition,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 4,
                            color: Colors.green, // Customize the line color
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: CircularProgressIndicatorWidget(
                    visible: barcodeProvider.isLoading,
                    child: barcodeProvider.productsToShow.isNotEmpty
                        ? SingleChildScrollView(
                            child: Column(
                              children: [
                                ListView.builder(
                                  itemCount: barcodeProvider.productsToShow.length,
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final product = barcodeProvider.productsToShow[index];
                                    final quantity = homeProvider.basket[product] ?? 0;
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: ColorUtils.whiteColor,
                                        boxShadow: const [
                                          BoxShadow(
                                            offset: Offset(1, 0),
                                            blurRadius: 9,
                                            spreadRadius: 0.5,
                                            color: Colors.black12,
                                          ),
                                        ],
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                      child: Row(
                                        children: [
                                          product.itemImage != 0
                                              ? assetPngUtils(assetImage: product.itemImage.toString(), height: 70, width: 70)
                                              : SizedBox(),
                                          Expanded(
                                            flex: 5,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(product.itemName ?? '', style: size14(fw: FW.medium)),
                                                Text("PRICE: £${product.salePrice}",
                                                    style: size12(fw: FW.medium, fontColor: ColorUtils.primaryColor)),
                                                Text("PLU Code: ${product.pluCode}", style: size12(fw: FW.medium)),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: quantity > 0
                                                ? BarcodeProductQtyWidget(product: product, provider: homeProvider)
                                                : GestureDetector(
                                                    onTap: () => homeProvider.addToBasket(product),
                                                    child: Container(
                                                      color: ColorUtils.successColor,
                                                      child: Center(
                                                        child: Padding(
                                                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                                                          child: Text(
                                                            "Add to Basket",
                                                            style: size13(fw: FW.bold, fontColor: ColorUtils.whiteColor),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          )
                        : SizedBox(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class BarcodeProductQtyWidget extends StatefulWidget {
  final ProductItemResponse product;
  final HomeProvider provider;

  BarcodeProductQtyWidget({
    required this.product,
    required this.provider,
  });

  @override
  _BarcodeProductQtyWidgetState createState() => _BarcodeProductQtyWidgetState();
}

class _BarcodeProductQtyWidgetState extends State<BarcodeProductQtyWidget> {
  late TextEditingController _quantityController;

  @override
  void initState() {
    super.initState();
    // Initialize the TextEditingController with the current quantity
    _quantityController = TextEditingController(text: '${widget.provider.basket[widget.product] ?? 0}');
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed
    _quantityController.dispose();
    super.dispose();
  }

  void _openQuantityDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // Disable dismissing the dialog by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Enter Quantity"),
          backgroundColor: ColorUtils.whiteColor,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _quantityController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: "Enter quantity",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  // Optionally, you can validate the input as the user types
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                final newQuantity = int.tryParse(_quantityController.text);
                if (newQuantity != null && newQuantity > 0) {
                  widget.provider.setQuantity(widget.product, newQuantity);
                  Navigator.of(context).pop(); // Close the dialog after saving
                } else {
                  // Show error if invalid input
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please enter a valid quantity")),
                  );
                }
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, provider, _) {
      final quantity = provider.basket[widget.product] ?? 0;

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.remove, color: quantity > 0 ? Colors.red : Colors.grey),
            onPressed: quantity > 0
                ? () {
                    // Decrease quantity logic
                    provider.removeFromBasket(widget.product);
                    _quantityController.text = '${provider.basket[widget.product] ?? 0}';
                  }
                : null,
          ),
          // GestureDetector to open the dialog when tapping on quantity
          GestureDetector(
            onTap: _openQuantityDialog, // Open dialog when tapped
            child: Container(
              width: 28,
              child: Text(
                '$quantity',
                style: size13(),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.add, color: Colors.green),
            ),
            onTap: quantity > 0
                ? () {
                    // Add to basket if quantity is valid
                    provider.addToBasket(widget.product);
                    _quantityController.text = '${provider.basket[widget.product] ?? 0}';
                  }
                : null, // Disable button if quantity is invalid
          ),
        ],
      );
    });
  }
}