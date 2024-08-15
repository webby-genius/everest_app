import 'package:everest/utils/colors.dart';
import 'package:everest/utils/common_styles.dart';
import 'package:everest/view/home_screen/home_provider.dart';
import 'package:everest/widgets/common_toast.dart';
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
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context,HomeProvider provider,_) {
        return Scaffold(
          body: 
              Column(
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
                            suffixIcon: Icon(Icons.document_scanner, size: 20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: TextButton(
                            onPressed: () {},
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
                                              FlutterToastWidget.show("SUCCESS", "error");
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Icon(Icons.filter_alt,
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
                                      final quantity = provider.basket[product] ?? 0;
                                      return Row(
                                        children: [
                                          assetPngUtils(
                                              assetImage: product.catImage ?? '', height: 70, width: 70),
                                          Expanded(
                                            flex: 5,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(product.catName ?? '', style: size14(fw: FW.medium)),
                                                Text("SKU: ${product.catSku}", style: size12(fw: FW.medium)),
                                                Text("PRICE: ${product.catPrice}",
                                                    style: size12(fw: FW.medium, fontColor: ColorUtils.primaryColor)),
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
                                      );
                                    },
                                  )
                                : Column(
                                    children: [
                                      Text("PROMOTION PAGE"),
                                    ],
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
                              "£${provider.basket.entries.fold(0, (sum, entry) => sum + (int.parse(entry.key.catPrice!.replaceAll('£', '')) * entry.value)).toStringAsFixed(2)}",
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
                              "£${provider.basket.entries.fold(0, (sum, entry) => sum + (int.parse(entry.key.catPrice!.replaceAll('£', '')) * entry.value)).toStringAsFixed(2)}",
                              style: size12(fw: FW.bold)),
                        ],
                      )),
                    ),
                    Expanded(
                      flex: 4,
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
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}



// class HomeScreen extends StatefulWidget {
//   AdvancedDrawerController advancedDrawerController;
//   HomeScreen({super.key, required this.advancedDrawerController});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Consumer(
//         builder: (context, HomeProvider provider, _) {
//           return Column(
//             children: [
//               Container(
//                 height: 115,
//                 width: double.infinity,
//                 color: ColorUtils.darkChatBubbleColor,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 20.0),
//                       child: TextButton(
//                         onPressed: () {
//                           widget.advancedDrawerController.showDrawer();
//                         },
//                         child: ValueListenableBuilder<AdvancedDrawerValue>(
//                             valueListenable: widget.advancedDrawerController,
//                             builder: (context, value, _) {
//                               return Icon(
//                                 value.visible ? Icons.clear : Icons.menu,
//                                 key: ValueKey<bool>(value.visible),
//                                 color: Colors.white,
//                                 size: 30,
//                               );
//                             }),
//                       ),
//                     ),
//                     Container(
//                       width: 230,
//                       height: 90,
//                       margin: EdgeInsets.only(bottom: 5),
//                       color: Colors.transparent,
//                       child: CustomTextFormField(
//                         hintText: "Search Product",
//                         controller: provider.searchProductController,
//                         suffixIcon: Icon(Icons.document_scanner, size: 20),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 20),
//                       child: TextButton(
//                         onPressed: () {},
//                         child: Icon(
//                           Icons.qr_code_scanner_sharp,
//                           color: Colors.white,
//                           size: 30,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: Column(
//                   children: [
//                     SizedBox(height: 5),
//                     Container(
//                       margin: EdgeInsets.symmetric(horizontal: 5),
//                       height: 50,
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: GestureDetector(
//                               onTap: () {
//                                 provider.selectCategory = 1;
//                               },
//                               child: Container(
//                                 height: 50,
//                                 decoration: BoxDecoration(
//                                   color: provider.selectCategory == 1 ? ColorUtils.darkChatBubbleColor : ColorUtils.blackColor20,
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 child: Center(
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         "CATEGORY",
//                                         style: size18(
//                                             fw: FW.bold,
//                                             fontColor:
//                                                 provider.selectCategory == 1 ? ColorUtils.whiteColor : ColorUtils.blackColor),
//                                       ),
//                                       GestureDetector(
//                                         onTap: () {
//                                           FlutterToastWidget.show("SUCCESS", "error");
//                                         },
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(10.0),
//                                           child: Icon(Icons.filter_alt,
//                                               color:
//                                                   provider.selectCategory == 1 ? ColorUtils.whiteColor : ColorUtils.blackColor),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 5),
//                           Expanded(
//                             child: GestureDetector(
//                               onTap: () {
//                                 provider.selectCategory = 2;
//                               },
//                               child: Container(
//                                 height: 50,
//                                 decoration: BoxDecoration(
//                                   color: provider.selectCategory == 2 ? ColorUtils.darkChatBubbleColor : ColorUtils.blackColor20,
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 child: Center(
//                                   child: Text(
//                                     "PROMOTIONS",
//                                     style: size18(
//                                         fw: FW.bold,
//                                         fontColor: provider.selectCategory == 2 ? ColorUtils.whiteColor : ColorUtils.blackColor),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 15.0),
//                         child: provider.selectCategory == 1
//                             ? ListView.builder(
//                                 itemCount: provider.categoryList.length,
//                                 padding: EdgeInsets.zero,
//                                 shrinkWrap: true,
//                                 physics: ClampingScrollPhysics(),
//                                 itemBuilder: (context, index) {
//                                   return Row(
//                                     children: [
//                                       assetPngUtils(
//                                           assetImage: provider.categoryList[index].catImage ?? '', height: 70, width: 70),
//                                       Expanded(
//                                         flex: 5,
//                                         child: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                             Text(provider.categoryList[index].catName ?? '', style: size14(fw: FW.medium)),
//                                             Text("SKU: ${provider.categoryList[index].catSku}", style: size12(fw: FW.medium)),
//                                             Text("PRICE: ${provider.categoryList[index].catPrice}",
//                                                 style: size12(fw: FW.medium, fontColor: ColorUtils.primaryColor)),
//                                           ],
//                                         ),
//                                       ),
//                                       Expanded(
//                                         flex: 3,
//                                         child: Container(
//                                           color: ColorUtils.successColor,
//                                           child: GestureDetector(
//                                             onTap: () {},
//                                             child: Center(
//                                               child: Padding(
//                                                 padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
//                                                 child: Text(
//                                                   "Add to Basket",
//                                                   style: size13(fw: FW.bold, fontColor: ColorUtils.whiteColor),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   );
//                                 },
//                               )
//                             : Column(
//                                 children: [
//                                   Text("PROMOTION PAGE"),
//                                 ],
//                               ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//       bottomNavigationBar: SafeAreaWidget(
//         color: ColorUtils.whiteColor,
//         isBottom: true,
//         child: Container(
//           height: 60,
//           width: double.infinity,
//           decoration: BoxDecoration(
//             color: ColorUtils.whiteColor,
//             boxShadow: const [
//               BoxShadow(
//                 offset: Offset(1, 0),
//                 blurRadius: 9,
//                 spreadRadius: 0.5,
//                 color: Colors.black12,
//               ),
//             ],
//           ),
//           child: Padding(
//             padding: const EdgeInsets.only(left: 10.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   flex: 2,
//                   child: Container(
//                       child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text("Lines", style: size14(fw: FW.bold)),
//                       Text("09", style: size12(fw: FW.bold)),
//                     ],
//                   )),
//                 ),
//                 Expanded(
//                   flex: 2,
//                   child: Container(
//                       child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text("Qty", style: size14(fw: FW.bold)),
//                       Text("95", style: size12(fw: FW.bold)),
//                     ],
//                   )),
//                 ),
//                 Expanded(
//                   flex: 3,
//                   child: Container(
//                       child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text("SubTotal", style: size14(fw: FW.bold)),
//                       Text("\£12345678 ", style: size12(fw: FW.bold)),
//                     ],
//                   )),
//                 ),
//                 Expanded(
//                   flex: 3,
//                   child: Container(
//                       child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text("Total", style: size14(fw: FW.bold)),
//                       Text("\£12345678", style: size12(fw: FW.bold)),
//                     ],
//                   )),
//                 ),
//                 Expanded(
//                   flex: 4,
//                   child: Container(
//                       color: ColorUtils.darkChatBubbleColor,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.shopping_cart_checkout_outlined,
//                             color: ColorUtils.whiteColor,
//                           ),
//                           Text(" CheckOut ", style: size14(fw: FW.bold, fontColor: ColorUtils.whiteColor)),
//                         ],
//                       )),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
