import 'package:everest/apis/models/product_item_model.dart';
import 'package:everest/utils/colors.dart';
import 'package:everest/utils/common_styles.dart';
import 'package:everest/view/checkout_screen/checkout_provider.dart';
import 'package:everest/view/dashboard_screen/dashboard_screen.dart';
import 'package:everest/view/home_screen/home_provider.dart';
import 'package:everest/widgets/LoadingWidget.dart';
import 'package:everest/widgets/bounce_click_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';

class OrderSummaryScreen extends StatefulWidget {
  final Map<ProductItemResponse, int> basket;
  bool isDrawerScreen;
  AdvancedDrawerController? advancedDrawerController;

  OrderSummaryScreen({
    required this.basket,
    this.isDrawerScreen = false,
    this.advancedDrawerController,
  });

  @override
  State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  double subtotal = 0.0;

  @override
  void initState() {
    super.initState();
    calculateSubtotal(); // Initial subtotal calculation
  }

  void calculateSubtotal() {
    subtotal = 0.0; // Reset subtotal
    for (var entry in widget.basket.entries) {
      final product = entry.key;
      final quantity = entry.value;
      final itemPrice = product.salePrice ?? 0.0;
      subtotal += itemPrice * quantity; // Calculate subtotal
    }
    setState(() {}); // Trigger rebuild to update UI
  }

  @override
  Widget build(BuildContext context) {
    // Ensure that the basket is not empty before building the ListView
    if (widget.basket.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Your Order', style: size20(fw: FW.bold, fontColor: ColorUtils.whiteColor)),
          backgroundColor: Color(0xFF2B3990),
          leading: widget.isDrawerScreen
              ? TextButton(
                  onPressed: () {
                    widget.advancedDrawerController?.showDrawer();
                  },
                  child: ValueListenableBuilder<AdvancedDrawerValue>(
                      valueListenable: widget.advancedDrawerController!,
                      builder: (context, value, _) {
                        return Icon(value.visible ? Icons.clear : Icons.menu,
                            key: ValueKey<bool>(value.visible), color: Colors.white, size: 30);
                      }),
                )
              : IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios, color: ColorUtils.whiteColor),
                ),
        ),
        body: Center(child: Text("Your basket is empty.")),
      );
    }

    double total = 0.0;

    // Calculate subtotal for each item in the basket
    // for (var entry in widget.basket.entries) {
    //   final product = entry.key;
    //   final quantity = entry.value;
    //   final itemPrice = product.salePrice ?? 0.0; // Assuming price is a property in ProductItemResponse
    //   subtotal += itemPrice * quantity; // Add to subtotal
    // }

    total = subtotal; // If there are no additional charges, total is equal to subtotal

    return Consumer2(builder: (context, CheckOutProvider provider, HomeProvider homeProvider, _) {
      return CircularProgressIndicatorWidget(
        visible: provider.isLoading,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Your Order', style: size20(fw: FW.bold, fontColor: ColorUtils.whiteColor)),
            backgroundColor: Color(0xFF2B3990),
            leading: widget.isDrawerScreen
                ? TextButton(
                    onPressed: () {
                      widget.advancedDrawerController?.showDrawer();
                    },
                    child: ValueListenableBuilder<AdvancedDrawerValue>(
                        valueListenable: widget.advancedDrawerController!,
                        builder: (context, value, _) {
                          return Icon(value.visible ? Icons.clear : Icons.menu,
                              key: ValueKey<bool>(value.visible), color: Colors.white, size: 30);
                        }),
                  )
                : IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios, color: ColorUtils.whiteColor),
                  ),
          ),
          bottomNavigationBar: Container(
            height: 150,
            child: BottomButtons(
              continueShoppingOnTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DashBoardScreen(),
                    ),
                    (route) => false);
              },
              proceedToOrderOnTap: () {},
              saveOrderOnTap: () {
                // Prepare the order items for the API call
                List<Map<String, dynamic>> orderItems = widget.basket.entries.map((entry) {
                  final product = entry.key;
                  final quantity = entry.value;
                  return {
                    'itemId': product.itemId, // Assuming 'id' is the property that contains the item ID
                    'quantity': quantity,
                  };
                }).toList();
                provider.checkOutSaveApiResponse(
                  context: context,
                  orderItems: orderItems,
                );
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                children: [
                  ListView.builder(
                    itemCount: widget.basket.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final product = widget.basket.keys.elementAt(index);
                      final quantity = widget.basket[product] ?? 0;
                      final itemPrice = product.salePrice ?? 0.0;
                      final itemTotal = itemPrice * quantity; // Calculate total for the item

                      // Ensure that the quantity is non-negative before building the ListTile
                      if (quantity <= 0) {
                        return Container(); // Skip this item if the quantity is 0
                      }

                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          product.itemName ?? '',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Row(
                          children: [
                            Text("Qty: $quantity"),
                            SizedBox(width: 5),
                            Text("|"),
                            SizedBox(width: 5),
                            Text(
                              'Total: £${itemTotal.toStringAsFixed(2)}',
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  if (quantity > 0) {
                                    // widget.basket[product] = quantity - 1;
                                    // if (widget.basket[product] == 0) {
                                    //   widget.basket.remove(product); // Remove item if quantity is 0
                                    // }
                                    homeProvider.removeFromBasket(product);
                                    calculateSubtotal(); // Recalculate subtotal on change
                                    (context as Element).markNeedsBuild(); // Force rebuild to reflect changes
                                  }
                                });
                              },
                            ),
                            Text(quantity.toString()),
                            IconButton(
                              icon: Icon(Icons.add, color: Colors.green),
                              onPressed: () {
                                setState(() {
                                  // widget.basket[product] = quantity + 1;
                                  homeProvider.addToBasket(product);
                                  calculateSubtotal(); // Recalculate subtotal on change
                                  (context as Element).markNeedsBuild(); // Force rebuild to reflect changes
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Divider(color: ColorUtils.blackColor40),
                  SizedBox(height: 8),
                  SummaryRow(label: 'Subtotal', value: '£${subtotal.toStringAsFixed(2)}'),
                  SizedBox(height: 8),
                  Divider(color: ColorUtils.blackColor40),
                  SizedBox(height: 8),
                  SummaryRow(label: 'Total', value: '£${total.toStringAsFixed(2)}', isTotal: true),
                  SizedBox(height: 8),
                  Divider(color: ColorUtils.blackColor40),
                  DeliveryOptions(),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

// // Order Item Model
// class OrderItemModel {
//   String productName;
//   int quantity;
//   int itemId;
//   String price;

//   OrderItemModel({required this.productName, required this.quantity, required this.itemId, required this.price});

//   // Helper method to extract price as double
//   double get priceValue {
//     return double.tryParse(price.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0.0;
//   }

//   double get totalPrice => priceValue * quantity;
// }

// // Main Order Summary Screen
// class OrderSummaryScreen extends StatefulWidget {
//   bool isDrawerScreen;
//   ProductItemResponse? productItemResponse;
//   AdvancedDrawerController? advancedDrawerController;
//   final List<OrderItemModel> orderItems;

//   OrderSummaryScreen(
//       {Key? key, required this.orderItems, this.isDrawerScreen = false, this.advancedDrawerController, this.productItemResponse})
//       : super(key: key);

//   @override
//   State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
// }

// class _OrderSummaryScreenState extends State<OrderSummaryScreen> {

//   @override
//   Widget build(BuildContext context) {
//     return Consumer(builder: (context, CheckOutProvider provider, _) {
//       return CircularProgressIndicatorWidget(
//         visible: provider.isLoading,
//         child: Scaffold(
//           appBar: AppBar(
//             title: Text('Your Order', style: size20(fw: FW.bold, fontColor: ColorUtils.whiteColor)),
//             backgroundColor: Color(0xFF2B3990),
//             leading: widget.isDrawerScreen
//                 ? TextButton(
//                     onPressed: () {
//                       widget.advancedDrawerController?.showDrawer();
//                     },
//                     child: ValueListenableBuilder<AdvancedDrawerValue>(
//                         valueListenable: widget.advancedDrawerController!,
//                         builder: (context, value, _) {
//                           return Icon(value.visible ? Icons.clear : Icons.menu,
//                               key: ValueKey<bool>(value.visible), color: Colors.white, size: 30);
//                         }),
//                   )
//                 : IconButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     icon: Icon(Icons.arrow_back_ios, color: ColorUtils.whiteColor),
//                   ),
//           ),
//           body: OrderSummary(orderItems: widget.orderItems),
//           bottomNavigationBar: Container(
//             height: 150,
//             child: BottomButtons(
//               continueShoppingOnTap: () {},
//               proceedToOrderOnTap: () {},
//               saveOrderOnTap: () {
//                 provider.checkOutSaveApiResponse(context: context, orderItems: widget.orderItems);
//               },
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }

// // Order Summary Widget
// class OrderSummary extends StatelessWidget {
//   final List<OrderItemModel> orderItems;

//   OrderSummary({required this.orderItems});

//   @override
//   Widget build(BuildContext context) {
//     double subtotal = orderItems.fold(
//       0,
//       (sum, item) => sum + item.totalPrice,
//     );

//     double total = subtotal;

//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text("PRODUCT", style: size15(fw: FW.bold)),
//                 Text("SUBTOTAL", style: size15(fw: FW.bold)),
//               ],
//             ),
//             Divider(color: ColorUtils.blackColor40),
//             for (var item in orderItems)
//               OrderItem(
//                 productName: item.productName,
//                 quantity: item.quantity,
//                 totalPrice: item.totalPrice,
//                 item: item,
//                 onAdd: () => _addItem(context, item),
//                 onRemove: () => _removeItem(context, item),
//               ),
//             Divider(color: ColorUtils.blackColor40),
//             SizedBox(height: 8),
//             SummaryRow(label: 'Subtotal', value: '£${subtotal.toStringAsFixed(2)}'),
//             SizedBox(height: 8),
//             Divider(color: ColorUtils.blackColor40),
//             SizedBox(height: 8),
//             SummaryRow(label: 'Total', value: '£${total.toStringAsFixed(2)}', isTotal: true),
//             SizedBox(height: 8),
//             Divider(color: ColorUtils.blackColor40),
//             DeliveryOptions(),
//             // BottomButtons(), Uncomment this if needed
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Order Item Widget
// class OrderItem extends StatelessWidget {
//   final String productName;
//   final int quantity;
//   final double totalPrice;
//   final OrderItemModel item;
//   final VoidCallback onAdd;
//   final VoidCallback onRemove;

//   OrderItem({
//     required this.productName,
//     required this.quantity,
//     required this.totalPrice,
//     required this.item,
//     required this.onAdd,
//     required this.onRemove,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Consumer(builder: (context, HomeProvider provider, _) {
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             productName,
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Text("Qty: $quantity"),
//               Text('£${totalPrice.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.bold)),
//               Row(
//                 children: [
//                   IconButton(
//                     icon: Icon(Icons.remove, color: Colors.red),
//                     onPressed: quantity > 0 ? onRemove : null,
//                   ),
//                   Text('$quantity'),
//                   IconButton(
//                     icon: Icon(Icons.add, color: Colors.green),
//                     onPressed: onAdd,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           SizedBox(height: 8),
//         ],
//       );
//     });
//   }
// }

// Summary Row Widget
class SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;

  SummaryRow({required this.label, required this.value, this.isTotal = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? Colors.red : Colors.black,
          ),
        ),
      ],
    );
  }
}

// Delivery Options Widget
class DeliveryOptions extends StatefulWidget {
  @override
  _DeliveryOptionsState createState() => _DeliveryOptionsState();
}

class _DeliveryOptionsState extends State<DeliveryOptions> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, CheckOutProvider provider, _) {
      return Column(
        children: [
          RadioListTile(
            value: "1",
            title: Text('CLICK & COLLECT', style: size16(fw: FW.medium)),
            tileColor: ColorUtils.blackColor10,
            groupValue: provider.selectedOption,
            activeColor: ColorUtils.darkChatBubbleColor,
            onChanged: (value) {
              setState(() {
                provider.selectedOption = value!;
              });
            },
          ),
          SizedBox(height: 1),
          RadioListTile(
            value: "2",
            title: Text('DELIVERY ORDER', style: size16(fw: FW.medium)),
            groupValue: provider.selectedOption,
            activeColor: ColorUtils.darkChatBubbleColor,
            tileColor: ColorUtils.blackColor10,
            onChanged: (value) {
              setState(() {
                provider.selectedOption = value!;
              });
            },
          ),
        ],
      );
    });
  }
}

// Bottom Buttons Widget
class BottomButtons extends StatefulWidget {
  void Function()? continueShoppingOnTap;
  void Function()? saveOrderOnTap;
  void Function()? proceedToOrderOnTap;
  BottomButtons({
    super.key,
    required this.continueShoppingOnTap,
    required this.saveOrderOnTap,
    required this.proceedToOrderOnTap,
  });
  @override
  State<BottomButtons> createState() => _BottomButtonsState();
}

class _BottomButtonsState extends State<BottomButtons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: BounceClickWidget(
                onTap: widget.continueShoppingOnTap,
                child: Container(
                  height: 50,
                  margin: EdgeInsets.only(left: 5),
                  color: ColorUtils.darkChatBubbleColor,
                  child: Center(
                    child: Text('CONTINUE SHOPPING', style: size15(fw: FW.bold, fontColor: ColorUtils.whiteColor)),
                  ),
                ),
              ),
            ),
            SizedBox(width: 5),
            Expanded(
              child: BounceClickWidget(
                onTap: widget.saveOrderOnTap,
                child: Container(
                  height: 50,
                  margin: EdgeInsets.only(right: 5),
                  color: ColorUtils.darkChatBubbleColor,
                  child: Center(
                    child: Text('SAVE ORDER', style: size15(fw: FW.bold, fontColor: ColorUtils.whiteColor)),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        BounceClickWidget(
          onTap: widget.proceedToOrderOnTap,
          child: Container(
            height: 60,
            width: double.infinity,
            color: ColorUtils.darkChatBubbleColor,
            child: Center(
              child: Text('PROCEED TO ORDER', style: size20(fw: FW.bold, fontColor: ColorUtils.whiteColor)),
            ),
          ),
        ),
      ],
    );
  }
}
