import 'package:everest/utils/colors.dart';
import 'package:everest/utils/common_styles.dart';
import 'package:everest/view/pending_order/pending_order_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';

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
  Widget build(BuildContext context) {
    return Consumer(builder: (context, PendingProvider provider, _) {
      return Scaffold(
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
                          title: Text(provider.pendingOrderList[index].invoiceId.toString()),
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
      );
    });
  }
}
