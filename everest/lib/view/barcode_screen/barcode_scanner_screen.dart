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
import 'package:flutter/widgets.dart';
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
                                                // Row(
                                                //     children: [
                                                //       IconButton(
                                                //         icon: Icon(Icons.remove, color: quantity > 0 ? Colors.red : Colors.grey),
                                                //         onPressed: quantity > 0 ? () => homeProvider.removeFromBasket(product) : null,
                                                //       ),
                                                //       Text('$quantity'),
                                                //       IconButton(
                                                //         icon: Icon(Icons.add, color: Colors.green),
                                                //         onPressed: () => homeProvider.addToBasket(product),
                                                //       ),
                                                //     ],
                                                //   )
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

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, provider, _) {
      // Check if the text field is empty or invalid
      String inputValue = _quantityController.text.trim();
      bool isValidQuantity = int.tryParse(inputValue) != null && int.tryParse(inputValue)! > 0;

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.remove, color: provider.basket[widget.product]! > 0 ? Colors.red : Colors.grey),
            onPressed: provider.basket[widget.product]! > 0
                ? () {
                    // Decrease quantity logic
                    provider.removeFromBasket(widget.product);
                    // Update text field after decreasing quantity
                    _quantityController.text = '${provider.basket[widget.product] ?? 0}';
                  }
                : null,
          ),
          // The TextField that handles manual input of quantity
          Container(
            width: 28,
            child: TextField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: size13(),
              showCursor: true,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                isDense: true,
              ),
              onChanged: (value) {
                // If the value is valid, set the quantity, otherwise set to 0
                final newQuantity = int.tryParse(value);
                if (newQuantity != null && newQuantity > 0) {
                  provider.setQuantity(widget.product, newQuantity);
                } else if (value.isEmpty) {
                  provider.setQuantity(widget.product, 0);
                }
              },
              onSubmitted: (value) {
                final newQuantity = int.tryParse(value);
                if (newQuantity != null && newQuantity > 0) {
                  provider.setQuantity(widget.product, newQuantity);
                } else if (value.isEmpty) {
                  provider.setQuantity(widget.product, 0);
                }
              },
            ),
          ),
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.add, color: Colors.green),
            ),
            onTap: isValidQuantity
                ? () {
                    // Add to basket if quantity is valid
                    provider.addToBasket(widget.product);
                    // Update the text field after adding to the basket
                    _quantityController.text = '${provider.basket[widget.product] ?? 0}';
                  }
                : null, // Disable button if quantity is invalid
          ),
        ],
      );
    });
  }
}





// class BarcodeScanScreen extends StatefulWidget {
//   const BarcodeScanScreen({Key? key}) : super(key: key);

//   @override
//   State<BarcodeScanScreen> createState() => _BarcodeScanScreenState();
// }

// class _BarcodeScanScreenState extends State<BarcodeScanScreen> {
//   String? barcodeResult;
//   bool isScanningActive = true; // Control scanning state

//   @override
//   void initState() {
//     // final barcodeProvider = Provider.of<BarcodeProvider>(context, listen: false);
//     // barcodeProvider.getItemByBarcodeApiResponse(context: context, barcode: "07622201500054");
//     super.initState();
//   }

//   // void handleBarcodeDetection(String barcode) {
//   //   if (!isScanningActive) return; // Exit if scanning is not active

//   //   final barcodeProvider = Provider.of<BarcodeProvider>(context, listen: false);

//   //   // Cancel any existing timer
//   //   debounceTimer?.cancel();

//   //   // Start a new timer
//   //   debounceTimer = Timer(Duration(milliseconds: 1000), () {
//   //     // Make the API call after the delay
//   //     barcodeProvider.getItemByBarcodeApiResponse(context: context, barcode: barcode).then((_) {
//   //       // Stop scanning after a valid barcode is received
//   //       setState(() {
//   //         isScanningActive = false;
//   //       });
//   //     }).catchError((error) {
//   //       // Handle error if needed
//   //       print('API call error: $error');
//   //     });
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: ColorUtils.darkChatBubbleColor,
//         title: Text(
//           "Search Product",
//           style: size20(fw: FW.bold, fontColor: ColorUtils.whiteColor),
//         ),
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(
//             Platform.isIOS ? Icons.arrow_back_ios_new_outlined : Icons.arrow_back_sharp,
//             color: ColorUtils.whiteColor,
//           ),
//         ),
//       ),
//       body: Consumer2(builder: (context, HomeProvider provider, BarcodeProvider barcodeProvider, _) {
//         final scannedProduct = barcodeProvider.scannedProduct;
//         barcodeProvider.productsToShow = scannedProduct != null
//             ? provider.categoryList.where((product) => product.itemCode == scannedProduct.itemCode).toList()
//             : [];
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0),
//           child: Column(
//             children: [
//               SizedBox(height: 15),
//               Container(
//                 width: double.infinity,
//                 height: 220,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(40),
//                   border: Border.all(),
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(40),
//                   child: MobileScanner(
//                     onDetect: (barcode) {
//                       setState(() {
//                         barcodeResult = barcode.barcodes[0].rawValue;
//                         if (barcodeResult != null) {
//                           debugPrint("🥶🥶🥶🥶🥶 ->> $isScanningActive");
//                           if (isScanningActive) {
//                             isScanningActive = false;
//                             debugPrint("👛 ->> $isScanningActive");
//                             barcodeProvider.getItemByBarcodeApiResponse(
//                               context: context,
//                               barcode: barcodeResult.toString(),
//                             );
//                             Future.delayed(
//                               Duration(seconds: 4),
//                               () {
//                                 isScanningActive = true;
//                                 debugPrint("👛👛👛👛👛👛 ->> $isScanningActive");
//                               },
//                             );
//                           }
//                         }
//                       });
//                     },
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Expanded(
//                 child: CircularProgressIndicatorWidget(
//                   visible: barcodeProvider.isLoading,
//                   child: barcodeProvider.productsToShow.isNotEmpty
//                       ? SingleChildScrollView(
//                           child: Column(
//                             children: [
//                               ListView.builder(
//                                 itemCount: barcodeProvider.productsToShow.length,
//                                 padding: EdgeInsets.zero,
//                                 shrinkWrap: true,
//                                 physics: ClampingScrollPhysics(),
//                                 itemBuilder: (context, index) {
//                                   final product = barcodeProvider.productsToShow[index];
//                                   // if (product.itemCode == barcodeProvider.scannedProduct?.itemCode) {}
//                                   final quantity = provider.basket[product] ?? 0;
//                                   return Container(
//                                     decoration: BoxDecoration(
//                                       color: ColorUtils.whiteColor,
//                                       boxShadow: const [
//                                         BoxShadow(
//                                           offset: Offset(1, 0),
//                                           blurRadius: 9,
//                                           spreadRadius: 0.5,
//                                           color: Colors.black12,
//                                         ),
//                                       ],
//                                     ),
//                                     padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
//                                     child: Row(
//                                       children: [
//                                         product.itemImage != 0
//                                             ? assetPngUtils(assetImage: product.itemImage.toString(), height: 70, width: 70)
//                                             : SizedBox(),
//                                         Expanded(
//                                           flex: 5,
//                                           child: Column(
//                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                             children: [
//                                               Text(product.itemName ?? '', style: size14(fw: FW.medium)),
//                                               Text("PRICE: £${product.salePrice}",
//                                                   style: size12(fw: FW.medium, fontColor: ColorUtils.primaryColor)),
//                                               Text("PLU Code: ${product.pluCode}", style: size12(fw: FW.medium)),
//                                             ],
//                                           ),
//                                         ),
//                                         Expanded(
//                                           flex: 3,
//                                           child: quantity > 0
//                                               ? Row(
//                                                   children: [
//                                                     IconButton(
//                                                       icon: Icon(Icons.remove, color: quantity > 0 ? Colors.red : Colors.grey),
//                                                       onPressed: quantity > 0 ? () => provider.removeFromBasket(product) : null,
//                                                     ),
//                                                     Text('$quantity'),
//                                                     IconButton(
//                                                       icon: Icon(Icons.add, color: Colors.green),
//                                                       onPressed: () => provider.addToBasket(product),
//                                                     ),
//                                                   ],
//                                                 )
//                                               : GestureDetector(
//                                                   onTap: () => provider.addToBasket(product),
//                                                   child: Container(
//                                                     color: ColorUtils.successColor,
//                                                     child: Center(
//                                                       child: Padding(
//                                                         padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
//                                                         child: Text(
//                                                           "Add to Basket",
//                                                           style: size13(fw: FW.bold, fontColor: ColorUtils.whiteColor),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 },
//                               )
//                             ],
//                           ),
//                         )
//                       : SizedBox(),
//                 ),
//               )
//             ],
//           ),
//         );
//       }),
//     );
//   }
// }
