import 'package:everest/utils/colors.dart';
import 'package:everest/utils/common_styles.dart';
import 'package:everest/view/my_account/my_account_provider.dart';
import 'package:everest/widgets/LoadingWidget.dart';
import 'package:everest/widgets/row_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';

class MyAccountScreen extends StatefulWidget {
  AdvancedDrawerController advancedDrawerController;
  MyAccountScreen({super.key, required this.advancedDrawerController});

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  @override
  void initState() {
    final provider = Provider.of<MyAccountProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider.userInfoApiResponse(context: context);
    });
    super.initState();
  }

  @override
  void dispose() {
    // widget.advancedDrawerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, MyAccountProvider provider, _) {
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
              "My Account",
              style: size20(fontColor: ColorUtils.whiteColor, fw: FW.bold),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text("Business Name", style: size20(fw: FW.bold)),
                Container(
                  decoration: BoxDecoration(
                    color: ColorUtils.whiteColor,
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 1),
                        blurRadius: 12,
                        spreadRadius: 0.5,
                        color: Colors.black26,
                      ),
                    ],
                    border: Border.all(),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Shipping Address", style: size20(fw: FW.bold)),
                      SizedBox(height: 10),
                      RowText(text1: "Contact Person", text2: provider.userInfoResponse.contactPerson ?? ''),
                      RowText(text1: "Company Name", text2: provider.userInfoResponse.businessName ?? ''),
                      RowText(text1: "Street Address", text2: provider.userInfoResponse.addressLine1 ?? ''),
                      RowText(text1: "Town/City, Country/Region", text2: provider.userInfoResponse.city ?? ''),
                      RowText(text1: "Postcode", text2: provider.userInfoResponse.postCode ?? ''),
                      RowText(text1: "Phone Number", text2: provider.userInfoResponse.telephone ?? ''),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: ColorUtils.whiteColor,
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 1),
                        blurRadius: 12,
                        spreadRadius: 0.5,
                        color: Colors.black26,
                      ),
                    ],
                    border: Border.all(),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Billing Address", style: size20(fw: FW.bold)),
                      SizedBox(height: 10),
                      RowText(text1: "Contact Person", text2: provider.userInfoResponse.billingContactPerson ?? ''),
                      RowText(text1: "Company Name", text2: provider.userInfoResponse.businessName ?? ''),
                      RowText(text1: "Street Address", text2: provider.userInfoResponse.billingAddressLine1 ?? ''),
                      RowText(text1: "Town/City, Country/Region", text2: provider.userInfoResponse.billingCity ?? ''),
                      RowText(text1: "Postcode", text2: provider.userInfoResponse.billingPostCode ?? ''),
                      RowText(text1: "Phone Number", text2: provider.userInfoResponse.billingTelephone ?? ''),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
