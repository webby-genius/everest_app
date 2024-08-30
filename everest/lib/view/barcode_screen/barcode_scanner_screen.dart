import 'dart:io';
import 'package:everest/utils/colors.dart';
import 'package:everest/utils/common_styles.dart';
import 'package:everest/view/barcode_screen/barcode_provider.dart';
import 'package:everest/view/home_screen/home_provider.dart';
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

  @override
  void initState() {
    final barcodeProvider = Provider.of<BarcodeProvider>(context, listen: false);
    barcodeProvider.getItemByBarcodeApiResponse(context: context, barcode: "07622201500054");
    super.initState();
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
      body: Consumer2(builder: (context, HomeProvider provider, BarcodeProvider barcodeProvider, _) {
        final scannedProduct = barcodeProvider.scannedProduct;
        final productsToShow = scannedProduct != null
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
                          barcodeProvider.getItemByBarcodeApiResponse(context: context, barcode: "07622201499662");
                        }
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
                      ListView.builder(
                        itemCount: productsToShow.length,
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final product = productsToShow[index];
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
                                      Text("PRICE: ${product.salePrice}",
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
              )
            ],
          ),
        );
      }),
    );
  }
}
