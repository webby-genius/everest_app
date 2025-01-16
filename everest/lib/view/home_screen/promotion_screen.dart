import 'package:everest/apis/models/product_item_model.dart';
import 'package:everest/utils/colors.dart';
import 'package:everest/utils/common_styles.dart';
import 'package:everest/view/home_screen/home_provider.dart';
import 'package:everest/widgets/bounce_click_widget.dart';
import 'package:everest/widgets/custom_images/asset_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PromotionScreen extends StatefulWidget {
  List<ProductItemResponse> categoryList;
  Map<ProductItemResponse, int> basket;
  PromotionScreen({super.key, required this.categoryList, required this.basket});

  @override
  State<PromotionScreen> createState() => _PromotionScreenState();
}

class _PromotionScreenState extends State<PromotionScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, _) {
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 210, // Fixed max width for the card
            childAspectRatio: 0.640, // Adjust to maintain the desired aspect ratio (height/width)
            mainAxisSpacing: 10, // Space between rows
            crossAxisSpacing: 10, // Space between columns
          ),
          itemCount: widget.categoryList.length,
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemBuilder: (context, index) {
            final product = widget.categoryList[index];
            final quantity = widget.basket[product] ?? 0;

            return Container(
              width: 210, // Fixed width for the card
              height: 290, // Fixed height for the card (adjust as needed)
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
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image section
                  Container(
                    width: double.infinity, // Ensure the image takes the full width of the card
                    height: 150, // Fixed height for the image (adjust as needed)
                    child: product.itemImage != 0
                        ? networkPngUtils(
                            networkImage: product.itemImage.toString(),
                            height: 150,
                            width: 150,
                          )
                        : assetPngUtils(
                            assetImage: "assets/image/everest_wholesale logo.png",
                            height: 150,
                            width: 160,
                          ),
                  ),
                  SizedBox(height: 8), // Space between image and text

                  // Product details
                  Text(
                    product.itemName ?? '',
                    style: size13(fw: FW.medium),
                    overflow: TextOverflow.ellipsis, // Ensures text doesn't overflow
                    maxLines: 1, // Limit to 1 line to avoid overflow
                  ),
                  Text(
                    "PRICE: £${product.salePrice}",
                    style: size12(fw: FW.medium, fontColor: ColorUtils.primaryColor),
                    overflow: TextOverflow.ellipsis, // Ensures text doesn't overflow
                    maxLines: 1, // Limit to 1 line
                  ),
                  Text(
                    "PLU Code: ${product.pluCode}",
                    style: size12(fw: FW.medium),
                    overflow: TextOverflow.ellipsis, // Ensures text doesn't overflow
                    maxLines: 1, // Limit to 1 line
                  ),
                  SizedBox(height: 5), // Space between price and quantity/add-to-basket button

                  // Quantity or Add to Basket button
                  if (quantity > 0) ...{
                    PromotionProductQtyWidget(product: product, provider: provider)
                  } else ...{
                    BounceClickWidget(
                      onTap: () => provider.addToBasket(product),
                      child: Container(
                        color: ColorUtils.successColor,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                            child: Text(
                              "Add to Basket",
                              style: size13(fw: FW.bold, fontColor: ColorUtils.whiteColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  }
                ],
              ),
            );
          },
        );
      },
    );
  }
}

// class _PromotionScreenState extends State<PromotionScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer(builder: (context, HomeProvider provider, _) {
//       return GridView.builder(
//         gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//           maxCrossAxisExtent: 210,
//           childAspectRatio: 0.65,
//           mainAxisSpacing: 10,
//           crossAxisSpacing: 10,
//         ),
//         itemCount: widget.categoryList.length,
//         padding: EdgeInsets.zero,
//         shrinkWrap: true,
//         physics: ClampingScrollPhysics(),
//         itemBuilder: (context, index) {
//           final product = widget.categoryList[index];
//           final quantity = widget.basket[product] ?? 0;
//           return Container(
//             decoration: BoxDecoration(
//               color: ColorUtils.whiteColor,
//               // color: ColorUtils.blackColor40,
//               boxShadow: const [
//                 BoxShadow(offset: Offset(1, 0), blurRadius: 9, spreadRadius: 0.5, color: Colors.black12),
//               ],
//             ),
//             padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 product.itemImage != 0
//                     ? networkPngUtils(networkImage: product.itemImage.toString(), height: 150, width: 150)
//                     : assetPngUtils(assetImage: "assets/image/everest_wholesale logo.png", height: 150, width: 160),
//                 Spacer(),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(product.itemName ?? '', style: size13(fw: FW.medium)),
//                     Text("PRICE: £${product.salePrice}", style: size12(fw: FW.medium, fontColor: ColorUtils.primaryColor)),
//                     Text("PLU Code: ${product.pluCode}", style: size12(fw: FW.medium)),
//                     SizedBox(height: 5),
//                     if (quantity > 0) ...{
//                       PromotionProductQtyWidget(product: product, provider: provider)
//                       // Container(
//                       //   // decoration: BoxDecoration(border: Border.all()),
//                       //   width: 140,
//                       //   child: Row(
//                       //     mainAxisAlignment: MainAxisAlignment.center,
//                       //     children: [
//                       //       IconButton(
//                       //         icon: Icon(Icons.remove, color: quantity > 0 ? Colors.red : Colors.grey),
//                       //         onPressed: quantity > 0 ? () => provider.removeFromBasket(product) : null,
//                       //       ),
//                       //       Text('$quantity'),
//                       //       IconButton(
//                       //         icon: Icon(Icons.add, color: Colors.green),
//                       //         onPressed: () => provider.addToBasket(product),
//                       //       ),
//                       //     ],
//                       //   ),
//                       // )
//                     } else ...{
//                       BounceClickWidget(
//                         onTap: () => provider.addToBasket(product),
//                         child: Container(
//                           color: ColorUtils.successColor,
//                           child: Center(
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
//                               child: Text(
//                                 "Add to Basket",
//                                 style: size13(fw: FW.bold, fontColor: ColorUtils.whiteColor),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     }
//                   ],
//                 ),
//               ],
//             ),
//           );
//         },
//       );
//     });
//   }
// }

class PromotionProductQtyWidget extends StatefulWidget {
  final ProductItemResponse product;
  final HomeProvider provider;

  PromotionProductQtyWidget({
    required this.product,
    required this.provider,
  });

  @override
  _PromotionProductQtyWidgetState createState() => _PromotionProductQtyWidgetState();
}

class _PromotionProductQtyWidgetState extends State<PromotionProductQtyWidget> {
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
                // Try to parse the entered quantity
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
              child: Text(
                "Save",
                style: size14(fontColor: ColorUtils.darkChatBubbleColor),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, provider, _) {
      // Quantity is either from basket or 0
      final quantity = provider.basket[widget.product] ?? 0;

      return Container(
        height: 37,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.remove, color: quantity > 0 ? Colors.red : Colors.grey),
              onPressed: quantity > 0
                  ? () {
                      // Decrease quantity logic
                      provider.removeFromBasket(widget.product);
                    }
                  : null,
            ),
            GestureDetector(
              onTap: _openQuantityDialog, // Open the dialog box to manually edit quantity
              child: Container(
                width: 35,
                child: Text(
                  '$quantity',
                  style: size13(),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.add, color: Colors.green),
              onPressed: () {
                // Increase quantity logic
                provider.addToBasket(widget.product);
              },
            ),
          ],
        ),
      );
    });
  }
}
