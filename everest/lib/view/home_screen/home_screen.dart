import 'package:everest/utils/colors.dart';
import 'package:everest/utils/common_styles.dart';
import 'package:everest/view/barcode_screen/barcode_scanner_screen.dart';
import 'package:everest/view/checkout_screen/check_out_screen.dart';
import 'package:everest/view/home_screen/home_provider.dart';
import 'package:everest/view/home_screen/promotion_screen.dart';
import 'package:everest/widgets/LoadingWidget.dart';
import 'package:everest/widgets/button/center_text_button_widget.dart';
import 'package:everest/widgets/custom_images/asset_utils.dart';
import 'package:everest/widgets/custom_safearea.dart';
import 'package:everest/widgets/custom_textfield/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final AdvancedDrawerController advancedDrawerController;

  HomeScreen({super.key, required this.advancedDrawerController});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    final provider = Provider.of<HomeProvider>(context, listen: false);
    provider.basket.clear();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider.productListApiResponse(context: context);
      provider.categoryApiResponse(context: context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, HomeProvider provider, _) {
      return Scaffold(
        body: CircularProgressIndicatorWidget(
          visible: provider.isLoading,
          child: Column(
            children: [
              Container(
                height: 115,
                width: double.infinity,
                color: ColorUtils.darkChatBubbleColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: TextButton(
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
                                size: 30,
                              );
                            }),
                      ),
                    ),
                    Container(
                      width: 230,
                      height: 90,
                      margin: EdgeInsets.only(bottom: 5),
                      color: Colors.transparent,
                      child: CustomTextFormField(
                        hintText: "Search Product",
                        controller: provider.searchProductController,
                        // suffixIcon: GestureDetector(
                        //   onTap: () {
                        //     FocusScope.of(context).unfocus();
                        //   },
                        //   child: Icon(Icons.document_scanner, size: 20),
                        // ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BarcodeScanScreen(),
                              ));
                        },
                        child: Icon(
                          Icons.qr_code_scanner_sharp,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    SizedBox(height: 5),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      height: 50,
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                provider.selectCategory = 1;
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: provider.selectCategory == 1 ? ColorUtils.darkChatBubbleColor : ColorUtils.blackColor20,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "CATEGORY",
                                        style: size18(
                                            fw: FW.bold,
                                            fontColor:
                                                provider.selectCategory == 1 ? ColorUtils.whiteColor : ColorUtils.blackColor),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          showCategoryFilterDialog();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 5),
                                          child: Icon(Icons.filter_alt,
                                              size: 28,
                                              color:
                                                  provider.selectCategory == 1 ? ColorUtils.whiteColor : ColorUtils.blackColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                provider.selectCategory = 2;
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: provider.selectCategory == 2 ? ColorUtils.darkChatBubbleColor : ColorUtils.blackColor20,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    "PROMOTIONS",
                                    style: size18(
                                        fw: FW.bold,
                                        fontColor: provider.selectCategory == 2 ? ColorUtils.whiteColor : ColorUtils.blackColor),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: provider.selectCategory == 1
                            ? ListView.builder(
                                itemCount: provider.categoryList.length,
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final product = provider.categoryList[index];
                                  provider.quantity = provider.basket[product] ?? 0;
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
                                    margin: EdgeInsets.symmetric(vertical: 2),
                                    child: Row(
                                      children: [
                                        product.itemImage != 0
                                            ? networkPngUtils(networkImage: product.itemImage.toString(), height: 70, width: 70)
                                            : assetPngUtils(
                                                assetImage: "assets/image/everest_wholesale logo.png", height: 70, width: 70),
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
                                            child: provider.quantity > 0
                                                ? Row(
                                                    children: [
                                                      IconButton(
                                                        icon: Icon(Icons.remove, color: provider.quantity > 0 ? Colors.red : Colors.grey),
                                                        onPressed: provider.quantity > 0 ? () => provider.removeFromBasket(product) : null,
                                                      ),
                                                      Text('${provider.quantity}'),
                                                      Padding(
                                                        padding: const EdgeInsets.all(7.0),
                                                        child: GestureDetector(
                                                          child: Icon(Icons.add, color: Colors.green),
                                                          onTap: () => provider.addToBasket(product),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : CenterTextButtonWidget(
                                                    height: 30,
                                                    width: 200,
                                                    onTap: () => provider.addToBasket(product),
                                                    decoration: BoxDecoration(
                                                      color: ColorUtils.successColor,
                                                    ),
                                                    title: " Add to Basket ",
                                                    style: size12(fw: FW.bold, fontColor: ColorUtils.whiteColor),
                                                    gradientColor: ColorUtils.greenColorGradient,
                                                  )
                                            // GestureDetector(
                                            //     onTap: () => provider.addToBasket(product),
                                            //     child: Container(
                                            //       color: ColorUtils.successColor,
                                            //       child: Center(
                                            //         child: Padding(
                                            //           padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                                            //           child: Text(
                                            //             "Add to Basket",
                                            //             style: size13(fw: FW.bold, fontColor: ColorUtils.whiteColor),
                                            //           ),
                                            //         ),
                                            //       ),
                                            //     ),
                                            //   ),
                                            ),
                                      ],
                                    ),
                                  );
                                },
                              )
                            : PromotionScreen(
                                categoryList: provider.categoryList,
                                basket: provider.basket,
                              ),
                        // Column(
                        //     children: [
                        //       Text("PROMOTION PAGE"),
                        //     ],
                        //   ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: SafeAreaWidget(
          color: ColorUtils.whiteColor,
          isBottom: true,
          child: Container(
            height: 60,
            width: double.infinity,
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
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Lines", style: size14(fw: FW.bold)),
                        Text("${provider.basket.length}", style: size12(fw: FW.bold)),
                      ],
                    )),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Qty", style: size14(fw: FW.bold)),
                        Text("${provider.basket.values.fold(0, (sum, quantity) => sum + quantity)}", style: size12(fw: FW.bold)),
                      ],
                    )),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("SubTotal", style: size14(fw: FW.bold)),
                        Text(
                            "£${provider.basket.entries.fold(0.00, (sum, entry) => sum + (double.parse(entry.key.salePrice.toString()) * entry.value)).toStringAsFixed(2)}",
                            // "£${provider.basket.entries.fold(0, (sum, entry) => sum + (int.parse(entry.key.salePrice.toString()) * entry.value)).toStringAsFixed(2)}",
                            style: size12(fw: FW.bold)),
                      ],
                    )),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Total", style: size14(fw: FW.bold)),
                        Text(
                            "£${provider.basket.entries.fold(0.00, (sum, entry) => sum + (double.parse(entry.key.salePrice.toString()) * entry.value)).toStringAsFixed(2)}",
                            style: size12(fw: FW.bold)),
                      ],
                    )),
                  ),
                  Expanded(
                    flex: 4,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderSummaryScreen(
                              orderItems: provider.basket.entries.map((entry) {
                                return OrderItemModel(
                                  productName: entry.key.itemName ?? '',
                                  quantity: entry.value,
                                  price: entry.key.salePrice.toString(),
                                  itemId: entry.key.itemId ?? 0,
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      },
                      child: Container(
                          color: ColorUtils.darkChatBubbleColor,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shopping_cart_checkout_outlined,
                                color: ColorUtils.whiteColor,
                              ),
                              Text(" CheckOut ", style: size14(fw: FW.bold, fontColor: ColorUtils.whiteColor)),
                            ],
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

// }
  void showCategoryFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Category"),
          backgroundColor: ColorUtils.whiteColor,
          content: Consumer<HomeProvider>(
            builder: (context, provider, _) {
              return SizedBox(
                width: double.maxFinite,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: provider.categories.length,
                  itemBuilder: (context, index) {
                    final category = provider.categories[index];
                    final isSelected = provider.selectedCategory == category.categoryName;
                    return ListTile(
                      title: Text(
                        category.categoryName ?? '',
                        style: size15(fontColor: isSelected ? ColorUtils.whiteColor : ColorUtils.blackColor),
                      ),
                      tileColor: isSelected ? ColorUtils.darkChatBubbleColor : Colors.transparent,
                      onTap: () {
                        provider.selectItemCategory(category.categoryName ?? '');
                        Navigator.of(context).pop();
                      },
                    );
                  },
                ),
              );
            },
          ),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
