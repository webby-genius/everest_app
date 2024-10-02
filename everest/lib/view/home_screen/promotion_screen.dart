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
    return Consumer(builder: (context, HomeProvider provider, _) {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 210,
          childAspectRatio: 0.65,
          mainAxisSpacing: 20,
          crossAxisSpacing: 16,
        ),
        itemCount: widget.categoryList.length,
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          final product = widget.categoryList[index];
          final quantity = widget.basket[product] ?? 0;
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                product.itemImage != 0
                    ? networkPngUtils(networkImage: product.itemImage.toString(), height: 100, fit: BoxFit.contain)
                    : assetPngUtils(assetImage: "assets/image/everest_wholesale logo.png", height: 110, width: 150),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.itemName ?? '', style: size14(fw: FW.medium)),
                    Text("PRICE: £${product.salePrice}", style: size12(fw: FW.medium, fontColor: ColorUtils.primaryColor)),
                    Text("PLU Code: ${product.pluCode}", style: size12(fw: FW.medium)),
                    if (quantity > 0) ...{
                      Container(
                        // decoration: BoxDecoration(border: Border.all()),
                        width: 140,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                        ),
                      )
                    } else ...{
                      BounceClickWidget(
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
                    }
                  ],
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
