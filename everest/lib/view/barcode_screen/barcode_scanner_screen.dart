import 'dart:async';
import 'dart:io';
import 'package:everest/utils/colors.dart';
import 'package:everest/utils/common_styles.dart';
import 'package:everest/view/barcode_screen/barcode_provider.dart';
import 'package:everest/view/home_screen/home_provider.dart';
import 'package:everest/widgets/LoadingWidget.dart';
import 'package:everest/widgets/custom_images/asset_utils.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

class BarcodeScanScreen extends StatefulWidget {
  const BarcodeScanScreen({Key? key}) : super(key: key);

  @override
  State<BarcodeScanScreen> createState() => _BarcodeScanScreenState();
}

class _BarcodeScanScreenState extends State<BarcodeScanScreen> {
  String? barcodeResult;
  Timer? debounceTimer;

  @override
  void initState() {
    // final barcodeProvider = Provider.of<BarcodeProvider>(context, listen: false);
    // barcodeProvider.getItemByBarcodeApiResponse(context: context, barcode: "07622201500054");
    super.initState();
  }

  String? lastScannedBarcode;
  bool isApiCallInProgress = false;

  void handleBarcodeDetection(String barcode) {
    // If the barcode is the same or an API call is in progress, return early
    final barcodeProvider = Provider.of<BarcodeProvider>(context, listen: false);
    if (barcode == lastScannedBarcode || isApiCallInProgress) {
      return;
    }

    // Set the last scanned barcode
    lastScannedBarcode = barcode;
    isApiCallInProgress = true;

    // Start a timer to reset the API call state after a delay
    debounceTimer?.cancel(); // Cancel any existing timer
    debounceTimer = Timer(Duration(seconds: 2), () {
      lastScannedBarcode = null; // Reset after timeout
      isApiCallInProgress = false; // Mark API call as complete
    });

    // Make your API call
    barcodeProvider
        .getItemByBarcodeApiResponse(
      context: context,
      barcode: barcode,
    )
        .then((_) {
      // Reset the API call state if successful
      isApiCallInProgress = false;
    }).catchError((error) {
      // Handle error and reset the state
      print('API call error: $error');
      isApiCallInProgress = false;
    });
  }

  // void handleBarcodeDetection(String barcode) {
  //   final barcodeProvider = Provider.of<BarcodeProvider>(context, listen: false);
  //   if (barcode == lastScannedBarcode || isApiCallInProgress) {
  //     return; // Prevent duplicates and ongoing calls
  //   }

  //   // Update state
  //   lastScannedBarcode = barcode;
  //   isApiCallInProgress = true;

  //   // Make your API call
  //   barcodeProvider.getItemByBarcodeApiResponse(context: context, barcode: barcode).then((_) {
  //     // Reset the state after the API call completes
  //     isApiCallInProgress = false;
  //   }).catchError((error) {
  //     // Handle error if needed
  //     isApiCallInProgress = false;
  //   });
  // }

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
      body: Consumer2(builder: (context, HomeProvider provider, BarcodeProvider barcodeProvider, _) {
        final scannedProduct = barcodeProvider.scannedProduct;
        barcodeProvider.productsToShow = scannedProduct != null
            ? provider.categoryList.where((product) => product.itemCode == scannedProduct.itemCode).toList()
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
                  child: MobileScanner(
                    onDetect: (barcode) {
                      setState(() {
                        barcodeResult = barcode.barcodes[0].rawValue;
                        if (barcodeResult != null) {
                          handleBarcodeDetection(barcodeResult.toString());
                        }
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              barcodeProvider.productsToShow.isEmpty
                  ? Center(
                      child: Text("Item not found"),
                    )
                  : Expanded(
                      child: CircularProgressIndicatorWidget(
                        visible: false, // barcodeProvider.isLoading,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ListView.builder(
                                itemCount: barcodeProvider.productsToShow.length,
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final product = barcodeProvider.productsToShow[index];
                                  if (product.itemCode == barcodeProvider.scannedProduct?.itemCode) {}
                                  final quantity = provider.basket[product] ?? 0;
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
                                              ? Row(
                                                  children: [
                                                    IconButton(
                                                      icon: Icon(Icons.remove, color: quantity > 0 ? Colors.red : Colors.grey),
                                                      onPressed: quantity > 0 ? () => provider.removeFromBasket(product) : null,
                                                    ),
                                                    Text('$quantity'),
                                                    IconButton(
                                                      icon: Icon(Icons.add, color: Colors.green),
                                                      onPressed: () => provider.addToBasket(product),
                                                    ),
                                                  ],
                                                )
                                              : GestureDetector(
                                                  onTap: () => provider.addToBasket(product),
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
                              )
                            ],
                          ),
                        ),
                      ),
                    )
            ],
          ),
        );
      }),
    );
  }
}
