import 'package:everest/utils/colors.dart';
import 'package:everest/utils/common_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

// Order Item Model
class OrderItemModel {
  final String productName;
  final int quantity;
  final String price;

  OrderItemModel({
    required this.productName,
    required this.quantity,
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
  AdvancedDrawerController? advancedDrawerController;
  final List<OrderItemModel> orderItems;

  OrderSummaryScreen({
    Key? key,
    required this.orderItems,
    this.isDrawerScreen = false,
    this.advancedDrawerController,
  }) : super(key: key);

  @override
  State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      bottomNavigationBar: Container(height: 150, child: BottomButtons()),
    );
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          productName,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Qty: $quantity"),
            Text('£${totalPrice.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        SizedBox(height: 8),
      ],
    );
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
  String selectedOption = 'Click & Collect';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioListTile(
          value: "Click & Collect",
          title: Text('CLICK & COLLECT', style: size16(fw: FW.medium)),
          tileColor: ColorUtils.blackColor20,
          groupValue: selectedOption,
          activeColor: ColorUtils.darkChatBubbleColor,
          onChanged: (value) {
            setState(() {
              selectedOption = value!;
            });
          },
        ),
        SizedBox(height: 1),
        RadioListTile(
          value: "Delivery Order",
          title: Text('DELIVERY ORDER', style: size16(fw: FW.medium)),
          groupValue: selectedOption,
          activeColor: ColorUtils.darkChatBubbleColor,
          tileColor: ColorUtils.blackColor20,
          onChanged: (value) {
            setState(() {
              selectedOption = value!;
            });
          },
        ),
      ],
    );
  }
}

// Bottom Buttons Widget
class BottomButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
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
            SizedBox(width: 5),
            Expanded(
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
          ],
        ),
        SizedBox(height: 10),
        Container(
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
      ],
    );
  }
}
