import 'package:everest/apis/api.dart';
import 'package:everest/apis/api_manager.dart';
import 'package:everest/apis/api_urls.dart';
import 'package:everest/apis/models/product_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BarcodeProvider extends ChangeNotifier {
  ProductItemResponse productItemResponse = ProductItemResponse();
  ProductItemResponse? scannedProduct;

  Future getItemByBarcodeApiResponse({required BuildContext context, required String barcode}) async {
    Map<String, String> parameter = {"Barcode": barcode};
    APIResponse response = await APIManager.callAPI(
      context: context,
      url: ApiUrlPage.getSingleItemByBarcodeUrl,
      type: APIMethodType.GET,
      body: parameter,
    );
    if (response.success) {
      productItemResponse = ProductItemResponse.fromJson(response.response);
      if (productItemResponse != null) {
        scannedProduct = productItemResponse;
      } else {}
    } else {}
    notifyListeners();
  }
}
