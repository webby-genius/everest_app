import 'package:everest/utils/colors.dart';
import 'package:everest/utils/common_styles.dart';
import 'package:everest/view/pending_order/pending_order_provider.dart';
import 'package:everest/widgets/LoadingWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';

bool isPendingScreenTap = false;

class PandingOrderScreen extends StatefulWidget {
  AdvancedDrawerController advancedDrawerController;
  PandingOrderScreen({super.key, required this.advancedDrawerController});

  @override
  State<PandingOrderScreen> createState() => _PandingOrderScreenState();
}

class _PandingOrderScreenState extends State<PandingOrderScreen> {
  @override
  void initState() {
    final provider = Provider.of<PendingProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider.getCustomerOrdersApiResponse(context: context);
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    debugPrint("😃😃😃😃😃😃😃😃😃😃😃😃😃😃😃😃😃😃😃😃😃😃😃😃");

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (isPendingScreenTap) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Provider.of<PendingProvider>(context, listen: false).getCustomerOrdersApiResponse(context: context);
        debugPrint("😃😃😃😃😃😃😃😃😃😃😃");
        isPendingScreenTap = false;
      });
    }
    return Consumer(builder: (context, PendingProvider provider, _) {
      return CircularProgressIndicatorWidget(
        visible: provider.isLoading,
        child: Scaffold(
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
              "Pending Order",
              style: size20(fontColor: ColorUtils.whiteColor, fw: FW.bold),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                provider.pendingOrderList.isNotEmpty
                    ? ListView.builder(
                        itemCount: provider.pendingOrderList.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            // dense: true,
                            title: Text("Order #${provider.pendingOrderList[index].invoiceId.toString()}"),
                            subtitle: Text(provider.pendingOrderList[index].invoiceStatus ?? ''),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Total: ${provider.pendingOrderList[index].totalAmount}",
                                  style: size14(),
                                ),
                                provider.pendingOrderList[index].dueAmount == 0.0
                                    ? Text(
                                        "Paid",
                                        style: size14(fontColor: ColorUtils.paidColor),
                                      )
                                    : Text(
                                        "Due: ${provider.pendingOrderList[index].dueAmount}",
                                        style: size14(fontColor: ColorUtils.errorColor),
                                      ),
                              ],
                            ),
                          );
                        },
                      )
                    : Visibility(
                        visible: provider.isShowNoData,
                        child: const Text('No order Found.'),
                      ),
              ],
            ),
          ),
        ),
      );
    });
  }
}






// class PandingOrderScreen extends StatefulWidget {
//   final AdvancedDrawerController advancedDrawerController;

//   PandingOrderScreen({super.key, required this.advancedDrawerController});

//   @override
//   State<PandingOrderScreen> createState() => _PandingOrderScreenState();
// }

// class _PandingOrderScreenState extends State<PandingOrderScreen> {
//   late Future<void> _fetchOrders;

//   @override
//   void initState() {
//     super.initState();
//     _fetchOrders = _getCustomerOrders();
//   }

//   Future<void> _getCustomerOrders() async {
//     final provider = Provider.of<PendingProvider>(context, listen: false);
//     await provider.getCustomerOrdersApiResponse(context: context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<PendingProvider>(
//       builder: (context, provider, _) {
//         return Scaffold(
//           appBar: AppBar(
//             backgroundColor: ColorUtils.darkChatBubbleColor,
//             leading: TextButton(
//               onPressed: () {
//                 widget.advancedDrawerController.showDrawer();
//               },
//               child: ValueListenableBuilder<AdvancedDrawerValue>(
//                 valueListenable: widget.advancedDrawerController,
//                 builder: (context, value, _) {
//                   return Icon(
//                     value.visible ? Icons.clear : Icons.menu,
//                     key: ValueKey<bool>(value.visible),
//                     color: Colors.white,
//                   );
//                 },
//               ),
//             ),
//             title: Text(
//               "Pending Order",
//               style: size20(fontColor: ColorUtils.whiteColor, fw: FW.bold),
//             ),
//           ),
//           body: FutureBuilder<void>(
//             future: _fetchOrders,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(child: CircularProgressIndicator());
//               } else if (snapshot.hasError) {
//                 return Center(child: Text('Error: ${snapshot.error}'));
//               } else {
//                 return SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       provider.pendingOrderList.isNotEmpty
//                           ? ListView.builder(
//                               itemCount: provider.pendingOrderList.length,
//                               physics: NeverScrollableScrollPhysics(),
//                               shrinkWrap: true,
//                               itemBuilder: (context, index) {
//                                 return ListTile(
//                                   title: Text(provider.pendingOrderList[index].invoiceId.toString()),
//                                 );
//                               },
//                             )
//                           : Visibility(
//                               visible: provider.isShowNoData,
//                               child: const Text('No orders found.'),
//                             ),
//                     ],
//                   ),
//                 );
//               }
//             },
//           ),
//         );
//       },
//     );
//   }
// }


