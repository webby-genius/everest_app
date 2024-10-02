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

// Order Item Model
class OrderItemModel {
  String productName;
  int quantity;
  int itemId;
  String price;

  OrderItemModel({
    required this.productName,
    required this.quantity,
    required this.itemId,
    required this.price,
  });

  // Helper method to extract price as double
  double get priceValue {
    return double.tryParse(price.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0.0;
  }

  double get totalPrice => priceValue * quantity;
}

// Main Order Summary Screen
class OrderSummaryScreen extends StatefulWidget {
  bool isDrawerScreen;
  ProductItemResponse? productItemResponse;
  AdvancedDrawerController? advancedDrawerController;
  final List<OrderItemModel> orderItems;

  OrderSummaryScreen({
    Key? key,
    required this.orderItems,
    this.isDrawerScreen = false,
    this.advancedDrawerController,
    this.productItemResponse,
  }) : super(key: key);

  @override
  State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, CheckOutProvider provider, _) {
      return CircularProgressIndicatorWidget(
        visible: provider.isLoading,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Your Order',
              style: size20(fw: FW.bold, fontColor: ColorUtils.whiteColor),
            ),
            backgroundColor: Color(0xFF2B3990),
            leading: widget.isDrawerScreen
                ? TextButton(
                    onPressed: () {
                      widget.advancedDrawerController?.showDrawer();
                    },
                    child: ValueListenableBuilder<AdvancedDrawerValue>(
                        valueListenable: widget.advancedDrawerController!,
                        builder: (context, value, _) {
                          return Icon(
                            value.visible ? Icons.clear : Icons.menu,
                            key: ValueKey<bool>(value.visible),
                            color: Colors.white,
                            size: 30,
                          );
                        }),
                  )
                : IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios, color: ColorUtils.whiteColor),
                  ),
          ),
          body: OrderSummary(orderItems: widget.orderItems),
          bottomNavigationBar: Container(
            height: 150,
            child: BottomButtons(
              continueShoppingOnTap: () {
                // Navigator.pushAndRemoveUntil(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => DashBoardScreen(),
                //     ),
                //     (route) => false);
              },
              proceedToOrderOnTap: () {},
              saveOrderOnTap: () {
                provider.checkOutSaveApiResponse(context: context, orderItems: widget.orderItems);
              },
            ),
          ),
        ),
      );
    });
  }
}

// Order Summary Widget
class OrderSummary extends StatelessWidget {
  final List<OrderItemModel> orderItems;

  OrderSummary({required this.orderItems});

  @override
  Widget build(BuildContext context) {
    double subtotal = orderItems.fold(
      0,
      (sum, item) => sum + item.totalPrice,
    );

    double total = subtotal;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("PRODUCT", style: size15(fw: FW.bold)),
                Text("SUBTOTAL", style: size15(fw: FW.bold)),
              ],
            ),
            Divider(color: ColorUtils.blackColor40),
            for (var item in orderItems)
              OrderItem(
                productName: item.productName,
                quantity: item.quantity,
                totalPrice: item.totalPrice,
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
            // BottomButtons(), Uncomment this if needed
          ],
        ),
      ),
    );
  }
}

// Order Item Widget
class OrderItem extends StatelessWidget {
  final String productName;
  final int quantity;
  final double totalPrice;

  OrderItem({
    required this.productName,
    required this.quantity,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, HomeProvider provider, _) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            productName,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Qty: $quantity"),
              Text('£${totalPrice.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.remove, color: quantity > 0 ? Colors.red : Colors.grey),
                    onPressed: quantity > 0 ? () => provider.removeFromBasket(provider.product) : null,
                  ),
                  Text('$quantity'),
                  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: GestureDetector(
                      child: Icon(Icons.add, color: Colors.green),
                      onTap: () => provider.addToBasket(provider.product),
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 8),
        ],
      );
    });
  }
}

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
            tileColor: ColorUtils.blackColor20,
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
            tileColor: ColorUtils.blackColor20,
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
                    child: Text(
                      'CONTINUE SHOPPING',
                      style: size15(fw: FW.bold, fontColor: ColorUtils.whiteColor),
                    ),
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
                    child: Text(
                      'SAVE ORDER',
                      style: size15(fw: FW.bold, fontColor: ColorUtils.whiteColor),
                    ),
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
              child: Text(
                'PROCEED TO ORDER',
                style: size20(fw: FW.bold, fontColor: ColorUtils.whiteColor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
